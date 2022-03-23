# -*- coding: utf-8 -*-
"""

@author: Mirco Meiners and Tim Ziemann
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

#%% Array of tones (GEN):
func = 'TRIANGLE'  # Waveform (SINE, SQUARE, TRIANGLE, SAWU, SAWD, PWM, ARBITRARY, DC, DC_NEG)
ampl = 0.4	# Amplitude (-1V...1V)
freq = 1000	 # Frequency (0Hz...62.5e6Hz)
offset = -0.4	  # Offset (-1V...1V)
phase = 0  # Phase shift (-360deg ... 360deg)
t = np.linspace(0, 2.097e-3, 16384) # Time scale

#%% Data read-in
Data_IN1 = 'data/IN1_BS170_2022-01-11_10-21.csv'
Data_IN2 = 'data/IN2_BS170_2022-01-11_10-21.csv'

DF_IN1 = pd.read_csv(Data_IN1, index_col=(0))
DF_IN2 = pd.read_csv(Data_IN2, index_col=(0))

#%% Plots 
plt.plot(t, DF_IN1.mean(axis=1), label='IN1')
plt.plot(t, DF_IN2.mean(axis=1), label='IN2')
plt.grid()
plt.legend()
plt.xlabel('Zeit t in s')
plt.ylabel('Amplituden in V')
