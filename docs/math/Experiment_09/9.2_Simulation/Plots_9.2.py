# -*- coding: utf-8 -*-
"""
Created on Tue May 21 14:51:47 2019

@author: Alex
"""


import matplotlib.pyplot as plt

#Plots für Veränderung der Referenzspannung

plt.figure("9.2_Referenzspannung_3v")
plt.plot(ref_3txt[:750,0],ref_3txt[:750,1],label="Referenzspannung")
plt.plot(ref_3txt[:750,0],ref_3txt[:750,2],label="Dreiecksspannung")
plt.plot(ref_3txt[:750,0],ref_3txt[:750,3],label="Smith trigger Ausgang")
plt.plot(ref_3txt[:750,0],ref_3txt[:750,4],label="Ausgangsspannung")
plt.legend()
plt.grid()
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")


plt.figure("9.2_Referenzspannung_1v")
plt.plot(ref_1txt[:1250,0],ref_1txt[:1250,1],label="Referenzspannung")
plt.plot(ref_1txt[:1250,0],ref_1txt[:1250,2],label="Dreiecksspannung")
plt.plot(ref_1txt[:1250,0],ref_1txt[:1250,3],label="Smith trigger Ausgang")
plt.plot(ref_1txt[:1250,0],ref_1txt[:1250,4],label="Ausgangsspannung")
plt.legend()
plt.grid()
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")


#Plots für Veränderung des Wiederstandes R4

plt.figure("9.2_R4_0.8k")
plt.plot(r4_08ktxt[1000:2000,0],r4_08ktxt[1000:2000,1],label="Dreiecksspannung")
plt.plot(r4_08ktxt[1000:2000,0],r4_08ktxt[1000:2000,2],label="Smith trigger Ausgang")
plt.plot(r4_08ktxt[1000:2000,0],r4_08ktxt[1000:2000,3],label="Ausgangsspannung")
plt.plot(r4_08ktxt[1000:2000,0],r4_08ktxt[1000:2000,4],label="Smith trigger Eingang")
plt.legend()
plt.grid()
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")

plt.figure("9.2_R4_1k")
plt.plot(r4_1ktxt[1000:2000,0],r4_1ktxt[1000:2000,1],label="Dreiecksspannung")
plt.plot(r4_1ktxt[1000:2000,0],r4_1ktxt[1000:2000,2],label="Smith trigger Ausgang")
plt.plot(r4_1ktxt[1000:2000,0],r4_1ktxt[1000:2000,3],label="Ausgangsspannung")
plt.plot(r4_1ktxt[1000:2000,0],r4_1ktxt[1000:2000,4],label="Smith trigger Eingang")
plt.legend()
plt.grid()
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")

plt.figure("9.2_R4_4.7k")
plt.plot(r4_47ktxt[1000:2000,0],r4_47ktxt[1000:2000,1],label="Dreiecksspannung")
plt.plot(r4_47ktxt[1000:2000,0],r4_47ktxt[1000:2000,2],label="Smith trigger Ausgang")
plt.plot(r4_47ktxt[1000:2000,0],r4_47ktxt[1000:2000,3],label="Ausgangsspannung")
plt.plot(r4_47ktxt[1000:2000,0],r4_47ktxt[1000:2000,4],label="Smith trigger Eingang")
plt.legend()
plt.grid()
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")

plt.figure("9.2_R4_20k")
plt.plot(r4_20ktxt[1000:2000,0],r4_20ktxt[1000:2000,1],label="Dreiecksspannung")
plt.plot(r4_20ktxt[1000:2000,0],r4_20ktxt[1000:2000,2],label="Smith trigger Ausgang")
plt.plot(r4_20ktxt[1000:2000,0],r4_20ktxt[1000:2000,3],label="Ausgangsspannung")
plt.plot(r4_20ktxt[1000:2000,0],r4_20ktxt[1000:2000,4],label="Smith trigger Eingang")
plt.legend()
plt.grid()
plt.xlabel("Zeit in s")
plt.ylabel("Spannung in V")