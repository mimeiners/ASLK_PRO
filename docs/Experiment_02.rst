Experiment 2: Regenerative Rückgekoppelte Systeme und design Astabiler und monostabiler Kippstuffen
===================================================================================================


Kurze Theorie und Motivation
----------------------------

Als Grundlage regenerativer rückgekoppelter Systeme gilt ein sogenanntes Schmitt-Trigger system. Bei diesen Systemen fallen die
Ein- und Ausschaltschwellen nicht zusammen, sondern sind um eine Schalthysterese gegeneinander versetzt. Dadurch kann der
Ausgang :math:`V_{OUT}` nur zwei Zustände annehmen. Durch diese Eigenschaften kann der Schmitt-Trigger zu einer Mixed-Mode Schaltung zugeordnet werden. Der Einsatzgebiet dieser Schaltung ist vielfältig (MOSFET-Treiber als Switch-Controller etc.). 


Messungen Schmitt-Trigger
-------------------------

Zunächst soll ein nicht-invertierender :numref:`02_fig_01` und ein invertierender Schmitt-Trigger :numref:`02_fig_02`
betrachtet werden.

.. figure:: img/Experiment_02/noninv_schmitt.png
   :name: 02_fig_01
   :align: center

   Nicht-invertierende Schmitt-Trigger Schaltung


.. figure:: img/Experiment_02/Inv_schmitt.png
   :name: 02_fig_02
   :align: center

   Invertierende Schmitt-Trigger Schaltung

Bei dem nicht-invertierendem Schmitt-Trigger geht der Zustand von logisch 0 auf logisch 1 bei der positiven
Schwellspannung über und von logisch 1 auf logisch 0 bei der negativen Schwellspannung. Für den invertierenden Schmitt-Trigger
verhalten sich die Zustandänderung invers. Für das Verhälnis der Ausgangs- zu Eingangsspannung ergibt sich:

.. math::
   :label: 02_eq_01
   
   \frac{V_{OUT}}{V_{IN}} = - A_0 \cdot \frac {1}{1-A_0 \cdot \beta}

wobei

.. math::
   :label: 02_eq_02

   \beta = \frac{R_1}{R_1 + R_2}

Das heißst, dass die Schwellspannungen mit Änderung des Wertes für :math:`\beta` eingestellt werden können.
Zur Untersuchung dieser These wurde der nicht-invertierende Schmitt-Trigger simuliert und gemessen. Die Erbebnisse sind
in :numref:`02_fig_03` und :numref:`02_fig_04` enstprechend graphisch dargestellt.

.. figure:: img/Experiment_02/Non_inverting_Schmitt_Simulation.png
   :name: 02_fig_03
   :align: center

   Simulation des nicht-invertierenden Schmitt-Triggers für Verschiedene :math:`\beta`

.. figure:: img/Experiment_02/Non-inverting_Schmitt_Messung.png
   :name: 02_fig_04
   :align: center

   Messung des nicht-invertierenden Schmitt-Triggers für Verschiedene :math:`\beta`

Aus den Darstellung ist ersichlich, dass die Annahme der Abhängigkeit der Schwellspannung von dem :math:`\beta` richtig ist.

Messungen Astabile- und Monostabile Kippstiffen
-----------------------------------------------

Astabile Kippstuffe :numref:`02_fig_05` arbeitet nach dem Prinzipp des Schmitt-Triggers. Diese wechselt periodisch
zwischen zwei Zuständen. Der zeitbestimmende Wert ist die RC-Konstante :math:`\tau`. Die Astabile Kippstuffe ist
eine selbsttreibende Schaltung die die Zustände zwischen den Versorgungsspannungen des Opams wechselt.

.. figure:: img/Experiment_02/astab_multi.png
   :name: 02_fig_05
   :align: center

   Astabiler Multivibrator (Kippstuffe)

Die Simulations- und Messergebnisse sind in :numref:`02_fig_06` und :numref:`02_fig_07` entsprechend graphisch dargestellt.

.. figure:: img/Experiment_02/astabile_kippstufe_Simulation.png
   :name: 02_fig_06
   :align: center

   Astabiler Multivibrator (Kippstuffe) Sumulation

.. figure:: img/Experiment_02/astabile_kippstufe_Messung.png
   :name: 02_fig_07
   :align: center

   Astabiler Multivibrator (Kippstuffe) Messung

