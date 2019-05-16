Experiment 9: DC-DC Koverter

============================


Kurze Theorie und Motivation
----------------------------

Ein DC-DC Wandler wird dazu genutzt, um eine DC-Spannung in eine andere DC-Spannung umzuwwandeln. Hierbei kann die Spannung am Ausgang gegenüber der Eingangsspannung in ihrer Größe verändert, oder auch invertiert sein. Die Ausgangsspannung und ihr Schaltverhalten ist hierbei abhängig von den einhergehenden Größen des DC-Wandlers. Die einspeisende Gleichspannung :math:`V_{ref}` und die aus dem Funktionsgenerator einfließende Dreiecksspannung :math:`V_{g}`, dienen als Referenzwert dazu, in welchem Takt der Operationsverstärker schaltet. Die Ausgangsgröße des Operationsverstärkers :math:`V_{o}` bildet sich demnach aus der einfließenden Dreiecksspannung, der einfließenden Gleichspannung, sowie der Versorgungsspannung :math:`V_{ss}`, welche die Größe der Ausgangsspannung :math:`V_{o}` bestimmt. Ein abschließender LC-Tiefpassfilter hinter dem Operationsverstärker wird zur Stabilisierung und damit zur Glättung der Ausgangsspannung :math:`V_{av}` genutzt.

Funktionsaufbau DC-DC Wandler
-------------

Für die nachfolgende Bearbeitung wird auf zwei unterschiedliche Schaltungen eingegangen. Begonnen wird hierbei mit einem DC-DC Wandler, welcher mithilfe eines aus einem Funktionsgenerator generierten Signals, eine Ausgangsspannung erzeugen soll, dargestellt in :numref:`01_fig_01`.

.. figure:: img/Experiment_09/Schaltung_DC_DC.png
	 :name:  09_fig_01
	 :align: center

	 DC-DC-Wandler

Die eingespeiste Dreiecksspannung aus dem Funktionsgegenrator :math:`V_{g}`, zusammen mit der Referenzspannung :math:`V_{ref}` bestimmen das Tastverhältnis des Komparators und geben so die Länge der Pulse an, in welchem die Ausgangsspannung :math:`V_{o}` aus dem Operatonsverstärker austritt. Für das Tastverhältnis ergibt sich folgende Referenz:

.. math::
   :label: 09_eq_01

   \frac{\tau}{T} = \frac{1}{2}(1-V_{ref}/V_{p})

T gibt hierbei die Periode des aus dem Funktionsgegenrator ausgehenden Dreiecksignals an. Das Tastverhältnis ist hierbei proportional zur Referenzsspannung :math:`V_{ref}`. Die Größe der Ausgangsspannung ist hierbei abhängig von der Betriebsspannung :math:`V_{ss}` des Operationsverstärkers und der Referenzspannung :math:`V_{ref}`. Mithilfe eines LC-Tiefpasses ist es möglich, es stabiles Ausgangssignal :math:`V_{av}` zu erhalten.

Simulation DC-DC Wandler
-------------

MIthilfe der Software LTSpice XII ist es möglich, den Schaltungsaufbau zu simulieren. Die Schaltung wird hierbei nach dem Schema aus :numref:`09_fig_01` entworfen.

.. figure:: img/Experiment_09/Spannungs_Simu_1.png
	 :name:  09_fig_02
	 :align: center

	 Simulation der Ein- und Ausgangsspannungen

Die Abbildung :numref:`09_fig_02` zeigt den Verlauf der Spannungen :math:`V_{ref}`,:math:`V_{g}`, :math:`V_{o}` und :math:`V_{av}`. 
	 
