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
    <img src="https://github.com/user-attachments/assets/dfb7ba60-1013-441c-850b-dc857f559b13" width="600" alt="Data Acquisition System">
    <br>
    <em>Data Acquisition System</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/e375dc97-59d5-4b40-9fea-90be2f2c5bfc" width="600" alt="Data Acquisition System">
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
    <img src="https://github.com/user-attachments/assets/c27a9241-55ca-4864-bf96-3e056a705f44" width="600" alt="Bare PCB">
    <br>
    <em>Bare PCB</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/db34daf3-b839-4bb2-abd9-f1310d08f359" width="600" alt="Soldered PCB">
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
    <img src="https://github.com/user-attachments/assets/edb97cfd-28ad-49bf-8856-6f483181dbb9" width="600" alt="Main Controller Unit">
    <br>
    <em>Main Controller Unit</em>
</div>

<div align="center">
    <img src="https://github.com/user-attachments/assets/48d49e3d-76d5-49b3-a511-4c8556a7a3f4" width="600" alt="Accelerometer Holding Part">
    <br>
    <em>Accelerometer Holding Part</em>
</div>

Enclosure design files can be found [here](https://github.com/AchiraHansindu/Vibration-Damping-System-for-Machine-Tools/tree/main/Enclosure%20Design-SolidWorks).

## Software Design
- **Data Acquisition UI:** A user-friendly interface allows for real-time interaction with the data acquisition system.
- **MATLAB Application:** Processes and analyzes vibration data, utilizing FFT analysis to derive actionable insights.

## System Integration
All components are rigorously tested to work cohesively, ensuring the system meets its design specifications and operational requirements.
