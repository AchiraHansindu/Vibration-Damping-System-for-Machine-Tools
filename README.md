# **Vibration Damping System for Machine Tools**

## Overview
This repository contains the design and implementation details of a Vibration Damping System developed for machine tools. The system is designed to significantly reduce mechanical vibrations, which can degrade performance and increase wear and tear on machinery.

## Project Scope

This project is done as a partial fulfillment for EN2160: Electronic Design Realization module in the Semester 4 curriculum in the Department of Electronic and Telecommunication Engineering at University of Moratuwa, Sri Lanka.

This project was aimed to design and develop an industry level solution. Accordingly, a hardware-software co-solution is developed including PCB, Enclosure, Software, and Firmware.

## Components
- **Data Acquisition System:** Utilizes accelerometers to measure vibrations and a microcontroller to process data.
- **Vibration Analysis Software:** MATLAB scripts and an app designed for processing and analyzing vibration data.
- **Spring and Damper System:** Custom designed spring and damper system to the specific vibration characteristics of the machinery.

<div align="center">
    <img src="https://github.com/user-attachments/assets/dfb7ba60-1013-441c-850b-dc857f559b13" width="400" alt="Data Acquisition System">
    <br>
    <em>Data Acquisition System</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/e375dc97-59d5-4b40-9fea-90be2f2c5bfc" width="400" alt="Data Acquisition System">
    <br>
    <em>Custom Built Shock Absorber</em>
</div>


## Features
- **Real-time Vibration Monitoring:** Leverages a MPU6050 accelerometer to monitor vibrations in real time.
- **FFT Analysis:** Implements Fast Fourier Transform (FFT) for detailed frequency analysis to calculate the desing parameters for the shock absorber system.
- **Shock Absorber Efficiency Measurement:** Compares vibration data before and after shock absorber implementation to evaluate efficiency.

## PCB Design
- **Tools & Software:** Designed with Altium Designer, our 2-layer PCB features the ATmega328P-AU microcontroller and CH340C Serial UART IC, ensuring robust performance and reliable communication.
- **Design Philosophy:** Special attention has been given to the routing of power lines to reduce voltage drops and ensure signal integrity.

<div align="center">
    <img src="https://github.com/user-attachments/assets/c27a9241-55ca-4864-bf96-3e056a705f44" width="400" alt="Bare PCB">
    <br>
    <em>Bare PCB</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/db34daf3-b839-4bb2-abd9-f1310d08f359" width="400" alt="Soldered PCB">
    <br>
    <em>Soldered PCB</em>
</div>

PCB design files and schematics can be found [here](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/tree/main/PCB%20Files).

## Firmware Design
- **Microcontroller Programming:** The microcontroller in programmed in C++, using register level programming such as IO port manipulation, UART and I2C communication, sampling accelerometer reading with given sampling frequency.

The code can be found [here](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/tree/main/Microcontroller%20AVR%20code).

## Enclosure Design
- Comprises two parts; the Main Controller Unit and the Accelerometer Holding Part, both designed in SOLIDWORKS and produced via 3D printing.

<div align="center">
    <img src="https://github.com/user-attachments/assets/edb97cfd-28ad-49bf-8856-6f483181dbb9" width="400" alt="Main Controller Unit">
    <br>
    <em>Main Controller Unit</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/48d49e3d-76d5-49b3-a511-4c8556a7a3f4" width="400" alt="Accelerometer Holding Part">
    <br>
    <em>Accelerometer Holding Part</em>
</div>

Enclosure design files can be found [here](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/tree/main/Enclosure%20Design-SolidWorks).

## Software Design

### Front-End Software: UI for Data Acquisition System

The Front-End Software for the Vibration Data Acquisition System streamlines interaction between the DAQ device and the user. Developed using Python and PyQt5, the application features a user-friendly graphical interface for starting, stopping, and saving vibration data.

#### Key Features:
- **Initial Setup:** Users begin at a launch screen and proceed to select communication settings like COM port and baud rate.
- **Data Collection Controls:** Provides options to start and stop the recording and to save the captured data with user-defined settings.
- **Efficient Data Management:** After collection, data can be saved through a dialog that captures file details and confirms the save location.

This intuitive interface supports efficient data handling and simplifies the user's interaction with the system.

<div align="center">
    <img src="https://github.com/user-attachments/assets/19c372fd-04b6-4320-bfaa-2f5cad3edcd4" width="400" alt="Screen for selecting the available COM port and baud rate.">
    <br>
    <em>Screen for selecting the available COM port and baud rate.</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/b09d611a-c0bc-45be-a56a-b72548f90c7e" width="400" alt="Screen for controlling data collection.">
    <br>
    <em>Screen for controlling data collection.</em>
</div>

The code can be found [here](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/tree/main/UI%20for%20Data%20Acquisition%20System).

### MATLAB Application for Data Analysis

The MATLAB Application for Data Analysis enhances the vibration-damping system by providing detailed processing and visualization of vibrational data collected from machine tools. Developed to support engineers and researchers, this application includes multiple analytical tools and visualization methods.

#### Key Features:
- **Data Visualization:** Plots acceleration data along the X, Y, and Z axes, directly from CSV files generated by the DAQ system, providing immediate visual insight into the vibrational characteristics of the machine tools.
- **Frequency Spectrum Analysis:** Employs Fast Fourier Transform (FFT) to convert time-domain data into frequency-domain data, identifying dominant frequencies that are crucial for the subsequent design of effective vibration-damping solutions.
- **System Parameters Calculation:** Automatically extracts essential parameters such as natural frequency and damping ratio from FFT results. Users can further input mechanical properties like mass and piston diameter to compute critical damping characteristics, aiding in the precise design of the shock absorber.
- **Performance Comparison:** Facilitates loading and comparing vibration data before and after the implementation of damping solutions. 

This MATLAB application is a pivotal part of the software design, bridging data acquisition with actionable analysis, thus supporting both the design and evaluation stages of the vibration-damping system.

<div align="center">
    <img src="https://github.com/user-attachments/assets/54a0099b-00d0-4bf2-aa44-087156967db6" width="400" alt="Window showing FFT for X, Y, and Z axes.">
    <br>
    <em>Window showing FFT for X, Y, and Z axes.</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/af9aeaa6-95bc-4b4e-9ba4-4cb4fb53d04d" width="400" alt="System parameters calculation window.">
    <br>
    <em>System parameters calculation window.</em>
</div>

The code can be found [here](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/tree/main/MATLAB%20Application%20for%20Data%20Analysis).

## System Integration

The following images show some steps of system integration including wiring, assembling.

<div align="center">
    <img src="https://github.com/user-attachments/assets/c8fd2de1-e171-4a45-b07c-a29f3d4b8648" width="400" alt="">
    <br>
    <em></em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/801821f6-650b-4148-aebb-149656b31919" width="400" alt="">
    <br>
    <em></em>
</div>

## Demonstration

To visually demonstrate the effectiveness of the Vibration Damping System, we have included videos and FFT analysis both before and after the implementation of the shock absorber.

### Videos

1. **Before Shock Absorber Implementation:**
   - This video showcases the system operating without the shock absorber, highlighting the initial vibration levels and rotation.

   https://github.com/user-attachments/assets/478091ad-a99a-40b5-b485-41ef5b800e22
   


2. **After Shock Absorber Implementation:**
   - This video demonstrates the system with the shock absorber installed, showing a significant reduction in vibrations and rotation.

   https://github.com/user-attachments/assets/1908306d-d9c9-451e-9375-d828b028359c


### FFT Analysis

- **FFT Before Implementation:**
  - The FFT analysis before implementing the shock absorber shows higher amplitude peaks at natural frequencies.

  <div align="center">
    <img src="https://github.com/user-attachments/assets/7fdcecaf-d3b9-4336-8294-1be44d645254" width="400" alt="FFT before implementing the damper">
    <br>
    <em>FFT before implementing the damper</em>
</div>

- **FFT After Implementation:**
  - After the shock absorber installation, the FFT analysis displays a noticeable reduction in peak amplitudes.

  <div align="center">
    <img src="https://github.com/user-attachments/assets/ee4f2407-5420-49cb-84e0-f4201efcc0a8" width="400" alt="FFT after implementing the damper">
    <br>
    <em>FFT after implementing the damper</em>
</div>

This side-by-side comparison not only validates the design but also provides concrete evidence of the system's performance improvements.

## Documents Related to the Project

For a deeper understanding of our Vibration Damping System, detailed documentation is available. Below are the links to various documents that cover all aspects of the project:

1. [Design Methodology Document](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/blob/main/Project%20Documents/Design_Methodology_Document_Vibration_Damping%20System_for_Machine_Tools.pdf) 
2. [Comprehensive Design Document](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/blob/main/Project%20Documents/Design_Document_Vibration_Damping%20System_for_Machine_Tools.pdf) 

Feel free to explore these resources to gain a comprehensive understanding of the project's scope and execution.
