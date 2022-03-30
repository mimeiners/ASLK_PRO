# -*- coding: utf-8 -*-

"""
Created on Fri May 21 10:10:10 2021
@author: © Vadim Grebnev, Tim Hilker, Delphino Klinker

"""

import ltspice
import matplotlib.pyplot as plt
import matplotlib.ticker as mplt
from scipy.optimize import leastsq
import numpy as np
import redpitaya_scpi as scpi
from time import sleep as delay

#%% paths and adresses

filename = 'rect'
ELIE4 = '192.168.111.184'
ELIE5 = '192.168.111.185'
ELIE6 = '192.168.111.186'

#%% measurement via RedPitaya

# check if data was already saved for skip
try:
  data = np.loadtxt('../../data/diff/'+filename+".csv", dtype='float',
                   comments='#', delimiter='\t', converters=None, skiprows=0,
                   unpack=False, ndmin=0)
  saved = True
except OSError:
  print("No saved data found, begin setup and measurement!")
  saved = False

time_factor = 1e3       # factor for x-axis
voltage_division = 10   # Voltage divison factor 

if not saved:

  # settings of the Red Pitaya
  waveform = 'SINE'     # waveform of the Inputsignal
  Amp = 0.5             # amplitude of the input signal
  downsampling = 512    # downsamplingrate (decimation factor)
  triggerdt = '8192'    # trigger delay
  
  sampling_rate = 125e6   #125 MS/s
  # sampling rate with regard to actual decimation factor 
  effective_sampling_rate = sampling_rate/downsampling
  buffer_size = 2**14     # 14 bit
  # taking sample every sampling_interval seconds
  sampling_interval = 1/effective_sampling_rate
  # total buffer size in seconds
  total_time = sampling_interval*buffer_size


# connection to Red Pitaya via SCPI
  RP = scpi.scpi(ELIE6)                        # connect to Red Pitaya

  RP.tx_txt('GEN:RST')                         # signal generator reset
  RP.tx_txt('SOUR1:VOLT:OFFS 0')
  
  ## initial settings of the Red Pitaya
  RP.tx_txt('SOUR1:FUNC ' + waveform.upper())  # set the signal waveform
  RP.tx_txt('SOUR1:FREQ:FIX ' + str(75))       # set frequency
  RP.tx_txt('SOUR1:VOLT '+ str(Amp))           # set amplitude
  RP.tx_txt('OUTPUT1:STATE ON')                # set the output port 1 ON
  
  delay(1)                                     # wait 1 second
  
  RP.tx_txt('ACQ:RST')                         # input reset
  RP.tx_txt('ACQ:DEC ' + str(downsampling))    # set downsamplingrate
  RP.tx_txt('ACQ:TRIG:LEV 0')                  # set trigger level
  RP.tx_txt('ACQ:TRIG:DLY ' + str(triggerdt))  # set trigger dt
  RP.tx_txt('ACQ:START')                       # start the meassurement
  RP.tx_txt('ACQ:TRIG NOW')                    # trigger

  while True:                                  # wait until measurement done
    RP.tx_txt('ACQ:TRIG:STAT?')                       
    if RP.rx_txt() == 'TD':
      break

  # data of input 1
  RP.tx_txt('ACQ:SOUR1:DATA?')                 # read the buffer of input 1
  buffstring1 = RP.rx_txt()                    # save the data from buffer
  buffstring1 = buffstring1.strip('{}\n\r\E\R\!')\
    .replace("  ", "").split(',')              # replace and split characters
  buff1 = np.array(list(map(float, buffstring1))) * voltage_division

  # data of input 2
  RP.tx_txt('ACQ:SOUR2:DATA?')                 # read the buffer of input 2
  buffstring2 = RP.rx_txt()                    # save the data from buffer
  buffstring2 = buffstring2.strip('{}\n\r\E\R\!')\
    .replace("  ", "").split(',')              # replace and split characters
  buff2 = np.array(list(map(float, buffstring2))) * voltage_division
  
  t = np.arange(0, len(buff2), 1)
  data = np.matrix([t*sampling_interval, buff1, buff2]).transpose()
  np.savetxt('../../data/diff/'+filename+".csv", data, delimiter='\t')
  RP.tx_txt('OUTPUT1:STATE OFF')               # set the output port 1 OFF
else:
  print("\n Data allready saved! \n")


#%% set plotting window configurations

plt.close('all')               # close all figure windows
plt.rc('xtick', labelsize=16)  # fontsize of tick labels of x axis
plt.rc('ytick', labelsize=16)  # fontsize of tick labels of y axis
plt.rc('axes', labelsize=20)   # fontsize of text labels of both axis
plt.rc('axes', titlesize=24)   # fontsize of the title text
plt.rc('lines', lw=1)          # default linewidth
plt.rc('legend', fontsize=18)  # fontsize of the legend

#%% plot of LTspice simulation and meassured data of an integrator circuit

s1 = ltspice.Ltspice('../../spice/diff/rect/rect.raw')
s1.parse()
t1 = s1.getTime()*time_factor
Vin = s1.getData('V(input)')
Vout = s1.getData('V(output)')

fig = plt.figure(filename.upper().replace('_', ' '))
fig.set_size_inches(19.20, 10.80)

ax1 = fig.add_subplot(211, projection='rectilinear')
ax1.set_title('Simulation')
ax1.set_xlabel(r'Zeit t in Millisekunden [ms]')
ax1.set_ylabel(r'Spannung in Volt [V]')
ax1.plot(t1, Vin, 'b-', label=r'LTspice $V_{In}$')
for label in ax1.get_yticklabels():
    label.set_color('blue')
ax1.grid(linewidth=0.5)
ax1.legend(loc='upper left')
#
ax2 = ax1.twinx()
ax2.plot(t1, Vout, 'r-', label=r'LTspice $V_{Out}$')
ax2.set_xlim(min(t1), max(t1))
for label in ax2.get_yticklabels():
    label.set_color('red')
ax2.legend(loc='upper right')
#
ax3 = fig.add_subplot(212, projection='rectilinear')
ax3.set_title('Messung')
ax3.set_xlabel('Zeit t in Millisekunden [ms]')
ax3.set_ylabel('Spannung in Volt [V]')
ax3.plot(data[:,0]*time_factor, data[:,1], 'b.-', markersize=2,
         label=r'Messung $V_{In}$')
for label in ax3.get_yticklabels():
    label.set_color('blue')
ax3.legend(loc='upper left')
#
ax4 = ax3.twinx()
ax4.plot(data[:,0]*time_factor, data[:,2], 'r.-', markersize=2,
         label=r'Messung $V_{Out}$')
ax4.set_xlim(min(data[:,0])*time_factor, max(data[:,0])*time_factor)
for label in ax4.get_yticklabels():
    label.set_color('red')
ax4.grid(linewidth=0.5)
ax4.legend(loc='upper right')

plt.tight_layout()
plt.show()

# save plot
if not saved:
  plt.savefig('../../fig/diff/'+filename+".png")  # save as .png-file
  plt.savefig('../../fig/diff/'+filename+".svg")  # save as .svg-file

#%% EOF