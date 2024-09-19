/**
 * @file MPU_Accel_Measurement.c
 * @brief Implements accelerometer data reading using MPU6050 and TWI.
 * 
 * This file contains the main logic to initialize the MPU6050 sensor, configure 
 * Timer1 for periodic interrupts, and read and process accelerometer data.
 * 
 * @Achira Hansindu
 * @date 14-Aug-24
 * @version 1.0
 */


#include "uart.h"                 // Include UART library for serial communication
#include "twi_master.h"           // Include TWI (I2C) library for communication with MPU6050
#include <avr/io.h>               // Include AVR I/O library for accessing registers
#include <avr/interrupt.h>        // Include AVR interrupt library for handling interrupts
#include <stdio.h>                // Include standard I/O library for printf function

#define MPU_ADDRESS       0x68    // I2C address of the MPU6050 sensor
#define ACCEL_X_H         0x3B    // Register address for high byte of X-axis accelerometer data
#define ACCEL_X_L         0x3C    // Register address for low byte of X-axis accelerometer data
#define ACCEL_Y_H         0x3D    // Register address for high byte of Y-axis accelerometer data
#define ACCEL_Y_L         0x3E    // Register address for low byte of Y-axis accelerometer data
#define ACCEL_Z_H         0x3F    // Register address for high byte of Z-axis accelerometer data
#define ACCEL_Z_L         0x40    // Register address for low byte of Z-axis accelerometer data
#define PWR_MGMT          0x6B    // Register address for power management

typedef struct
{
	float x_axis;                 // Floating point variable to store X-axis acceleration
	float y_axis;                 // Floating point variable to store Y-axis acceleration
	float z_axis;                 // Floating point variable to store Z-axis acceleration
} accel_t;

volatile uint32_t millis_count = 0;   // Counter for milliseconds
volatile uint8_t sec_count = 0;       // Counter for seconds
volatile uint8_t min_count = 0;       // Counter for minutes
volatile uint8_t read_flag = 0;       // Flag to indicate that it's time to read data

// Function to configure Timer1 for 1ms intervals
void timer1_config(void)
{
	TCCR1B |= (1 << WGM12);          // Set Timer1 to CTC mode
	TIMSK1 |= (1 << OCIE1A);         // Enable interrupt on compare match
	OCR1A = 249;                     // Set compare value for 1ms interval
	TCCR1B |= (1 << CS11) | (1 << CS10); // Start Timer1 with prescaler 64
}

// Function to handle errors by checking return codes
void handle_error(ret_code_t code)
{
	if (code != SUCCESS)             // If the code is not SUCCESS, there is an error
	{
		printf(BR "Error! Code = 0x%02X\n" RESET, code); // Print the error code
		while (1);                // Infinite loop to halt execution on error
	}
}

// Function to initialize the MPU6050 sensor
void mpu_initialize(void)
{
	ret_code_t code;
	uint8_t config_data[2] = {PWR_MGMT, 0}; // Data to wake up the MPU6050 (write 0 to PWR_MGMT register)
	code = tw_master_transmit(MPU_ADDRESS, config_data, sizeof(config_data), false); // Send data over I2C
	handle_error(code);              // Check if the transmission was successful
}

// Function to read raw accelerometer data from the MPU6050
void get_accel_raw(accel_t* accel_data)
{
	ret_code_t code;
	uint8_t data_buffer[6];          // Buffer to store the raw data from the sensor

	data_buffer[0] = ACCEL_X_H;      // Start reading from the X-axis high byte register
	code = tw_master_transmit(MPU_ADDRESS, data_buffer, 1, true); // Send register address
	handle_error(code);              // Check if the transmission was successful

	code = tw_master_receive(MPU_ADDRESS, data_buffer, sizeof(data_buffer)); // Read data from MPU6050
	handle_error(code);              // Check if the reception was successful

	// Combine high and low bytes and convert to floating-point values
	accel_data->x_axis = (int16_t)(data_buffer[0] << 8 | data_buffer[1]) / 16384.0;
	accel_data->y_axis = (int16_t)(data_buffer[2] << 8 | data_buffer[3]) / 16384.0;
	accel_data->z_axis = (int16_t)(data_buffer[4] << 8 | data_buffer[5]) / 16384.0;
}

// Function to convert raw accelerometer data to physical units (m/s^2)
void convert_accel_data(accel_t* accel_data)
{
	get_accel_raw(accel_data);       // Call function to get raw data
	accel_data->x_axis *= 9.81;      // Convert X-axis data to m/s^2
	accel_data->y_axis *= 9.81;      // Convert Y-axis data to m/s^2
	accel_data->z_axis *= 9.81;      // Convert Z-axis data to m/s^2
}

// Function to format a timestamp as a string
void format_timestamp(char *buffer)
{
	uint32_t milliseconds;
	uint8_t seconds, minutes, hours;

	cli();                           // Disable interrupts to prevent data inconsistency
	milliseconds = millis_count;     // Get current milliseconds count
	seconds = sec_count;             // Get current seconds count
	minutes = min_count;             // Get current minutes count
	sei();                           // Re-enable interrupts

	hours = minutes / 60;            // Calculate hours from minutes
	minutes = minutes % 60;          // Calculate remaining minutes

	// Format the timestamp as "HH.MM.SS.mmm"
	sprintf(buffer, "%02u.%02u.%02u.%03lu", hours, minutes, seconds, milliseconds % 1000);
}

// Interrupt Service Routine (ISR) for Timer1 Compare Match A
ISR(TIMER1_COMPA_vect)
{
	millis_count++;                  // Increment milliseconds counter

	if (millis_count >= 1000) {      // If 1000 milliseconds have passed
		millis_count = 0;           // Reset milliseconds counter
		sec_count++;                // Increment seconds counter
		
		if (sec_count >= 60) {      // If 60 seconds have passed
			sec_count = 0;         // Reset seconds counter
			min_count++;           // Increment minutes counter
			
			if (min_count >= 60) {  // If 60 minutes have passed
				min_count = 0;     // Reset minutes counter (one hour passed)
			}
		}
	}
	
	read_flag = 1;                   // Set flag to indicate it's time to read data
}

int main(void)
{
	uart_init(250000);               // Initialize UART with a baud rate of 250000
	cli_reset();                     // Clear interrupt flag and reset configuration
	puts(BY "MPU Accelerometer Measurement Started...\n" RESET); // Print start message
	
	tw_init(TW_FREQ_400K, true);     // Initialize TWI (I2C) with 400kHz frequency and internal pull-up resistors
	mpu_initialize();                // Initialize the MPU6050 sensor
	timer1_config();                 // Configure Timer1 for timing operations
	sei();                           // Enable global interrupts

	accel_t accel_data;              // Create a variable to store accelerometer data
	char time_buffer[20];            // Buffer to store the timestamp
	
	puts(BG CURSOR_RIGHT("14")
	"--------------- Application Running ---------------\n" RESET); // Print running message
	
	while (1)
	{
		if (read_flag)              // Check if the read_flag is set
		{
			read_flag = 0;         // Clear the read_flag
			convert_accel_data(&accel_data); // Convert raw accelerometer data to physical units
			
			// Print the accelerometer data
			printf("AX %5.2f ", accel_data.x_axis);
			printf("AY %5.2f ", accel_data.y_axis);
			printf("AZ %5.2f ", accel_data.z_axis);
			
			format_timestamp(time_buffer);  // Create a formatted timestamp
			printf("%s\n", time_buffer);    // Print the timestamp
		}
	}
}
