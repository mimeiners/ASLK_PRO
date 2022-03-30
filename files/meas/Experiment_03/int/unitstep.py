# -*- coding: utf-8 -*-

"""
Created on Fri May 21 10:10:10 2021
@author: © Vadim Grebnev, Tim Hilker, Delphino Klinker

"""

import ltspice
import matplotlib.pyplot as plt
import matplotlib.ticker as mplt
import numpy as np
import redpitaya_scpi as scpi
from time import sleep as delay

import matplotlib
matplotlib.use('Agg')

#%% paths and adresses

filename = 'unitstep'
ELIE4 = '192.168.111.184'
ELIE5 = '192.168.111.185'
ELIE6 = '192.168.111.186'

#%% measurement via RedPitaya

# check if data was already saved for skip
try:
  data = np.loadtxt('../../data/int/rect.csv', dtype='float',
                   comments='#', delimiter='\t', converters=None, skiprows=0,
                   unpack=False, ndmin=0)
  saved = True
except OSError:
  print("No saved data found, begin setup and measurement!")
  saved = False

save_plot = True

time_factor = 1e6      # factor for x-axis
voltage_division = 10  # Voltage divison factor 

# settings of the Red Pitaya
waveform = 'SQUARE'    # waveform of the Inputsignal
Amp = 0.5              # amplitude of the input signal
downsampling = 32      # downsamplingrate (decimation factor)
triggerdt = '8192'     # trigger delay

sampling_rate = 125e6  # 125 MS/s
# sampling rate with regard to actual decimation factor
effective_sampling_rate = sampling_rate/downsampling 
buffer_size = 2**14    # 14 bit
# taking sample every sampling_interval seconds
sampling_interval = 1/effective_sampling_rate
# total buffer size in seconds
total_time = sampling_interval*buffer_size

if not saved:
  print("Couldn't find data.")
  exit()

dat = list()

dat.append(data[:,0])
dat.append(data[:,1])
dat.append(data[:,2])

start = 910
end = start + int(0.6e-3/sampling_interval+2)  # start plus 600 us

dat[0] = np.arange(0, end-start, 1)*sampling_interval
dat[1] = dat[1][start:end]
dat[2] = dat[2][start:end]

#%% set plotting window configurations

plt.close('all')               # close all figure windows
plt.rc('xtick', labelsize=16)  # fontsize of tick labels of x axis
plt.rc('ytick', labelsize=16)  # fontsize of tick labels of y axis
plt.rc('axes', labelsize=20)   # fontsize of text labels of both axis
plt.rc('axes', titlesize=24)   # fontsize of the title text
plt.rc('lines', lw=1)          # default linewidth
plt.rc('legend', fontsize=18)  # fontsize of the legend

#%% plot of LTspice simulation and meassured data of an integrator circuit

s1 = ltspice.Ltspice('../../spice/int/unitstep/unitstep-py.raw')
s1.parse()
t1 = s1.getTime()*time_factor
Vin = s1.getData('V(input)')
Vout = s1.getData('V(output)')

fig = plt.figure(filename.upper().replace('_', ' '))
fig.set_size_inches(19.20, 10.80)

ax1 = fig.add_subplot(211, projection='rectilinear')
ax1.set_title('Simulation')
ax1.set_xlabel(r'Zeit t in Mikrosekunden [$\mu$s]')
ax1.set_ylabel(r'Spannung in Volt [V]')
ax1.plot(t1, Vin, 'b-', label=r'LTspice $V_{In}$')
for label in ax1.get_yticklabels():
    label.set_color('blue')
ax1.grid(linewidth=0.5)
ax1.legend(loc='center left')
#
ax2 = ax1.twinx()
ax2.plot(t1, Vout, 'r-', label=r'LTspice $V_{Out}$')
ax2.set_xlim(min(t1), max(t1))
ax2.set_ylim(-9.5,9.5)
for label in ax2.get_yticklabels():
    label.set_color('red')
ax2.legend(loc='center right')
#
ax3 = fig.add_subplot(212, projection='rectilinear')
ax3.set_title('Messung')
ax3.set_xlabel(r'Zeit t in Mikrosekunden [$\mu$s]')
ax3.set_ylabel('Spannung in Volt [V]')
ax3.plot(dat[0]*time_factor, dat[1], 'b.-', markersize=2,
         label=r'Messung $V_{In}$')
for label in ax3.get_yticklabels():
    label.set_color('blue')
ax3.legend(loc='center left')
#
ax4 = ax3.twinx()
ax4.plot(dat[0]*time_factor, dat[2], 'r.-', markersize=2,
         label=r'Messung $V_{Out}$')
ax4.set_xlim(min(dat[0])*time_factor, max(dat[0])*time_factor)
ax4.set_ylim(-9.5,9.5)
for label in ax4.get_yticklabels():
    label.set_color('red')
ax4.grid(linewidth=0.5)
ax4.legend(loc='center right')

plt.tight_layout()
plt.show()

# save plot
if save_plot:
  plt.savefig('../../fig/int/'+filename+".png")  # save as .png-file
  plt.savefig('../../fig/int/'+filename+".svg")  # save as .svg-file

#%% EOF