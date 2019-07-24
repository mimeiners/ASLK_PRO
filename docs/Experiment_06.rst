Experiment 6: Voltage controlled oscillator (VCO)
=====================================================


Theorie und Motivation
----------------------
Voltage controlled oscillator sind Schaltungen, die die Frequenz der Ausgangsspannung in Abhängigkeit der Eingangsspannung ändern. Bekannt ist auch die Wirkung als Funktionsgenerator mit einem Rechtecksignal am Ausgang.
In der Praxis kann die Schaltung in der elektronischen Musik als Synthesizer, bei Motorregelungen, als Funktionsgenerator und beim  Sendersuchlauf in Verbindung mit PLL genutzt werden.

Ein VCO kann mit Hilfe eines Multiplizierers, eine Integrierers und eines nicht invertierenden Schmitt-Triggers realisiert werden.
Als erstes wird das Schmitt-Trigger-Glied versuchstechnisch genauer unter die Lupe genommen. Dazu ändert sich der Rückführungswiderstand und die Wirkungsweise wird analysiert in Abhängigkeit eines Sinus-Signals. Dafür liegt eine Spice-Simulation vor, die anschließend messtechnisch aufgenommen wird. Anschließend werden die simulierten Werte mit den Gemessenen unter Zuhilfenahme von Matlab verglichen.

Als zweiten Versuch wird die gesamte VCO-Schaltung untersucht. Die Eingangsgleichspannung wird von 1V bis 10V variiert und die Ausgangsspannung gemessen. Ein Matlabprogramm legt nun beide Ausgangskurven eingerückt übereinander und setzt sie in Verbindung mit der Eingangsspannung. Für einen gleichmäßigen High- und Low-Pegel muss eine kleine Anpassschaltung das Ausgangssignal leicht manipulieren. Die Veränderung dieser Anpassschaltung wird mit der Frequenz der Ausgangsspannung in einen Grafen und mit der Eingangsspannung in einen anderen Grafen aufgetragen.



Spezifikation
-------------

Schaltungsaufbau Schmitt-Trigger
-------------------------------
Der Schmitt Trigger besteht in diesem Fall aus 3 Bauelementen.
- 2 Widerstände
- Operationsverstärker

gtrgrtgrtg

.. figure:: img/Experiment_06/Voltage_Controlled_Oscillator_Schaltplan_Schmitt_Trigger.png
	    :name:  06_fig_01
	    :align: center
	    :scale: 40%

	    Schmitt Trigger Schaltplan
		

Schaltungsaufbau VCO
-------------------------------
fwefwefew


Fazit
-----

cceferfrefre


