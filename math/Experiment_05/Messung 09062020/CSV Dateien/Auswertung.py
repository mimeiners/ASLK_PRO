# -*- coding: utf-8 -*-
"""
Created on Sun Jun  7 22:56:38 2020

@author: Julian
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import matplotlib as mpl
plt.close('all')
mpl.rc('xtick', labelsize=20) 
mpl.rc('ytick', labelsize=20) 
plt.rcParams.update({'font.size': 22})
#%% 
a = np.array(pd.read_csv("WFM04.csv", header = 0 ,delim_whitespace=0, decimal = ".").values.tolist())
b = np.array(pd.read_csv("WFM05.csv", header = 0 ,delim_whitespace=0, decimal = ".").values.tolist())
c = np.array(pd.read_csv("WFM06.csv", header = 0 ,delim_whitespace=0, decimal = ".").values.tolist())
d = np.array(pd.read_csv("WFM07.csv", header = 0 ,delim_whitespace=0, decimal = ".").values.tolist())
#%%
plt.figure()
plt.plot(a[:,0],a[:,1],label='CH 1')
plt.plot(b[:,0],b[:,1],label='CH 2')
plt.plot(c[:,0],c[:,1],label='CH 3')
plt.plot(d[:,0],d[:,1]/10,label='CH 4 Faktor: 1/10')
plt.ylabel('Amplitude in V --->')
plt.xlabel('Zeit in s --->')
plt.title('Messung 09.06.2020')
plt.legend()
plt.grid()