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

#%% paths and adresses

filename = 'gain'
ELIE4 = '192.168.111.184'
ELIE5 = '192.168.111.185'
ELIE6 = '192.168.111.186'

#%% measurement via RedPitaya

# check if data was already saved for skip
try:
  data = np.loadtxt('../../data/int/'+filename+".csv", dtype='float',
                   comments='#', delimiter='\t', converters=None, skiprows=0,
                   usecols=None, unpack=False, ndmin=0)
  saved = True
except OSError:
  print("No saved data found, begin setup and measurement!")
  saved = False

if not saved:

  # settings of the Red Pitaya
  waveform = 'SINE'   # waveform of the Inputsignal
  Amp = 1             # amplitude of the input signal
  downsampling = '1'  # downsamplingrate (decimation factor)
  triggerdt = '8192'  # trigger delay
  index = 0           # processvariable
  
  # create a frequency axis
  N = 1000
  f_start = 1
  f_stop = int(1E9)
  f = np.geomspace(f_start, f_stop, N)     # frequency axis / points
  
  # alocate 
  amp_dB = np.zeros(len(f))

  # connection to Red Pitaya via SCPI
  RP = scpi.scpi(ELIE6)  # connect to Red Pitaya
  
  # downsampling options
  downsampling_values = np.array([1,8,64,1024,8192,65536])
  # max frequency per downsampling factor to get at least one period
  frequencies = 1/(2**14/125E6 * downsampling_values)
  
  RP.tx_txt('GEN:RST')                     # signal generator reset
  
  for k in f:
    
    ## initial settings of the Red Pitaya
    RP.tx_txt('SOUR1:FUNC ' + waveform)    # set the signal waveform
    RP.tx_txt('SOUR1:FREQ:FIX ' + str(k))  # set frequency
    RP.tx_txt('SOUR1:VOLT '+ str(Amp))     # set amplitude
    RP.tx_txt('SOUR1:VOLT:OFFS 0')         # set offset
    RP.tx_txt('OUTPUT1:STATE ON')          # set the output port 1 ON
    
    # downsampling in dependency of the frequency
    for i in range(len(frequencies)):
      if k > frequencies[i]:
        downsampling = str(downsampling_values[i])
        break
    RP.tx_txt('ACQ:RST')                   # input reset
    RP.tx_txt('ACQ:DEC ' + downsampling)   # set downsamplingrate
    RP.tx_txt('ACQ:TRIG:LEV 0')            # set trigger level
    RP.tx_txt('ACQ:TRIG:DLY ' + triggerdt) # set trigger dt
    RP.tx_txt('ACQ:START')                 # start the meassurement
    RP.tx_txt('ACQ:TRIG NOW')              # trigger
    
    while True:                            # wait until measurement done
      RP.tx_txt('ACQ:TRIG:STAT?')                       
      if RP.rx_txt() == 'TD':
        break
    
    # data of input 1
    RP.tx_txt('ACQ:SOUR1:DATA?')           # read the buffer of input 1
    buffstring1 = RP.rx_txt()              # save the data from buffer
    buffstring1 = buffstring1.strip('{}\n\r\E\R\!')\
      .replace("  ", "").split(',')        # replace and split characters
    buff1 = np.array(list(map(float, buffstring1)))  # string to float

    # data of input 2
    RP.tx_txt('ACQ:SOUR2:DATA?')           # read the buffer of input 2
    buffstring2 = RP.rx_txt()              # save the data from buffer
    buffstring2 = buffstring2.strip('{}\n\r\E\R\!')\
      .replace("  ", "").split(',')        # replace and split characters
    buff2 = np.array(list(map(float, buffstring2)))  # string to float

    # output offset
    V_in = np.amax(buff1)-np.amin(buff1)
    V_out = np.amax(buff2)-np.amin(buff2)
    
    # magnitude frequency response as dB values (data_dB)
    amp_dB[index] = 20*np.log10(V_out/V_in)  # save the Vout/Vin ratio in dB
    
    # progress
    index += 1                               # raise index
    state = int(index / N*100)               # calculate the progress
    print("Measurement progress at : ", state, "%")  # display the progress
  print("\n Measurement is complete! \n")
  
  data = np.matrix([f,amp_dB]).transpose()   # save data matrix
  np.savetxt('../../data/int/'+filename+".csv", data, delimiter='\t')
  RP.tx_txt('OUTPUT1:STATE OFF')             # set the output port 1 OFF
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

s1 = ltspice.Ltspice('../../spice/int/gain/gain-py.raw')
s1.parse()
f1 = s1.getFrequency()
Vin = s1.getData('V(input)')
Vout = s1.getData('V(output)')

fig = plt.figure(filename.upper().replace('_', ' '))
fig.set_size_inches(19.20, 10.80)
ax = fig.add_subplot(projection='rectilinear')
ax.set_xlabel('Frequenz f in Hz [1/s]')
ax.set_ylabel(r'Amplitudenverstärkung in dB ' +\
        r'$\left[20\cdot log_{10}(\frac{V_{Out}}{V_{In}})\right]$')
ax.semilogx(f1, 20*np.log10(Vout/Vin), 'm-', label=r'LTspice')
ax.semilogx(data[:,0], data[:,1], 'r.-', markersize=2, label=r'Messung')
locmaj = mplt.LogLocator(base=10, numticks=10)
ax.xaxis.set_major_locator(locmaj)
locmin = mplt.LogLocator(base=10.0,subs=(0.2,0.4,0.6,0.8),numticks=10)
ax.xaxis.set_minor_locator(locmin)
ax.xaxis.set_minor_formatter(mplt.NullFormatter())
ax.set_xlim(min(data[:,0]), max(data[:,0]))
ax.grid(which='major', alpha=0.5, color='k')
ax.grid(which='minor', alpha=0.33, color='k')
ax.legend(loc='best')
plt.tight_layout()
plt.show()

# save plot
if not saved:
  plt.savefig('../../fig/int/'+filename+".png")  # save as .png-file
  plt.savefig('../../fig/int/'+filename+".svg")  # save as .svg-file

#%% EOF