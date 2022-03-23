#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 15 19:16:39 2019

@author: Mirco Meiners and Tim Ziemann
"""

#%% Init
import time
from datetime import datetime
import numpy as np
import pandas as pd
# import matplotlib.pyplot as plt
import redpitaya_scpi as scpi

IP = '192.168.111.181'  # IP of Testplace
rp_s = scpi.scpi(IP)

#%% Measurement / Data Accquisition

# Data storage
Data_IN1 = 'data/diode/IN1_1N4001_' + str(
    datetime.now().strftime('%Y-%m-%d_%H-%M')) + '.csv'
Data_IN2 = 'data/diode/IN2_1N4001_' + str(
    datetime.now().strftime('%Y-%m-%d_%H-%M')) + '.csv'

DF_IN1 = pd.DataFrame()
DF_IN2 = pd.DataFrame()

# Parameters
func = 'TRIANGLE'  # Waveform (SINE, SQUARE, TRIANGLE)
ampl = 0.4  # Amplitude (-1V...1V)
freq = 1000  # Frequency (0Hz...62.5e6Hz)
offset = -0.4  # Offset (-1V...1V)
phase = 0  # Phaseshift (-360deg ... 360deg)

rp_s.tx_txt('GEN:RST')  # Signal Generator reset
rp_s.tx_txt('SOUR1:FUNC ' + str(func))  # Wave form
rp_s.tx_txt('SOUR1:VOLT ' + str(ampl))  # Magnitude
rp_s.tx_txt('SOUR1:VOLT:OFFS ' + str(offset))  # Offset
rp_s.tx_txt('SOUR1:FREQ:FIX ' + str(freq))  # Frequency
rp_s.tx_txt('SOUR1:PHAS ' + str(phase))  # Phase
rp_s.tx_txt('SOUR1:TRIG:SOUR INT ')  # Trigger
rp_s.tx_txt('OUTPUT1:STATE ON')  # Output

# Wait to be ready . . .
# time.sleep(1)

# Trigger
rp_s.tx_txt('ACQ:RST ')  # Input reset
rp_s.tx_txt('ACQ:DEC 16')  # Decimation (1,8,16,64,1024,8192)
rp_s.tx_txt('ACQ:AVG ON')  # Averageing (OFF,ON)
rp_s.tx_txt('ACQ:TRIG:LEV 0')  # Trigger level
rp_s.tx_txt('ACQ:TRIG:DLY 8192')  # Delay
rp_s.tx_txt('ACQ:START')  # Start measurement
rp_s.tx_txt('ACQ:TRIG NOW')  # Trigger immediately

# Wait to be ready . . .
time.sleep(1)  # in Sekunden
# while 1:
#    rp_s.tx_txt('ACQ:TRIG:STAT?')
#    if rp_s.rx_txt() == 'TD':
#        break

for loop in range(0, 5):

    # Input IN1
    time.sleep(0.1)  # in Sekunden
    rp_s.tx_txt('ACQ:SOUR1:DATA?')  # Readout buffer IN1
    IN1str = rp_s.rx_txt()
    IN1str = IN1str.strip('{}\n\r').replace("  ", "").split(
        ',')  # data handeling/formating
    IN1 = np.array(list(map(float, IN1str)))
    DF_IN1[str(loop)] = IN1

    # Input IN2
    time.sleep(0.1)  # in Sekunden
    rp_s.tx_txt('ACQ:SOUR2:DATA?')  # Readout buffer IN2
    IN2str = rp_s.rx_txt()
    # data handeling/formating
    IN2str = IN2str.strip('{}\n\r').replace("  ", "").split(',')
    IN2 = np.array(list(map(float, IN2str)))
    DF_IN2[str(loop)] = IN2

# stopping the generator
rp_s.tx_txt('OUTPUT1:STATE OFF')

#%% Store data on disk
DF_IN1.to_csv(Data_IN1)
DF_IN2.to_csv(Data_IN2)
