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

.. figure:: img/Experiment_04/Experiment_04_Schaltbild.png
	 :name: 04_fig_01
	 :align: center
	 
	 Schaltbild KHN-Biquad-Filter

Es soll der Filter mit einer Güte :math:`Q = 1` und einer Kreisfrequenz :math:`\omega = 1\,kHz` realisiert werden. Bevor die Bauteile dimensioniert wurden, wurden die 
Übertragungsfunktionen für die vier Filter mit Matlab dargestellt.

.. figure:: img/Experiment_04/Berechnung_MATLAB.png
     :name: 04_fig_02
	 :align: center
	 
	 Übertragungsfunktionen mit :math:`Q = 1` und :math:`\omega = 1\,kHz`, Berechnet mit Matlab

Diese Übertragungsfunktionen dienten zur Orientierung für die Dimensionierung und die Simulationen.
  
Zur Dimensionierung der Bauteile wurden folgende Formeln verwendet:

.. math:: 
	:label: 04_eq_01
	
	\omega = \frac{1}{RC}


.. math:: 
	:label: 04_eq_02
	
	Q = \frac{R_1R_2 + R_1R_3 + R_2R_3}{2R_1R_3}

Für die meisten Bauteile mussten Werte angenommen werden. Diese Werte wurden im Verlauf der Dimensionierung immer wieder verändert, bis die Simulation und die berechneten Übertragungsfunktionen möglichst übereinstimmen.

Simulation
----------
Die Simulation wurde mit LTspice XVII durchgeführt.
Dafür musste zuerst das Model für den tl082 eingebunden werden. Die Schaltung wurde nach :numref:`04_fig_01` implemtiert.

.. figure:: img/Experiment_04/Exp_04_SpiceKHN.png
     :name:04_fig_03
	 :align: center
	 
	 Schaltungsaufbau des KHN-Biquad-Filter in LTspice

In :numref:`04_fig_04` sind die Ergebnisse der Simulation zu sehen.

.. figure:: img/Experiment_04/Exp_04_SimulationKHN.png
	 :name: 04_fig_04
	 :align: center
	 
	 Simulation Amplituden- und Phasengang KHN-Biquad-Filter

Vergleicht man die Simulation des KHN-Biquad-Filter mit den berechenten Übertragungsfunktionen, sind die Simulationsergebnisse um ungefähr :math:`-7dB` verschoben, der Verlauf ist aber die gleiche..
 
Nach der Simulation des KHN-Biquad-Filter wurde auch der Universalfilter simuliert. Die Werte der zusätzlichen Bauteile wurden durch Ausprobieren herausgefunden.

.. figure:: img/Experiment_04/Exp_04_SpiceUniversal.png
	 :name: 04_fig_05
	 :align: center
		
	 Schaltungsaufbau des Universalfilters in LTspice
	 
.. figure:: img/Experiment_04/Exp_04_SimulationUniversal.png
     :name: 04_fig_06
	 :align: center
	 
	 Simulation Amplituden- und Phasengang Universalfilter

Beim Vergleich von :numref:`04_fig_04` und :numref:`04_fig_06` ist erkennbar, dass die Amplituden- und Phasengänge des Hochpasses, des Tiefpasses und des Bandpasses unverändert sind.


Messungen
---------
