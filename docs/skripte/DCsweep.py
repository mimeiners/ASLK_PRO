#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 12 19:16:39 2019

@author: Selim Cimen
"""


import time 
import numpy as np
import redpitaya_scpi as scpi
#import matplotlib.pyplot as plt


# Paramter für die Messung
Start_V = 1                                           #Start Spannung der Messung 
Stop_V = -1                                           #Stop Spannung der Messung
Messpunkte = 21                                       #Anzahl der gewünschten Messpunkte
IP = "192.168.111.184"                                #IP-Adresse vom Red-Pitaya

Wave_form = 'square'                                  #Wellenform des Eingangssignals
Amplituden = np.linspace(Start_V, Stop_V, Messpunkte) #Messpunkte der Amplituden
Downsampling = "1"                                    #Downsamplingrate (decimation factor)
Triggerverzoegerung = "0"                             #Verzögerung des Triggers 
Index = 0                                             #Processvariable

if (Start_V<Stop_V):
    Ampl =np.linspace(0, Stop_V-Start_V, Messpunkte)  #Amplitude des Eingangssignals
    
if (Start_V>Stop_V):
    Ampl = np.linspace(0, Start_V-Stop_V, Messpunkte) #Amplitude des Eingangssignals
    
Input = np.zeros(len(Ampl))                           #Anlegen eines Input Vektors 
Output = np.zeros(len(Ampl))                          #Anlegen eines Output Vektors

Name = input("Name der Input Textfile: ") + ".txt"                           #Eingabe des Dateiennamens
Dateiname = "/Users/selimcimen/Documents/Python/Analoge_Schaltungen/" +Name  #Speicherpfad

rp_s = scpi.scpi(IP)                                    #Verbindung herstellen zum Red Pitaya
rp_s.tx_txt('GEN:RST')                                  #Signal Generator reset
rp_s.tx_txt('ACQ:RST')                                  #Input reset

for i in Ampl:
    
    #Signal Generieren
    rp_s.tx_txt('SOUR1:FUNC '+ str(Wave_form).upper())      #Wellenform sezten
    
    if (Start_V<Stop_V):
        if (i<Stop_V):
            rp_s.tx_txt('SOUR1:VOLT '+ str(i))              #Amplitude setzen
            rp_s.tx_txt('SOUR1:VOLT:OFFS '+ str(Start_V))   #Setzen vom Offset darf nicht kleiner/größer +-1V sein
    
        if (i>=Stop_V):
            rp_s.tx_txt('SOUR1:VOLT '+ str(i-Start_V))           
            rp_s.tx_txt('SOUR1:VOLT:OFFS '+ str(0))         

    if (Start_V>Stop_V):
        if (i<=Start_V):
            rp_s.tx_txt('SOUR1:VOLT '+ str(Start_V-i))              
            rp_s.tx_txt('SOUR1:VOLT:OFFS '+ str(0))   
    
        if (i>Start_V):
            rp_s.tx_txt('SOUR1:VOLT '+ str((Start_V-(i-Start_V))))       
            rp_s.tx_txt('SOUR1:VOLT:OFFS '+ str(Stop_V))        
            
    rp_s.tx_txt('SOUR1:FREQ:FIX ' + str(0))             #Frequenz setzen
    rp_s.tx_txt('OUTPUT1:STATE ON')                     #Ausgang am Red Pitaya einschalten
    
    #Trigger variablen sezten
    rp_s.tx_txt('ACQ:DEC ' + Downsampling)              #Downsampling setzen
    rp_s.tx_txt('ACQ:TRIG:LEV 0')                       #Triggerlevel setzen
    rp_s.tx_txt('ACQ:TRIG:DLY ' + Triggerverzoegerung)  #Verzögerung für Trigger setzen
    rp_s.tx_txt('ACQ:START')                            #Start der Messung
    time.sleep(1)
    
    rp_s.tx_txt('ACQ:TRIG NOW')                         #Signal Genarator triggern
    time.sleep(1)
    
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

    
    
    Input[Index] = np.max(Buff1)                         #Messdaten vom Eingangssignal
    Output[Index] = np.max(Buff2)                        #Messdaten vom Ausgangssignal
    Index+=1                                             #Processvariable um eins erhöhen
    
    v = int(Index/Messpunkte*100)                        #Ermittlung des Fortschritts der Messung
    print("Fortschritt der Messung: ",v,"%")             #Ausgabe des Fortschritts
    
Werte = np.matrix([Amplituden,Input,Output]).transpose() #Messfrequenzen und Messergebnisse speichern
np.savetxt(Dateiname, Werte)                             #Als Datei speichern
rp_s.tx_txt('OUTPUT1:STATE OFF')                         #Ausgang des Red Pitayas ausschalten
print("Messung beendet")

