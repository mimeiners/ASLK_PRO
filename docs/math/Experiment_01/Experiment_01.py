#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
import scipy.signal as sig
import matplotlib.pyplot as plt

# Parameter für die Übertragungsfunktion
A0 = 1e5
f_un = 3e6
# f_3_db = f_un/A0 
f_3_db = 1.2e6
wd1 = 2*np.pi*f_3_db
wd2 = 2*np.pi*4e6
GB = A0*wd1
w0 = np.sqrt(GB*wd2)

# Formel für den Güte Faktor
Q = 1/((np.sqrt(wd2/GB)) + ((1/A0)*(np.sqrt(GB/wd2))))

num = 1
den = [1/wd1**2, 1/(w0*Q), 1]
sys = sig.lti(num, den)

# Plot der Ergebnisse
f = np.logspace(-1, 9)
w, mag, phase = sys.bode(2 * np.pi * f)

# Unwrap the phase to make the jumps consistent and shift to 0 at w=0
angle = np.rad2deg(np.unwrap(np.deg2rad(phase)))
angle = angle - angle[1]

# Generate the magnitude plot with annotation, phase, and group delay plots
mindB = -100
maxdB = 20
plt.figure(1)
plt.subplot(2, 1, 1)
plt.semilogx(f, mag)

# plt.line([np.min(f) 5e6], [-2 -2])
# plt.line([5e6 5e6], [mindB -2])
# plt.line([np.min(f) 10e6], [0 0])
# plt.line([10e6 10e6], [0 -60])
# plt.line([10e6 f[-1]], [-60 -60])

plt.grid()
plt.xlabel('Frequency f/Hz')
plt.ylabel('Magnitude A/dB')
plt.axis([np.min(f), np.max(f), mindB, maxdB])

plt.subplot(2, 1, 2)
plt.semilogx(f, angle)
plt.grid()
plt.xlabel('Frequency f/Hz')
plt.ylabel('Phase phi/deg')
plt.axis([np.min(f), np.max(f), -200, 100])
plt.show()
