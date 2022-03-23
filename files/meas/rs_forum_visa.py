#!/usr/bin/env python
"""Python script for remote control via visa/scpi"""

import time
import visa

rm = visa.ResourceManager()

# Remote connection to device
gen = rm.open_resource('TCPIP::192.168.111.50::INSTR')
osc = rm.open_resource('TCPIP::192.168.111.20::INSTR')

# Connection test
print(osc.query('*IDN?'))
print(gen.query('*IDN?'))

# Setup generator on output 1
print(gen.write('SOURce1:FUNCtion SIN 1'))
print(gen.write('SOURce1:VOLTage 0.7'))
print(gen.write('OUTPut1 ON'))


# Measurement setup oscilloscope
osc.write('MEASurement1:MAIN RMS')
osc.write('MEASurement1:SOURCE CH1')

osc.write('MEASurement2:MAIN RMS')
osc.write('MEASurement2:SOURCE CH2')

osc.write('MEASurement3:MAIN PHASe')
osc.write('MEASurement3:SOURCE CH2,CH1')

# Store data in table
file = open('measdata.txt', 'w')
file.write('Frequenz\t IN_Filter\t OUT_Filter\t Phase\r')

# Sweep control and data storage
f = 20
x = 1

while f < 500:
    f = 20*2**x
    x = x + 0.1
    print('F= ' + str(f))
    print('X= ' + str(x))
    gen.write('SOURce1:FREQuency ' + str(f))
    time.sleep(0.05)
    rms1 = osc.query('MEASurement1:RESult?').replace('\n', '')
    rms2 = osc.query('MEASurement2:RESult?').replace('\n', '')
    phase = osc.query('MEASurement3:RESult?').replace('\n', '')
    print(str(rms1)+'\t'+str(rms2)+'\t'+str(phase))
    file.write(str(f) + '\t' + str(rms1) + '\t' +
               str(rms2) + '\t' + str(phase) + '\r')

file.close()
