# -*- coding: utf-8 -*-
"""
Created on Mon May 11 15:44:53 2020

@author: Julian
"""

import numpy as np
from scipy.fftpack import fft, ifft
import matplotlib.pyplot as plt 
#from scipy import integrate

plt.close('all')

def downsample(x,a):
    l = len(x)//a
    x_new = np.zeros([l,1])
    for i in range(l):
        x_new[i] = x[int(a*i)]
    return x_new


#%%
"""
Was passiert bei der Multiplikation von 2 verschobenen Sinus-Signalen der gleichen Frequenz? 
"""
# Parameter
Punkte = 300000
phi = np.linspace(0,1/2,Punkte) * np.pi     # Annahme Phase ändert sich linear
f = 1000
Perioden = 10000/ f
dx = Perioden / Punkte
# Zeitachse
x000 = np.arange(0,Perioden,dx)
#plt.plot(x000)
x =  x000
#plt.plot(downsample(x,1000))
# Einzelne Sinus-Signale
y1 = np.sin(2 * np.pi *f*x+phi)
y2 = np.sin(2 * np.pi *f*x)
# Multiplikation
y = y1*y2
#%% Plotten Zeitbereich
plt.figure('Zeit/Frequenz')
plt.subplot(211)
plt.plot(x[0:12000],y[0:12000])
plt.plot(x[0:12000],y1[0:12000], '--')
plt.plot(x[0:12000],y2[0:12000], '--')
plt.xlim(0,0.004)
plt.xlabel('Zeit in s')
plt.ylabel('Amplitude')
plt.grid()

#%% Übergang Frequenzbereich
fx = np.fft.fftshift(np.fft.fftfreq(len(x),dx))
fy = np.fft.fftshift(np.fft.fft(y))
fy_abs = (np.real(fy)**2 + np.imag(fy)**2)**(0.5)

#%% Tiefpassübertragungsfunktion

Y_tp = 1/np.sqrt(1+2j*np.pi*fx/100)
Y_tpa = (np.real(Y_tp)**2 + np.imag(Y_tp)**2)**(0.5)
#%% Plotten Frequenzbereich

a=downsample(fx,100)
b=downsample(fy_abs/np.max(fy_abs),100)
c=downsample(fx,100)
d=downsample(Y_tpa,100)

#plt.figure('Frequenz')
plt.subplot(212)
plt.plot(a,b,label = 'Multipliziertes Signal')
plt.plot(c,d, '--',label =  'Tiefpass')
plt.legend()
plt.xlim(-4000,4000)
plt.xlabel('Frequenzen in Hz')
plt.ylabel('Amplitude')
plt.grid()

#%% Zurück in den Zeitbereich
y2 = np.fft.ifft(np.fft.fftshift(fy))

plt.figure('Zeit2')
plt.plot(x[0:3000],y2[0:3000])
plt.grid()
plt.xlim(0,0.01)
plt.ylim(0,1)

#%% Tiefpass (Frequenzbereich)
"""
Was passiert wenn wir einen Tiefpass drauflegen?
"""
fy = fy * Y_tp

y3 = np.fft.ifft(np.fft.fftshift(fy))

plt.figure('Zeit3')
plt.subplot(211)
plt.plot(x[0:12000],y3[0:12000],label = 'Multipliziertes gefiltertes Signal')
plt.grid()
plt.xlim(0,0.004)
plt.ylim(0,1)
plt.xlabel('Zeit in s')
plt.ylabel('Amplitude')


def integrate(f,dx):
    l = len(f)
    F = np.zeros([l,1])
    for i in range(l):
        F[i:]=F[i:]+f[i]*dx
    return F

y_down = downsample(y3,1000)
x_down = downsample(x,1000)
#%%
Y_t =8.2 - 1 * integrate(y_down,x_down[1])
#%%
#plt.figure('Zeit4')
plt.subplot(212)
plt.plot(x_down,Y_t,label = 'Multipliziertes gefiltertes Signal integriert')
plt.grid()
plt.xlabel('Zeit in s')
plt.ylabel('Amplitude')