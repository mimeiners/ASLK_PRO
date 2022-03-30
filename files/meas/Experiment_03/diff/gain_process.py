import ltspice
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mplt
import json

filename = 'gain'

# create a frequency axis
N = 1000           # number of frequencies
f_start = 1        # start frequency
f_stop = int(1E9)  # end frequency
f = np.geomspace(f_start, f_stop, N)  # frequency axis / points

with open('../../data/diff/'+filename+'.json') as json_file:
  data = json.load(json_file)

def fitSine(t, y):
  optimize_func = lambda x: x[0]*np.sin(x[1]*t+x[2]) + x[3] - y
  est_amp, est_freq, est_phase, est_mean = \
                     leastsq(optimize_func, [1, 1, 0, np.mean(y)])[0]
  data_fit=est_amp*np.sin(est_freq*t+est_phase)+est_mean
  return data_fit

start = 1000       # sample number to begin using
end = -5000        # sample number to end using

amp_dB = list()

# crop samples and calculate amplitude
for freq in data:
  V_in = np.amax(freq[0][start:end])-np.amin(freq[0][start:end])
  V_out = np.amax(freq[1][start:end])-np.amin(freq[1][start:end])
  amp_dB.append(20*np.log10(V_out/V_in))

f_filter = list()
amp_dB_filter = list()
mov_av_size = 20   # moving average filter size

# moving average filter
for i in range(len(amp_dB)-mov_av_size):
  f_filter.append(f[i+int(mov_av_size/2)])
  amp_dB_filter.append(np.average(amp_dB[i:i+mov_av_size]))

save_fig = False

#%% set plotting window configurations

plt.close('all')                # close all figure windows
plt.rc('xtick', labelsize=16)   # fontsize of tick labels of x axis
plt.rc('ytick', labelsize=16)   # fontsize of tick labels of y axis
plt.rc('axes', labelsize=20)    # fontsize of text labels of both axis
plt.rc('axes', titlesize=24)    # fontsize of the title text
plt.rc('lines', lw=1)           # default linewidth
plt.rc('legend', fontsize=18)   # fontsize of the legend

s1 = ltspice.Ltspice('../../spice/diff/gain/gain-py.raw')
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
ax.semilogx(f, amp_dB, 'r.-', markersize=2, label=r'Messung')
ax.semilogx(f_filter, amp_dB_filter, 'g.-', markersize=2, label=r'Messung (geglättet)')
locmaj = mplt.LogLocator(base=10, numticks=10)
ax.xaxis.set_major_locator(locmaj)
locmin = mplt.LogLocator(base=10.0,subs=(0.2,0.4,0.6,0.8),numticks=10)
ax.xaxis.set_minor_locator(locmin)
ax.xaxis.set_minor_formatter(mplt.NullFormatter())
ax.set_xlim(f[0], f[-1])
ax.grid(which='major', alpha=0.5, color='k')
ax.grid(which='minor', alpha=0.33, color='k')
ax.legend(loc='best')
plt.tight_layout()
plt.show()

# save plot
if save_fig:
  plt.savefig('../../fig/diff/'+filename+".png")  # save as .png-file
  plt.savefig('../../fig/diff/'+filename+".svg")  # save as .svg-file

#%% EOF