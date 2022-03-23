# -*- coding: utf-8 -*-
"""
Created on Thu Apr  9 18:28:54 2020

@author: Timo Stelter, 
         Patrice Bönig,
         Jan Dröst

"""

import numpy as np
import pandas as pd
from scipy import signal
import matplotlib.pyplot as plt 
import os

plt.rcParams.update({'font.size':22})


plt.close("all")

os.chdir("./")

# Funktionen

# Timos Funktion
def komma2dot(Speicherpfad, Trennung="\t"):
    r'''
    
    Bearbeitungsdatum: 19.04.2020
        
    Autor: Timo Stelter
        
    Kurzbeschreibung:
    -------
    Die Funktion liest eine txt oder csv-Datei ein, die Tabellarisch aufgebaut
    ist. In Zeile 1 muss sich ein Header befinden.
    Ab Zeile 2 beginnen die Messwerte. Anzahl der Spalten ist beliebig. 
    Trennung kann wie in pandas.read_csv(sep=) angegeben werden.
    Sind die in Zeile 2 eingelesenen Werte vom Typ str, so wird in der gesamten
    Spalte jedes Komma durch einen Punkt ersetzt und jedes str zu einem float 
    umgewandelt. Das Array wird ohne header ausgegeben.

    Parameters
    ----------
    Speicherpfad : str
        Speicherpfad von der txt oder csv.
    Trennung : str, optional
        Trennung vom Befehl pandas.read_csv(sep=). The default is "\t".

    Returns
    -------
    array : array
        Gibt die eingelesene Datei als array ohne header zurueck.

    Beispiel
    -------
        
        >>> >>>#Input:
            >>>#Messung.txt
            >>>#*Time 	Vin	TP3	TP4	VOUT
            >>>#0	0	0	0	0
            >>>#1,5E-7	10	0,0318133514909804	1,74904479225499	1,75447387482717E-6
            >>>#1,875E-7	10	0,03976034804092	1,05221214249939	2,25900985101856E-6
            >>>Messung = komma2dot("Messung.txt")
        
        >>> Output:
            array([[0.0, 0, 0.0, 0.0, 0.0],
            [1.5e-07, 10, 0.0318133514909804, 1.74904479225499, 1.75447387482717e-06],
            [1.875e-07, 10, 0.03976034804092, 1.05221214249939, 2.25900985101856e-06],
            dtype=object)
            
    '''
    DataFrame = pd.read_csv(Speicherpfad, sep=Trennung) #Einlesen als DataFrame
    array = DataFrame.values #DataFrame zu array
    
    
    a = len(array[:, 0]) #Anzahl Zeilen
    b = len(array[0,:]) #Anzahl Spalten
    
    for i in range((b)): #Fuer jede Spalte
        if  type(array[0,i]) == str: #Wenn Spalteninhalt vom Typ str
            for j in range((a)): #jede Zeile
                array[j,i] = float(array[j,i].replace(',', '.')) #, zu . und str zu float
    return array


# kleineres Grid für Plot
def stepgrid():
    plt.grid(b=True, which='major', color='gray', linestyle='-',linewidth=1)
    plt.grid(b=True, which='minor', color='gray', linestyle='-',linewidth=0.5)
    plt.minorticks_on()


# Einlesen der Messwerte und Speichern als pickle (compressed) datafile
path0 = "./Simulationsdaten/"   # Simulationsdaten mit dem richtigen Widerstand

sig3data = "Schritt3_Werte.txt"
sig4data = "Schritt4_Werte.txt"
sig5data = "Schritt5_Werte.txt"

# Einlesen der Pickle-Daten

# Simulation
sig3 = pd.read_pickle(path0 + sig3data + '.pkl.xz')
sig4 = pd.read_pickle(path0 + sig4data + '.pkl.xz')
sig5 = pd.read_pickle(path0 + sig5data + '.pkl.xz')

# Messung
path3   = "./Messdaten/Mess_12_4_3/"
path4   = "./Messdaten/Mess_12-4-4_und_12-4-5/"
path5   = "./Messdaten/Mess_12_4_6/"
ending4 = '.CSV.pkl.xz'
ending5 = '.csv.pkl.xz'

# %% Plot fuer Messung 3
# Versuch: Die 4 Unterschiedlichen Spannungen: Eingangsspg., Ausgangsspg., 
# Oszilatorspg. und Duty Cicle
    
    
# ====== Simulation ======

TP3_3 = sig3['TP3'].values
TP3_4 = sig3['TP4'].values
Vin3 = sig3['Vin'].values
Vout3 = sig3['VOUT'].values
time33 = sig3['*Time '].values

begin3 = 1322
end3 = 1322 + 1360

# Auslesen der Simu Daten
TP3_b = TP3_3[begin3:end3]
TP4_b = TP3_4[begin3:end3]
Vout3 = Vout3[begin3:end3]
Vin3 = Vin3[begin3:end3]
time3 = time33[begin3:end3] * 1000000 - 15000 # Zeitskala skalieren und 15 ms abziehen



# ===== Messung ======

# Signal verschieben um sie am Anfang des Plots aufeinander zu legen
shift_TP3 = 355
shift_TP4 = 300

# Einlesen von TP3
sigdata = pd.read_pickle(path3 + "WFM02" + ending4)
sig = sigdata["CH4[V]"].values
Versuch3_TP3 = sig[0+shift_TP3:10000+shift_TP3]
Versuch3_time_TP3 = np.linspace(100,200,len(Versuch3_TP3))

# Variablen zurücksetzen
time = None
file = None
sigdata = None
sig = None
sig_mean = None

# Einlesen von Vin
sigdata = pd.read_pickle(path3 + "WFM03" + ending4)
sig = sigdata["CH2[V]"].values
Versuch3_Vin = sig[0+shift_TP4:10000+shift_TP4]
Versuch3_time_Vin = np.linspace(100,200,len(Versuch3_Vin))

# Variablen zurücksetzen
time = None
file = None
sigdata = None
sig = None
sig_mean = None

# Einlesen von TP4
sigdata = pd.read_pickle(path3 + "WFM04" + ending4)
sig = sigdata["CH2[V]"].values
Versuch3_TP4 = sig[0+shift_TP4:10000+shift_TP4]
Versuch3_time_TP4 = np.linspace(100,200,len(Versuch3_TP4))

# Variablen zurücksetzen
time = None
file = None
sigdata = None
sig = None
sig_mean = None

# Einlesen von Vout
sigdata = pd.read_pickle(path3 + "WFM05" + ending4)
sig = sigdata["CH4[V]"].values
Versuch3_Vout = sig[0+shift_TP4:10000+shift_TP4]
Versuch3_time_Vout = np.linspace(100,200,len(Versuch3_Vout))



# ===== Output =======

# Oszilator Frequenz - Simulation
f_TP3_s_begin = 1 / (time3[110] - time3[39]) * 1000 # kHz
f_TP3_s_end = 1 / (time3[1328] - time3[1257]) * 1000 # kHz
print('TP3 Simulation: besitzt eine Frequenz am Anfang von '+ str(np.round(f_TP3_s_begin,2)) +' kHz')
print('TP3 Simulation: besitzt eine Frequenz am Ende von '+ str(np.round(f_TP3_s_end,2)) +' kHz')

# Oszilator Frequenz - Messung
f_TP3_m_begin = 1 / (Versuch3_time_TP3[698] - Versuch3_time_TP3[216]) * 1000 # Ermittlung der Periode 
f_TP3_m_end = 1 / (Versuch3_time_TP3[9580] - Versuch3_time_TP3[9089]) * 1000 # Ermittlung der Periode 
print('TP3 Messung: besitzt eine Frequenz von '+ str(np.round(f_TP3_m_begin,2)) +' kHz')
print('TP3 Messung: besitzt eine Frequenz von '+ str(np.round(f_TP3_m_end,2)) +' kHz \n')

# PWM Signal Frequenz - Simulation
f_TP4_s_begin = 1 / (time3[116] - time3[45]) * 1000 # kHz
f_TP4_s_end = 1 / (time3[1334] - time3[1263]) * 1000 # kHz
print('TP4 Simulation: besitzt eine Frequenz am Anfang von '+ str(np.round(f_TP3_s_begin,2)) +' kHz')
print('TP4 Simulation: besitzt eine Frequenz am Ende von '+ str(np.round(f_TP3_s_end,2)) +' kHz')

# PWM Frequenz - Messung
f_TP4_m_begin = 1 / (Versuch3_time_TP4[545] - Versuch3_time_TP4[51]) * 1000 # kHz
f_TP4_m_end = 1 / (Versuch3_time_TP4[9393] - Versuch3_time_TP4[8898]) * 1000 # kHz
print('TP4 Messung: besitzt eine Frequenz am Anfang von '+ str(np.round(f_TP4_m_begin,2)) +' kHz')
print('TP4 Messung: besitzt eine Frequenz am Ende von '+ str(np.round(f_TP4_m_end,2)) +' kHz')


# ===== Plots =====

plt.figure("Messung 3 - die Spannungen")
plt.subplot(511) 
plt.plot(time3,TP3_b,'green',label="Simulationsdaten")
plt.plot(Versuch3_time_TP3,Versuch3_TP3,'orange',label="Messdaten")
plt.ylabel("TP3 in V")
plt.title('Die unterschiedlichen Wellenformen des DC-DC-Konverters bei fester Last')
axes = plt.gca()
axes.set_xlim([100,200])
plt.legend(loc='upper right',prop={'size': 13})
stepgrid()

plt.subplot(512)
plt.plot(time3,TP4_b,'green',label="Simulationsdaten")
plt.plot(Versuch3_time_TP4,Versuch3_TP4,'orange',label="Messdaten")
plt.ylabel("TP4 in V")
axes = plt.gca()
axes.set_xlim([100,200])
plt.legend(loc='upper right',prop={'size': 13})
stepgrid()

plt.subplot(513)
plt.plot(time3,Vin3, 'green',label="Simulationsdaten")
plt.plot(Versuch3_time_Vin,Versuch3_Vin,'orange',label="Messdaten")
plt.hlines(np.mean(Versuch3_Vin),time3[0], time3[len(time3)-1], 'b', label='Mittelwert der Messdaten')
plt.ylabel("Vin in V")
axes = plt.gca()
axes.set_xlim([100,200])
plt.legend(loc='upper right',prop={'size': 13})
stepgrid()

plt.subplot(514)
plt.plot(time3,Vout3, 'green',label="Simulationsdaten")
plt.hlines(np.mean(Vout3),time3[0], time3[len(time3)-1], 'r', label='Mittelwert der Simulationsdaten')
plt.ylabel("$V_{out}$ in V")
plt.legend(loc='upper right',prop={'size': 13})
axes = plt.gca()
axes.set_xlim([100,200])
stepgrid()

plt.subplot(515)
plt.plot(Versuch3_time_Vout,Versuch3_Vout,'orange',label="Messdaten")
plt.hlines(np.mean(Versuch3_Vout),time3[0], time3[len(time3)-1], 'b', label='Mittelwert der Messdaten')
plt.ylabel("$V_{out}$ in V")
plt.xlabel("Zeit in µs")
plt.legend(loc='upper right',prop={'size': 13})
axes = plt.gca()
axes.set_xlim([100,200])
stepgrid()

#%% Plot fuer Messung 4
# Versuch: Änderung der Eingangsspg. und beobachten der Ausgangsspg.

# ====== Simulation ======

# Werte auslesen
Vin4  = sig4['Vin'].values 
Vout4 = sig4['VOUT'].values

# Vin: von groß nach klein
begin4 = 174665
end4 = 526913

# Werte auslesen auf Grundlage der Auslesegrenzen
Vout4 = Vout4[begin4:end4]
Vin4 = Vin4[begin4:end4]

# ===== Messung ======

i = 0

# Einlesen der Eingangsspg. aus den verschiedenen Dateien
eingsspg4_files = ["MVIN10","M3","M6","M9","M12","M15","M18","M21","M24","M27","M30"]
eingsspg4 = np.zeros(len(eingsspg4_files))

for file4 in eingsspg4_files:
    sigdata = pd.read_pickle(path4 + file4 + ending4)
    sig = sigdata["CH2[V]"].values
    sig_mean = np.mean(sig)# + 0.25 # Durchschnitte errechnen und konstanten Fehler ausgleichen
    eingsspg4[i] = eingsspg4[i] + sig_mean
    i = i + 1


# Variablen zurücksetzen
i = 0
file = None
sigdata = None
sig = None
sig_mean = None


# Einlesen der Ausgangsspg. aus den verschiedenen Dateien
ausgangsspg4_files = ["M2","M5","M8","M11","M14","M17","M20","M23","M26","M29","M32"]
ausgangsspg4 = np.zeros(len(ausgangsspg4_files))

for file4 in ausgangsspg4_files:
    sigdata = pd.read_pickle(path4 + file4 + ending4)
    sig = sigdata["CH4[V]"].values
    sig_mean = np.mean(sig)
    ausgangsspg4[i] = ausgangsspg4[i] + sig_mean
    i = i + 1

# ===== Plots =====
 
plt.figure("Messung 4 - Ausgangsspg. bei variabler Eingangsspg.")
plt.plot(Vin4,Vout4,'r',label="Simulationsdaten")
plt.hlines(np.mean(Vout4),Vin4[0],Vin4[len(Vin4)-1],'b', label='Mittelwert Simulationsdaten')
plt.plot(eingsspg4, ausgangsspg4, 'rx', label='Messdaten')
plt.plot(eingsspg4, ausgangsspg4, '--')
plt.hlines(np.mean(ausgangsspg4),eingsspg4[0],eingsspg4[len(ausgangsspg4)-1],'green', label='Mittelwert Messdaten')
plt.ylabel("$V_{out}(V_{in})$ in V")
plt.xlabel("$V_{in}$ in V")
plt.title("Darstellung von $V_{out}(V_{in})$")
plt.legend(loc=5 ,prop={'size': 20})
stepgrid()


#%% Plot fuer Messung 5
# Versuch: Strommessung

# ====== Simulation ======

Vout5 = sig5['VOUT'].values
Iout5 = sig5['AM1'].values

i = 2
j = 0

while i > 0.74:
    j += 1
    i = Iout5[j]

Iout5_1 = Iout5[0:j-1]
Vout5_1 = Vout5[0:j-1]

Iout5_2 = Iout5[j:]
Vout5_2 = Vout5[j:]
    
# Downsample
Vout5_2 = Vout5_2[::3000]
Iout5_2 = Iout5_2[::3000]

Vout5_3 = np.append(Vout5_1,Vout5_2)
Iout5_3 = np.append(Iout5_1,Iout5_2)


begin5 = 0
end5 = len(Iout5)

Vout5 = Vout5[begin5:end5]
Iout5 = Iout5[begin5:end5]

#===== Messung =======

# Variablen zurücksetzen
time = None
file = None
sigdata = None
sig = None
sig_mean = None

# Einlesen der Messdaten
sigdata = pd.read_pickle(path5 + "Strommessung" + ending5)
sig = sigdata["[Vout]"].values
sig1 = sigdata["Vshunt[V]"].values
Versuch5_Vout = sig
Versuch5_Iout = sig1 / 1 # I = U / R
I_out_5 = np.linspace(min(Versuch5_Iout),max(Versuch5_Iout),len(Vout5_3)) # x-Achse für Simulationsdaten erzeugen

# Gegenüber der Theorie bricht die Schaltung ab 2,4 A zusammen und nicht erst bei 2,5 !!!!

#====== Plots ========
plt.figure("Messung 5 - Strommessung")
plt.plot(Iout5_3, Vout5_3, label="Simulationsdaten")
plt.hlines(np.mean(Vout5_3),min(Iout5_3),max(Iout5_3), label='Mittelwert Simulationsdaten')
plt.plot(Versuch5_Iout, Versuch5_Vout,'--')
plt.plot(Versuch5_Iout, Versuch5_Vout,"rx",label="Messdaten")
plt.xlim(0.125,2.5)
plt.ylabel("$V_{out}$ in V")
plt.xlabel("$I_{out}$ in A")
plt.title("Spannungs-Strom-Diagramm an der Last")
plt.annotate(r'0.125',xy=(0.125,4.7), xycoords='data',xytext=(-33, -26), textcoords='offset points')
stepgrid()
plt.grid(b=True, which='major', color='gray', linestyle='-',linewidth=1)
plt.grid(b=True, which='minor', color='gray', linestyle='-',linewidth=0.5)
plt.minorticks_on()
plt.legend(loc=3 ,prop={'size': 25})


#%% Plot fuer Messung 6
# Versuch: Variieren der Eingangsspannung für eine geregelte Ausgangsspannung 
# von 5V und beobachten der Änderung des Tastverhältnisses der PWM-Wellenform.

# ===== Messung ======

duty_cycle_mess = pd.read_excel(path4 + 'Messdaten_ANS.xlsx', sheet_name='Tabelle1') # in %
duty_messw = duty_cycle_mess["%"].values
duty_cycle_cal = (ausgangsspg4 / eingsspg4) * 100 # in %


# ===== theoretische Berechnung =====

Vout = 4.95377 # in V
Vin = np.arange(10,15,0.01 ) # in V
duty_cycle_theor = (Vout / Vin) * 100 # in %

#plt.rcParams.update({'font.size':22})

plt.figure("Messung 6 - Duty Cycle")
plt.plot(duty_cycle_cal, eingsspg4,'rx--', label="ermittelt aus gemessener Eingangs- und Ausgangsspg.")
plt.plot(duty_cycle_theor, Vin,'k', label="ermittelt aus theoretischer Eingangs- und Ausgangsspg.")
plt.ylabel("Eingangsspannung $V_{in}$ in V")
plt.xlabel("Tastgrad in Prozent %")
plt.title("Eingangsspannung im Verhältnis zum Tastgrad $= \dfrac{V_{out}}{V_{in}}$")
plt.legend(prop={'size': 25})
stepgrid()
