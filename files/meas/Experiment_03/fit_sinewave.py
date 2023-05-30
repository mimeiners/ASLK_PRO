import numpy as np
from scipy.optimize import leastsq
import pylab as plt

N = 1000  # number of data points
time = np.linspace(0, 4 * np.pi, N)
f = 1.15247  # frequency

# create artificial data with noise
inData = 3.0 * np.sin(f * time + 0.001) + 0.5 + np.random.randn(N)


def fitSine(t, y):
    ''' Least Square Fitting for Sinusoidal Tones '''

    # Establishing start values by spectral analysis
    ff = np.fft.fftfreq(len(t), (t[1] - t[0]))  # assume uniform spacing
    Fyy = abs(np.fft.fft(y))
    guess_freq = abs(ff[np.argmax(Fyy[1:]) +
                        1])  # excluding zero frequency "peak"
    guess_amp = np.std(y) * 2.**0.5
    guess_offset = np.mean(y)
    guess = np.array([guess_amp, 2. * np.pi * guess_freq, 0., guess_offset])

    def optfunc(x):
        return x[0] * np.sin(x[1] * t + x[2]) + x[3] - y

    est_amp, est_freq, est_phase, est_mean = leastsq(optfunc, guess)[0]

    data_fit = est_amp * np.sin(est_freq * t + est_phase) + est_mean
    return data_fit


plt.plot(time, inData, '.', label='before fitting')
plt.plot(time, fitSine(time, inData), label='after fitting')
plt.legend()
plt.show()
