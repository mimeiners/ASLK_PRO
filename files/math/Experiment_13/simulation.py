#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 13 10:48:01 2019

@author: erichwentland
"""

import numpy as np
import matplotlib.pyplot as plt


# Simulieren Ausgangsverhalten DAC mit I/U Converter

Vin = 2
R1 = np.array([10e3, 10e3, 10e3, 10e3])
R2 = np.array([20e3, 40e3, 70e3, 100e3])

b = np.linspace(0, 2**12-1, 2**12)
Vout1 = Vin*((2**12)/b)
Vout2 = Vin*(R2[0]/R1[0])*((2**12)/b)
Vout3 = Vin*(R2[1]/R1[1])*((2**12)/b)
Vout4 = Vin*(R2[2]/R1[2])*((2**12)/b)
Vout5 = Vin*(R2[3]/R1[3])*((2**12)/b)


plt.figure()
# plt.plot(b,Vout)
plt.semilogy(b, Vout1, label='R2=R1')
plt.semilogy(b, Vout2, label='R2=2 R1')
plt.semilogy(b, Vout3, label='R2=4 R1')
plt.semilogy(b, Vout4, label='R2=7 R1')
plt.semilogy(b, Vout5, label='R2=10 R1')
plt.grid()
plt.legend()
plt.xlabel("DAC-Register")
plt.ylabel("Verstärkung")

# Besser relative Pfadangaben innerhalb des Projektes, z.B. so
plt.savefig("../../img/Experiment_13/gainCharacterDCGSA.png", dpi=300)

R1 = 10e3
R2 = 22e3

b = np.linspace(250, 2**12-1, 2**12)
DACout = (R2/R1)*((2**12)/b)
# DACout = ((2**12)/b)

# Daten besser in einer Datei ablegen, z.B. pickle oder shelve
# (https://www.pythonforthelab.com/blog/introduction-to-storing-data-in-files/)
Vout2V = np.array([17.8, 17.2, 9.4, 9.2, 6.6, 5.2, 4.8, 4, 3.4, 2.8, 2.6, 2.4, 2.2, 1.8, 1.6])
Vout0V1 = np.array([2, 1.84, 1.04, 0.96, 0.72, 0.64, 0.6, 0.52, 0.4, 0.36, 0.36, 0.36, 0.36, 0.36, 0.36])
dacReg = np.array([257, 271, 511, 527, 767, 1023, 1039, 1279, 1535, 2047, 2063, 2303, 2559, 3071, 4095])

plt.figure()
plt.semilogy(b, DACout, label='gain theoretisch')
plt.semilogy(dacReg, Vout2V/1, '.-r', label='gain(Input=1V)')
plt.semilogy(dacReg[0:-3], Vout0V1[0:-3]/0.1, '.-g', label='gain(Input=0.1V)')

plt.grid()
plt.legend()
plt.xlabel("DAC-Register")
plt.ylabel("Verstärkung")

plt.savefig("../../img/Experiment_13/mesurementDCGSA.png", dpi=300)
