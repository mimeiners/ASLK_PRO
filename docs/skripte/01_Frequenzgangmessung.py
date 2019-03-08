#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 12 13:16:39 2019

@author: Selim Cimen
"""


import time 
import numpy as np
import redpitaya_scpi as scpi
import matplotlib.pyplot as plt



# Paramter für die Messung
Start_f = 1000                                        #Start Frequenz der Messung 
Stop_f = 7000000                                      #Stop Frequenz der Messung
Messpunkte = 25                                       #Anzahl der gewünschten Messpunkte
IP = "192.168.111.184"                                #IP-Adresse vom Red-Pitaya

Frequenzen = np.linspace(Start_f, Stop_f, Messpunkte) #Erzeugung Messpunkte im Frequenzbereich
Wave_form = 'sine'                                    #Wellenform des Eingangssignals
Ampl = 1                                              #Amplitude des Eingangssignals
Downsampling = "1"                                    #Downsamplingrate (decimation factor)
Triggerverzoegerung = "0"                             #Verzögerung des Triggers 
Index = 0                                             #Processvariable
Data1 = np.zeros(len(Frequenzen))                     #Anlegen eines Vektors für die Messergebnisse
Data2 = np.zeros(len(Frequenzen))                     #Anlegen eines Vektors für die Messergebnisse 


Name = input("Name der Input Textfile: ") + ".txt"                           #Eingabe des Dateiennamens
Dateiname = "/Users/selimcimen/Documents/Python/Analoge_Schaltungen/" +Name  #Speicherpfad

rp_s = scpi.scpi(IP)                                  #Verbindung herstellen zum Red Pitaya
rp_s.tx_txt('GEN:RST')                                #Signal Generator reset
rp_s.tx_txt('ACQ:RST')                                #Input reset

for i in Frequenzen:
    
    #Signal Generieren

    rp_s.tx_txt('SOUR1:FUNC '+ str(Wave_form).upper())  #Wellenform sezten
    rp_s.tx_txt('SOUR1:VOLT '+ str(Ampl))               #Amplitude setzen
    rp_s.tx_txt('SOUR1:FREQ:FIX ' + str(i))             #Frequenz setzen
    rp_s.tx_txt('OUTPUT1:STATE ON')                     #Ausgang am Red Pitaya einschalten
    
    #Trigger variablen sezten
    if (i<25000):
        Downsampling = "64"
    if (i>=25000):
        Downsampling = "8"
    if(i>250000):
        Downsampling = "1"
    
    time.sleep(2)
    rp_s.tx_txt('ACQ:DEC ' + Downsampling)              #Downsampling setzen
    rp_s.tx_txt('ACQ:TRIG:LEV 0')                       #Triggerlevel setzen
    rp_s.tx_txt('ACQ:TRIG:DLY ' + Triggerverzoegerung)  #Verzögerung für Trigger setzen
    rp_s.tx_txt('ACQ:START')                            #Start der Messung
    
    
    rp_s.tx_txt('ACQ:TRIG NOW')                         #Signal Genarator triggern
    rp_s.tx_txt('OUTPUT1:STATE OFF')                    #Buffer wurde beschrieben Ausgang am Red Pitaya ausschalten
    time.sleep(1)
    
    # Datenerfassung fuer Input 1
    rp_s.tx_txt('ACQ:SOUR1:DATA?')                                          #Auslesen des Buffers auf Input 1
    Buffstring1 = rp_s.rx_txt()                                             #Speichern der Messergebnisse
    Buffstring1 = Buffstring1.strip('{}\n\r\E\R\!').replace("  ", "").split(',')  #Zeichen austauschen 
    Buff1 = np.array(list(map(float, Buffstring1)))                         #von String in float Vektor umwandeln
    time.sleep(1)                                                           #Pause

    # Datenerfassung fuer Input 2
    rp_s.tx_txt('ACQ:SOUR2:DATA?')                                          #Auslesen des Buffers auf Input 2
    Buffstring2 = rp_s.rx_txt()                                             #Speichern der Messergebnisse
    Buffstring2 = Buffstring2.strip('{}\n\r\E\R\!').replace("  ", "").split(',')  #Zeichen austauschen 
    Buff2 = np.array(list(map(float, Buffstring2)))                         #von String in float Vektor umwandeln
    time.sleep(1)                                                           #Pause  

    
    #Amplitudengang ermittelen
    Data1[Index] = np.amax(abs(Buff2))/np.amax(abs(Buff1))  #Verhältnis von Ausgang zu Eingang speichern
    
    #Phasengang ermittelen
    if (Buff1[0] < 0):
        channel_1 = np.array(Buff1)                             #Nulldurchgänge vom Eingang ermittelen
        channel_1[channel_1 > 0] = 0
        channel_1_1 = np.array(np.where(channel_1 == 0))
        channel_1_1_1 = channel_1[channel_1_1[0,0]:]
        channel_1_2 = np.array(np.where(channel_1_1_1 < 0))         
        channel_1_1 = np.transpose(channel_1_1)
        channel_1_2 = np.transpose(channel_1_2)
    
        T = channel_1_2[0,0]*2                                  #Periode ermitteln vom Eingang
        
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
        
        if (Buff2[0]<0):        
            channel_2 = np.array(Buff2)                         #Nulldurchgänge vom Ausgang ermittelen
            channel_2[channel_2 > 0] = 0
            channel_2_1 = np.array(np.where(channel_2 == 0)) 
            delta_phi = ((channel_1_1[0,0]-(channel_2_1[0,0]+(T/2)))/T)*360
        else:
            channel_2 = np.array(Buff2)                         #Nulldurchgänge vom Ausgang ermittelen
            channel_2[channel_2 < 0] = 0
            channel_2_1 = np.array(np.where(channel_2 == 0))
            delta_phi = ((channel_1_1[0,0]-channel_2_1[0,0])/T)*360


    Data2[Index] = delta_phi                                #Speichern der Berechnung

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


Werte = np.matrix([Frequenzen,Data1,Data2]).transpose()     #Messfrequenzen und Messergebnisse speichern
np.savetxt(Dateiname, Werte)                                #Als Datei speichern
rp_s.tx_txt('OUTPUT1:STATE OFF')                            #Ausgang des Red Pitayas ausschalten
print("Messung beendet")

for k in range(8):
    rp_s.tx_txt('DIG:PIN LED' + str(k) + ',' + str(0))      #LED's ausschalten
    time.sleep(0.1)

#Plot der Messung
Data1 = 20 * np.log10(Data1)
mindB = -40
maxdB = 10
#Data2 = np.round(Data2)

plt.figure(1)
plt.subplot(2,1,1)
plt.semilogx(Frequenzen, Data1)
plt.grid()
plt.xlabel('Frequency f/Hz')
plt.ylabel('Magnitude A/dB')
plt.axis([np.min(Frequenzen), np.max(Frequenzen), mindB, maxdB])

Frequenzen = Frequenzen[1:]
Data2 = Data2[1:]

plt.subplot(2,1,2)
plt.semilogx(Frequenzen, Data2)
plt.grid()
plt.xlabel('Frequency f/Hz')
plt.ylabel('Phase phi/deg')
plt.axis([np.min(Frequenzen), np.max(Frequenzen), -200, 100])
plt.show()
