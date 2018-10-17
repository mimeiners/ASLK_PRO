#!/usr/bin/env python
# -*- encoding: utf-8 -*-

""" Plot of a sine wave without phase. """

import numpy as np
import matplotlib.pyplot as plt

# Define sine wave
A = 1
theta = 0
f = 1
w = 2*np.pi*f
t = np.linspace(0, 2, 100)
v1 = A * np.sin(w*t + theta)

# Plot
plt.figure(1)
plt.plot(t, v1)
plt.xlabel(r'Zeit t in ms')
plt.ylabel(r'Amplitude A')
plt.grid()
plt.legend()

# plt.show()
plt.savefig('Activity_01_Fig_01.png')
