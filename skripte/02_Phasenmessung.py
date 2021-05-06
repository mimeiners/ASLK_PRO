#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 12 13:16:39 2019

@author: Selim Cimen
"""
# Bitte beachten Sie die Messspitzen des Red Pitaya auf das Verhältnis 1:1 einzustellen 


import time 
import numpy as np
from redpitaya import redpitaya_scpi as scpi
import matplotlib.pyplot as plt
import scipy as sp
from scipy import signal


# Paramter für die Messung
Start_f = 10                                          #Start Frequenz der Messung 
Stop_f = 100000                                       #Stop Frequenz der Messung
Messpunkte = 26                                       #Anzahl der gewünschten Messpunkte
IP = "192.168.111.184"                                #IP-Adresse vom Red-Pitaya

Frequenzen = np.logspace(np.log10(Start_f), np.log10(Stop_f), Messpunkte) #Erzeugung Messpunkte im Frequenzbereich
Wave_form = 'sine'                                    #Wellenform des Eingangssignals
Ampl = 1                                              #Amplitude des Eingangssignals
Downsampling = "1"                                    #Downsamplingrate (decimation factor)
Triggerverzoegerung = "0"                             #Verzögerung des Triggers 
Index = 0                                             #Processvariable
Data1 = np.zeros(len(Frequenzen))                     #Anlegen eines Vektors für die Messergebnisse


Name = input("Name der Input Textfile: ") + ".txt"                           #Eingabe des Dateiennamens
Dateiname = "/Users/selimcimen/Documents/Python/Analoge_Schaltungen/" +Name  #Speicherpfad

rp_s = scpi.scpi(IP)                                  #Verbindung herstellen zum Red Pitaya
time.sleep(0.2)
rp_s.tx_txt('GEN:RST')                                #Signal Generator reset
time.sleep(0.2)
rp_s.tx_txt('ACQ:RST')                                #Input reset

for i in Frequenzen:
    
    #Signal Generieren
    rp_s.tx_txt('SOUR1:FUNC '+ str(Wave_form).upper())  #Wellenform sezten
    time.sleep(0.2)
    rp_s.tx_txt('SOUR1:VOLT '+ str(Ampl))               #Amplitude setzen
    time.sleep(0.2)
    rp_s.tx_txt('SOUR1:FREQ:FIX ' + str(i))             #Frequenz setzen
    time.sleep(0.2)    
    rp_s.tx_txt('OUTPUT1:STATE ON')                     #Ausgang am Red Pitaya einschalten

    #Trigger variablen sezten    
    if (i<=25000):
        Downsampling = "8"
    if (i<=1000):
        Downsampling = "64"
    if (i<=200):
        Downsampling = "1024"
    if (i<=10):
        Downsampling = "8192"
    if(i>250000):
        Downsampling = "1"

    #rp_s.tx_txt('ACQ:AVG ' + "ON")                     #Average setzen
    #time.sleep(0.2)    
    rp_s.tx_txt('ACQ:DEC ' + Downsampling)              #Downsampling setzen
    time.sleep(0.2)
    rp_s.tx_txt('ACQ:TRIG:LEV 0')                       #Triggerlevel setzen
    time.sleep(0.2)
    rp_s.tx_txt('ACQ:TRIG:DLY ' + Triggerverzoegerung)  #Verzögerung für Trigger setzen
    time.sleep(0.2)
    rp_s.tx_txt('ACQ:START')                            #Start der Messung
    time.sleep(0.2)
    rp_s.tx_txt('ACQ:TRIG NOW')                         #Signal Genarator triggern
    time.sleep(0.4)
    rp_s.tx_txt('OUTPUT1:STATE OFF')                    #Ausgang am Red Pitaya einschalten
    
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
    
    if(i<1000000):
        Buff1 = sp.signal.medfilt(Buff1,251)
        Buff2 = sp.signal.medfilt(Buff2,251)
        Buff1 = Buff1[151:]
        Buff2 = Buff2[151:]
    if(i<20):
        Buff1 = sp.signal.medfilt(Buff1,251)
        Buff2 = sp.signal.medfilt(Buff2,251)
        Buff1 = Buff1[2551:]
        Buff2 = Buff2[2551:]
    
    if (np.max(abs(Buff2))>0.1):
        #Phasengang ermittelen
        if (Buff1[0] < 0):                                          #Nulldurchgänge vom Eingang ermittelen
            channel_1 = np.array(Buff1)                             
            channel_1[channel_1 > 0] = 0
            channel_1_1 = np.array(np.where(channel_1 == 0))
            channel_1_1_1 = channel_1[channel_1_1[0,0]:]
            channel_1_2 = np.array(np.where(channel_1_1_1 < 0))         
            channel_1_1 = np.transpose(channel_1_1)
            channel_1_2 = np.transpose(channel_1_2)
            T = channel_1_2[0,0]*2                                  #Periode ermitteln vom Eingang
            time.sleep(0.2)
        
            if (Buff2[0]<0):        
                channel_2 = np.array(Buff2)                         #Nulldurchgänge vom Ausgang ermittelen
                channel_2[channel_2 > 0] = 0
                channel_2_1 = np.array(np.where(channel_2 == 0)) 
                delta_phi = ((channel_1_1[0,0]-channel_2_1[0,0])/T)*360
            else:
                channel_2 = np.array(Buff2)                         #Nulldurchgänge vom Ausgang ermittelen
                channel_2[channel_2 < 0] = 0
                channel_2_1 = np.array(np.where(channel_2 == 0)) 
                delta_phi = ((channel_1_1[0,0]-(channel_2_1[0,0]+(T/2)))/T)*360
    
    
        else:
            channel_1 = np.array(Buff1)                             #Nulldurchgänge vom Eingang ermittelen
            channel_1[channel_1 < 0] = 0
            channel_1_1 = np.array(np.where(channel_1 == 0))
            channel_1_1_1 = channel_1[channel_1_1[0,0]:]
            channel_1_2 = np.array(np.where(channel_1_1_1 > 0))         
            channel_1_1 = np.transpose(channel_1_1)
            channel_1_2 = np.transpose(channel_1_2)
            T = channel_1_2[0,0]*2                                  #Periode ermitteln vom Eingang
            time.sleep(0.2)    
        
            if (Buff2[0]<0):                                        #Nulldurchgänge vom Ausgang ermittelen
               channel_2 = np.array(Buff2)                         
               channel_2[channel_2 > 0] = 0
               channel_2_1 = np.array(np.where(channel_2 == 0)) 
               delta_phi = ((channel_1_1[0,0]-(channel_2_1[0,0]+(T/2)))/T)*360
            else:
               channel_2 = np.array(Buff2)                          #Nulldurchgänge vom Ausgang ermittelen
               channel_2[channel_2 < 0] = 0
               channel_2_1 = np.array(np.where(channel_2 == 0))
               delta_phi = ((channel_1_1[0,0]-channel_2_1[0,0])/T)*360
    else:
        delta_phi = 0

    Data1[Index] = np.round(delta_phi)                      #Speichern der Berechnung

    Index+=1                                                #Processvariable um eins erhöhen
    
    v = int(Index/Messpunkte*100)                           #Ermittlung des Fortschritts der Messung
    print("Fortschritt der Messung: ",v,"%")                #Ausgabe des Fortschritts
    
    if (v < 11):                                            #LED's auf dem Red Pitaya ansteuern: Statusanzeige
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


Werte = np.matrix([Frequenzen,Data1]).transpose()           #Messfrequenzen und Messergebnisse speichern
np.savetxt(Dateiname, Werte)                                #Als Datei speichern
rp_s.tx_txt('OUTPUT1:STATE OFF')                            #Ausgang des Red Pitayas ausschalten
print("Messung beendet")

for k in range(8):
    rp_s.tx_txt('DIG:PIN LED' + str(k) + ',' + str(0))      #LED's ausschalten
    time.sleep(0.1)

#Plot der Messung
plt.figure(1)

plt.semilogx(Frequenzen, Data1)
plt.grid()
plt.xlabel('Frequency f/Hz')
plt.ylabel('Phase phi/deg')
plt.ylim((-300,10))
plt.show()
