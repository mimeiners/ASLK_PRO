Experiment 4: Analoge Filter
============================

Kurze Theorie und Motivation
----------------------------
In der Nachrichtentechnik ist der Einsatz von Filtern unerlässlich. Gerade beim Einsatz höhergradige Filter geht, kommt es zu Problemen. 
Passive Filter, also RLC-Schaltungen werden gerade bei höheren Frequezen aufgrund der den Spulen eigenen Eigenschaften häufig sehr groß und ungenau.
Um dem entgegenzuwirken verwendet man aktive Filter aus Operationsverstärkern, Kondensatoren und Widerständen. 
Diese Bauteile lassen sich deutlich genauer bestimmen und herstellen als das bei Spulen möglich ist. 
Die Spulen weren hierbei durch Integriererschaltungen ersetzt. 


Spezifikation
-------------

Es soll der Filter mit einer Güte Q = 1 und einer Kreisfrequenz :math:`\omega` = 1kHz realisiert werden.
Zur Dimensionierung der Bauteile wurden folgende Formeln verwendet:

*Formel omega*
*Formel Q*

Mithilfe der ersten Gleichung wurde *R* berechnet, dafür wurde eine Kapazität C = 100nF gewählt.
*R* beträgt 10 :math:`k\Omega`.
Die zweite Formel wurde zur Berechnung von *R2* genutzt. Für *R1* und *R3* wurde je ein Widerstandswert von 1 :math:`k\Omega` gewählt. Die beiden Widerstände wurden gleichgroß gewählt, da sie am Eingang 
des Operationsverstärkers einen Spannungsteiler bilden. Für *R4* wurden 10 :math:`k\Omega` ausgewählt. *R2* beträgt 500 :math:`\Omega`.   

Die gewählten Werte wurden im Verlauf der Dimensionerung verändert, die berechneten Werte entsprechend angepasst. Die hier angegebenen Werte sind die, mit denen die beste Simulaiton erfolgt ist. 

Messungen
---------
