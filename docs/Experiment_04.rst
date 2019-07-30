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
	
	\omega = \frac{1}{RC} = \frac{1}{\tau}
	
.. math:: 
	:label: 04_eq_02
	
	Q = \frac{R_1R_2 + R_1R_3 + R_2R_3}{2R_1R_3}
	
Der Kondensator, der die Rückkopplungswiderstände bildet, ist für das frequenzabhängige Verhalten der Schaltung verantwortlich. Die Zeitkonstante :math:`\tau` gibt an, wie lange der Kondensator
zum Aufladen benötigt und damit, wann die maximale Ausgangsspannung erreicht ist. Der Kehrwert dieser Zeitkonstante ergibt die gewünschte Kreisfrequenz :math:`\omega`.

Für die meisten Bauteile mussten Werte angenommen werden. Diese Werte wurden im Verlauf der Dimensionierung immer wieder verändert, 
bis die Simulation und die berechneten Übertragungsfunktionen möglichst übereinstimmten.

Simulation
----------
Die Simulation wurde mit LTspice XVII durchgeführt.
Dafür musste zuerst das Model für den tl082 eingebunden werden. Die Schaltung wurde nach :numref:`04_fig_01` implemtiert.

.. figure:: img/Experiment_04/Exp_04_SpiceKHN.png
     :name:04_fig_03
	 :align: center
	 
	 Schaltungsaufbau des KHN-Biquad-Filter in LTspice
	 
Die :numref:`04_fig_03` zeigt Bauteilwerte, mit denen die endgültige Simulation durchgeführt wurde.

In :numref:`04_fig_04` sind die Ergebnisse dieser Simulation zu sehen.

.. figure:: img/Experiment_04/Exp_04_SimulationKHN.png
	 :name: 04_fig_04
	 :align: center
	 
	 Simulation Amplituden- und Phasengang KHN-Biquad-Filter

Vergleicht man die Simulation des KHN-Biquad-Filter mit den berechenten Übertragungsfunktionen, sind die Simulationsergebnisse um ungefähr :math:`-7dB` verschoben, der Verlauf ist aber der Gleiche.
Bei Simualationen mit anderen Bauteilwerten war diese Veschiebung nicht gegeben, dafür wich der Verlauf des Amplituden- und Phasengangs von den berechneten Übertragungsfunktionen erheblich ab
(z.B. starkes Überschwingen, Verschiebung auf der Frequenzachse).
 
Nach der Simulation des KHN-Biquad-Filter wurde auch der Universalfilter simuliert. Die Werte der zusätzlichen Bauteile wurden durch Ausprobieren herausgefunden.

.. figure:: img/Experiment_04/Exp_04_SpiceUniversal.png
	 :name: 04_fig_05
	 :align: center
		
	 Schaltungsaufbau des Universalfilters in LTspice
	
:numref:`04_fig_05` zeigt auch hier wieder die Bauteilwerte, die bei der endgültigen Simulation verwendet wurden.
	 
.. figure:: img/Experiment_04/Exp_04_SimulationUniversal.png
     :name: 04_fig_06
	 :align: center
	 
	 Simulation Amplituden- und Phasengang Universalfilter

Beim Vergleich von :numref:`04_fig_04` und :numref:`04_fig_06` ist erkennbar, dass die Amplituden- und Phasengänge des Hochpasses, des Tiefpasses und des Bandpasses unverändert sind.
Bei der Simulation des Universalfilters wurden auch Ergebnisse erzielt, die nicht die Verschiebung um :math:`-7dB` aufwiesen. Die hier aufgeführte Simulation wurde aufgrund der besseren
Vergleichbarkeit bevorzugt. 


Messungen
---------
