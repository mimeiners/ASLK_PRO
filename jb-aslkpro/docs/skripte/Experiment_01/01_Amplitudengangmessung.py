#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 12 13:16:39 2019

@author: Selim Cimen
"""

# Bitte beachten Sie die Messspitzen des Red Pitaya auf das Verhältnis 1:10 einzustellen 

import time 
import numpy as np
from redpitaya import redpitaya_scpi as scpi
import matplotlib.pyplot as plt
import scipy as sp
from scipy import signal


# Parameter für die Messung
Start_f = 10             # Start Frequenz der Messung 
Stop_f = 7000000         # Stop Frequenz der Messung
Messpunkte = 35          # Anzahl der gewünschten Messpunkte
IP = "192.168.111.184"   # IP-Adresse vom Red-Pitaya

Frequenzen = np.logspace(np.log10(Start_f), np.log10(Stop_f), Messpunkte)  # Erzeugung Messpunkte im Frequenzbereich
Wave_form = 'sine'                                    # Wellenform des Eingangssignals
Ampl = 1                                              # Amplitude des Eingangssignals
Downsampling = "1"                                    # Downsamplingrate (decimation factor)
Triggerverzoegerung = "0"                             # Verzögerung des Triggers 
Index = 0                                             # Processvariable
Data1 = np.zeros(len(Frequenzen))                     # Anlegen eines Vektors für die Messergebnisse
Data2 = np.zeros(len(Frequenzen))                     # Anlegen eines Vektors für die Messergebnisse

Name = input("Name der Input Textfile: ") + ".txt"    # Eingabe des Dateiennamens
# Dateiname = "/Users/selimcimen/Documents/Python/Analoge_Schaltungen/" +Name  # Speicherpfad

rp_s = scpi.scpi(IP)                                  #Verbindung herstellen zum Red Pitaya
time.sleep(0.3)
rp_s.tx_txt('GEN:RST')                                #Signal Generator reset
time.sleep(0.3)
rp_s.tx_txt('ACQ:RST')                                #Input reset

for i in Frequenzen:
    
    # Signal Generieren
    rp_s.tx_txt('SOUR1:FUNC '+ str(Wave_form).upper())  #Wellenform sezten
    time.sleep(0.3)
    rp_s.tx_txt('SOUR1:VOLT '+ str(Ampl))               #Amplitude setzen
    time.sleep(0.3)
    rp_s.tx_txt('SOUR1:FREQ:FIX ' + str(i))             #Frequenz setzen
    time.sleep(0.3)
    rp_s.tx_txt('OUTPUT1:STATE ON')                     #Ausgang am Red Pitaya einschalten
    time.sleep(0.3)
    

    # Trigger variablen sezten    
    if (i<=25000):                                      #Downsampling in Abhänigkeit der Frequenz des 
        Downsampling = "8"                              #Eingangssiganls
    if (i<1000):
        Downsampling = "64"
    if (i<=100):
        Downsampling = "1024"
    if (i<=20):
        Downsampling = "8192"
    if(i>250000):
        Downsampling = "1"

    #rp_s.tx_txt('ACQ:AVG ' + "ON")                     #Average setzen
    #time.sleep(0.2)    
    rp_s.tx_txt('ACQ:DEC ' + Downsampling)              #Downsampling setzen
    time.sleep(0.3)
    rp_s.tx_txt('ACQ:TRIG:LEV 0')                       #Triggerlevel setzen
    time.sleep(0.3)
    rp_s.tx_txt('ACQ:TRIG:DLY ' + Triggerverzoegerung)  #Verzögerung für Trigger setzen
    time.sleep(0.3)
    rp_s.tx_txt('ACQ:START')                            #Start der Messung
    time.sleep(0.3)
    rp_s.tx_txt('ACQ:TRIG NOW')                         #Signal Genarator triggern
    time.sleep(0.3)

    
    # Datenerfassung fuer Input 1
    
    rp_s.tx_txt('ACQ:SOUR1:DATA?')                                                #Auslesen des Buffers auf Input 1
    Buffstring1 = rp_s.rx_txt()                                                   #Speichern der Messergebnisse
    Buffstring1 = Buffstring1.strip('{}\n\r\E\R\!').replace("  ", "").split(',')  #Zeichen austauschen 
    Buff1 = np.array(list(map(float, Buffstring1)))                               #von String in float Vektor umwandeln 


    # Datenerfassung fuer Input 2
    rp_s.tx_txt('ACQ:SOUR2:DATA?')                                                #Auslesen des Buffers auf Input 2
    Buffstring2 = rp_s.rx_txt()                                                   #Speichern der Messergebnisse
    Buffstring2 = Buffstring2.strip('{}\n\r\E\R\!').replace("  ", "").split(',')  #Zeichen austauschen 
    Buff2 = np.array(list(map(float, Buffstring2)))                               #von String in float Vektor umwandeln
    
    # ohne offset am Ausgang wichtig eine Variante auskommentieren!
    #V_in = np.array(abs(Buff1))
    #V_out = np.array(abs(Buff2))
    #V_in = sum(V_in)/16384
    #V_out = sum(V_out)/16384
    
    # mit offset am Ausgang wichtig eine Variante auskommentieren!
    V_in = np.amax(Buff1)-np.amin(Buff1)
    V_out = np.amax(Buff2)-np.amin(Buff2)
    
    # Amplitudengang ermitteln
    Data1[Index] = V_out/V_in                               # Verhältnis von Ausgang zu Eingang speichern
    Data2[Index] = 20*np.log10(V_out/V_in)                  # Verhältnis in dB von Ausgang zu Eingang speichern
    Index+=1                                                # Processvariable um eins erhöhen
    v = int(Index/Messpunkte*100)                           # Ermittlung des Fortschritts der Messung
    print("Fortschritt der Messung: ",v,"%")                # Ausgabe des Fortschritts
    
    if (v < 11):                                            # LED's auf dem Red Pitaya ansteuern: Statusanzeige
        rp_s.tx_txt('DIG:PIN LED' + str(0) + ',' + str(1))
    if (v > 22):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(1) + ',' + str(1))
    if (v > 33):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(2) + ',' + str(1))
    if (v > 44):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(3) + ',' + str(1))
    if (v > 55):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(4) + ',' + str(1))
    if (v > 66):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(5) + ',' + str(1))
    if (v > 77):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(6) + ',' + str(1))
    if (v > 88):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(7) + ',' + str(1))
    if (v > 96):                                          
        rp_s.tx_txt('DIG:PIN LED' + str(8) + ',' + str(1))


Werte = np.matrix([Frequenzen,Data1,Data2]).transpose()     # Messfrequenzen und Messergebnisse speichern
np.savetxt(Name, Werte)                                # Als Datei speichern
rp_s.tx_txt('OUTPUT1:STATE OFF')                            # Ausgang des Red Pitayas ausschalten
print("Messung beendet")

for k in range(8):
    rp_s.tx_txt('DIG:PIN LED' + str(k) + ',' + str(0))      # LED's ausschalten
    time.sleep(0.1)

Data2 = sp.signal.medfilt(Data2, 3)


#  Plot der Messung
plt.figure(1)
plt.semilogx(Frequenzen[1:], Data2[1:])
plt.grid()
plt.xlabel('Frequency f/Hz')
plt.ylabel('Magnitude A/dB')
plt.show()
