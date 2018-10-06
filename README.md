[![DOI](https://zenodo.org/badge/151800045.svg)](https://zenodo.org/badge/latestdoi/151800045)

# lightDAQ
automatic light intensity dimmer function using fuzzy logic.

![alt text](arch.svg)

#### Arduino
The Arduino is a low-cost DAQ hardware, the variant used is the Arduino Uno, which runs
on an Atmel328, 5 Volt chip running at 16MHz. Before collecting data, there are two things
important— sample rate and resolution. There's also a problem of system sensitivity.
The analog to digital converters (ADC) on the Arduino operates at 10 bit resolution. The bits
of resolution implies 2 10 = 1024 steps or divisions (0 to 1023), of the reference voltage. For
an Arduino, the reference voltage is usually 5 volts.

#### MATLAB/Simulink
MATLAB is one of the most productive numerical computing software environment for
engineers available. It can be used to acquire live and measured data. So, we match the 0 to 5
volts LDR-Arduino operation range to get maximum resolution and sensitivity of the d.c
lamp’s brightness to the LDR sensed values.

#### Methodology
In this project, we developed a digital PWM controlled d.c lamp with increased sensitivity to
light intensity of the nearest environment compared to similar analog implementations
available.
We have also used Arduino as our Data Acquisition Hardware and MATLAB/Simulink as
the Data Acquisition Control Software.
This setup has many advantages that will be discussed in section 3.0.
The approach employed in this project is follows the steps described below:

> 1. Continuously sense the ambient light intensity using the Light Dependent Resistor, or any
appropriate Photo Resistor

> 2. Arduino DAQ Hardware receives this signal and samples it in the 0V to 5V range,
corresponding to low light intensity and high intensity values respectively

> 3. The DAQ Software, which is MATLAB/Simulink acquires this sensed signal and using
digital mathematical fuzzy functions, increase the sensitivity of the read analog voltage value,
using ADC sampling and quantization theory.

> 4. Send, based on the digital control function running through MATLAB, appropriately
sampled PWM digital value, between 0 and 1 to the positive terminal of the DC-Lamp, to
either reduce or increase the lamp’s brightness respectively.
