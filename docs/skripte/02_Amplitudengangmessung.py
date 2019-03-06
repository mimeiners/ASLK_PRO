#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 12 13:16:39 2019

@author: Selim Cimen
"""


import time 
import numpy as np
import redpitaya_scpi as scpi
#import matplotlib.pyplot as plt


# Paramter für die Messung
Start_f = 1000                                        #Start Frequenz der Messung 
Stop_f = 6100000                                      #Stop Frequenz der Messung
Messpunkte = 100                                      #Anzahl der gewünschten Messpunkte
IP = "192.168.111.184"                                #IP-Adresse vom Red-Pitaya

Frequenzen = np.linspace(Start_f, Stop_f, Messpunkte) #Erzeugung Messpunkte im Frequenzbereich
Wave_form = 'sine'                                    #Wellenform des Eingangssignals
Ampl = 1                                              #Amplitude des Eingangssignals
Downsampling = "1"                                    #Downsamplingrate (decimation factor)
Triggerverzoegerung = "0"                             #Verzögerung des Triggers 
Index = 0                                             #Processvariable
Data = np.zeros(len(Frequenzen))                      #Anlegen eines Vektors für die Messergebnisse 


Name = input("Name der Input Textfile: ") + ".txt"                           #Eingabe des Dateiennamens
Dateiname = "/Users/selimcimen/Documents/Python/Analoge_Schaltungen/" +Name  #Speicherpfad

rp_s = scpi.scpi(IP)                                    #Verbindung herstellen zum Red Pitaya
rp_s.tx_txt('GEN:RST')                                  #Signal Generator reset
rp_s.tx_txt('ACQ:RST')                                  #Input reset

for i in Frequenzen:
    
    #Signal Generieren
    rp_s.tx_txt('SOUR1:FUNC '+ str(Wave_form).upper())  #Wellenform sezten
    rp_s.tx_txt('SOUR1:VOLT '+ str(Ampl))               #Amplitude setzen
    rp_s.tx_txt('SOUR1:FREQ:FIX ' + str(i))             #Frequenz setzen
    rp_s.tx_txt('OUTPUT1:STATE ON')                     #Ausgang am Red Pitaya einschalten
    
    #Trigger variablen sezten
    rp_s.tx_txt('ACQ:DEC ' + Downsampling)              #Downsampling setzen
    rp_s.tx_txt('ACQ:TRIG:LEV 0')                       #Triggerlevel setzen
    rp_s.tx_txt('ACQ:TRIG:DLY ' + Triggerverzoegerung)  #Verzögerung für Trigger setzen
    rp_s.tx_txt('ACQ:START')                            #Start der Messung
    time.sleep(1)
    
    rp_s.tx_txt('ACQ:TRIG NOW')                         #Signal Genarator triggern
    rp_s.tx_txt('OUTPUT1:STATE OFF')                    #Buffer wurde beschrieben Ausgang am Red Pitaya ausschalten
    
    # Datenerfassung fuer Input 1
    rp_s.tx_txt('ACQ:SOUR1:DATA?')                                          #Auslesen des Buffers auf Input 1
    Buffstring1 = rp_s.rx_txt()                                             #Speichern der Messergebnisse
    Buffstring1 = Buffstring1.strip('{}\n\r').replace("  ", "").split(',')  #Zeichen austauschen 
    Buff1 = np.array(list(map(float, Buffstring1)))                         #von String in float Vektor umwandeln
    time.sleep(1)                                                           #Pause

    # Datenerfassung fuer Input 2
    rp_s.tx_txt('ACQ:SOUR2:DATA?')                                          #Auslesen des Buffers auf Input 2
    Buffstring2 = rp_s.rx_txt()                                             #Speichern der Messergebnisse
    Buffstring2 = Buffstring2.strip('{}\n\r').replace("  ", "").split(',')  #Zeichen austauschen 
    Buff2 = np.array(list(map(float, Buffstring2)))                         #von String in float Vektor umwandeln
    time.sleep(1)                                                           #Pause  

    
    
    Data[Index] = np.amax(abs(Buff2))/np.amax(abs(Buff1))                   #Verhältnis von Ausgang zu Eingang speichern

    Index+=1                                             #Processvariable um eins erhöhen
    
    v = int(Index/Messpunkte*100)                        #Ermittlung des Fortschritts der Messung
    print("Fortschritt der Messung: ",v,"%")             #Ausgabe des Fortschritts
    
Werte = np.matrix([Frequenzen,Data]).transpose()         #Messfrequenzen und Messergebnisse speichern
np.savetxt(Dateiname, Werte)                             #Als Datei speichern
rp_s.tx_txt('OUTPUT1:STATE OFF')                         #Ausgang des Red Pitayas ausschalten
print("Messung beendet")
