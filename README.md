# **Vibration Damping System for Machine Tools**

## Overview
This repository contains the design and implementation details of a Vibration Damping System developed for machine tools. The system is designed to significantly reduce mechanical vibrations, which can degrade performance and increase wear and tear on machinery.

## Project Scope

This project is done as a partial fulfillment for EN2160: Electronic Design Realization module in the Semester 4 curriculum in the Department of Electronic and Telecommunication Engineering at University of Moratuwa, Sri Lanka.

This project was aimed to design and develop an industry level solution. Accordingly, a hardware-software co-solution is developed including PCB, Enclosure, Software, and Firmware.

## Components
- **Data Acquisition System:** Utilizes accelerometers to measure vibrations and a microcontroller to process data.
- **Vibration Analysis Software:** MATLAB scripts for processing and analyzing vibration data.
- **Spring and Damper System:** Custom-built hardware to physically damp vibrations.

## ![Data Acquisition System](https://github.com/user-attachments/assets/dfb7ba60-1013-441c-850b-dc857f559b13)
## Features
- **Real-time Vibration Monitoring:** Leverages a high-performance MPU6050 accelerometer to monitor vibrations in real time.
- **FFT Analysis:** Implements Fast Fourier Transform (FFT) for detailed frequency analysis.
- **Shock Absorber Efficiency Measurement:** Compares vibration data before and after shock absorber implementation to evaluate efficiency.

## Hardware
- **Accelerometer (MPU6050):** Measures acceleration in three axes.
- **Microcontroller (ATmega2560):** Manages data acquisition from the accelerometer.
- **Shock Absorber System:** Custom designed springs and dampers tailored to the specific vibration characteristics of the machinery.

## Software
- **Data Acquisition and Processing:** Scripts and programs for acquiring and processing vibration data.
- **MATLAB Analysis Scripts:** For detailed analysis and visualization of the vibrational data.

## Usage
To use this system:
1. **Setup the hardware** according to the schematics provided in the `Hardware` folder.
2. **Deploy the software** onto the microcontroller and connect to the data processing unit.
3. **Run MATLAB scripts** to analyze the recorded data and generate reports.

## Installation
Clone this repository using:
```bash
git clone https://github.com/yourgithubusername/vibration-damping-system.git
