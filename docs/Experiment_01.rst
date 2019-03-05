Experiment 1: Gegenkopplungsverstärker und Instrumentenverstärker
=================================================================

In diesem Experiment sollen drei Grundschaltungen eines
Operationsverstärkers untersucht werden. Zu diesen gehören ein
Impedanzwandler, auch Spannungsfolger genannt,
ein invertierender und ein nicht-invertierender Verstärker. Zum 
Schluss werden unterschiedliche Schaltungen eines
Instrumentenverstärkers betrachtet.

Bei der Berechnungen von OP-Schaltungen werden die
Operationsverstärker (Opamp) für erste Näherungen idealisiert
angenommen. Das heißt, dass die Opamps einen unendlich hohen
Verstärkungfaktor sowie Eingangswiderstand aufweisen. Dazu kommt ein
unendlich große Bandbreite. Ein Ausgangswiderstand existiert
nicht. Geht man in die Praxis über, stellt man sehr schnell fest, dass
alle gennaten Werte endlich sind und beim Messen unterschiedliche
Probleme verursachen können. Das Ziel dieses Experiments ist eine
messtechnische Untersuchung der Grundschaltungen eines Opams und ein
Gewinn an Wissen und Erfahrung beim Umgang mit diesen elektronischen
Bauelementen.


UnityGain - Schaltung
---------------------

Eine UnityGain-Schaltung, auch Impedanzwandler oder Spannungsfolger genannt, ist ein von Ausgang auf den
invertierenden Eingang kurzgeschlosserner Operationsverstärker :numref:`01_fig_02`. 

.. figure:: img/Experiment_01/Experiment_01_fig_02.png
	 :name: 01_fig_02
	 :align: center

	 Schematische Darstellung einer UnityGain-Schaltung

Aufgrund des internen Aufbaus eines Operationsverstärkers, unterliegt dieser technisch-physiklaischen Grenzen.
Diese sollen hier theoretisch und messtechnisch untersucht werden. Als Grundlage eignet sich die UnityGain-Schaltung.
Diese Schaltung ist eine *Rückkopplung* des Ausgangs auf den invertierenden Eingang des Opams.

Aus der Theorie wissen wir, dass der Ausgang eines unberschaltetenen Opams gleich dem
Verstärkungsfaktor :math:`A_0` multipliziert mit der Differenz der beiden Eingänge :math:`U_+` und :math:`U_-` ist.
Damit ergibt sich für den unbeschalteten Operationsverstärker:

.. math::
   :label: 01_eq_01

   U_{OUT} = A_0 \cdot (U_+ - U_-)


Aufgrund der erwähnten *Rückkopplung* kann UnityGain als eine Regelstrecke betrachtet werden. Systemtheoretisch
ist nun das Verhältnis von Ausgang zu Eingang eine Übertragungsfunktion :math:`H(s)`  :eq:`01_eq_02`

.. math::
   :label: 01_eq_02

   \frac{U_{OUT}}{U_{IN}} = \frac{A_0}{1+A_0}

Aufrund der direkten Rückkopplung (ohne andere Bauteile zwischen) kann angenommen werden, dass :math:`A_0` gegen Unendlich strebt.
Durch diese Annahme folgt aus der :eq:`01_eq_02` das Übersetzungverhältnis für eine UnityGain-Schaltung:

.. math::
   :label: 01_eq_03

   \frac{U_{OUT}}{U_{IN}} = 1

Mit diese Erkenntnis kann man nun das Nutzen des UnityGain in Frage stellen. Tatsächlich ist es eine sehr
nützliche Beschaltung eines Operationsverstärkers. Wie bereits erwähnt, kann diese Beschaltung auch als ein
Spannungsfolger oder Impedanzwandler genannt werden. Die Namen werden aus der grundlegenden Funktion dieser Schaltung
abgeleitet. Ein UnityGain liefert am Ausgang die vom Eingang vorgegebene Spannung. Diese ist Lastunabhängig. 
Durch diese Eigenschaft kann der UnityGain als Spannungsstabilisator oder als Entkoppler zweier Teilsystemen eingeetzt werden.
Nach :eq:`01_eq_03` ist die Übertragungsfunktion des UnityGain gleich 1. Das heißt, dass das Ausgangssignal gleich dem Eingangssignal ist. Die Simulations- und Messergebnisse sind in der :numref:`01_fig_03` (oben) dargestellt. Daraus ist ersichtlich, dass sich
die beiden Signale überlagern, was einer Übertragung von 1 entspricht. 

.. figure:: img/Experiment_01/Amplifier_output.png
	    :name: 01_fig_03
	    :align: center

	    Simulationen und Messungen der Ein- und Ausgangsspannungen der 3 grundlegenden Beschaltungsarten
	    eines Oparationsverstärkers
	    \\UnityGain(oben), Non-Inverter (mitte), Inverter (unten)


Nichtinvertierende- und invertierende Operationsverstärkerschaltungen
---------------------------------------------------------------------
   
Zwei weitere grundlegende Schaltungen des Operationsverstärkers sind die sogennante
nichtinvertierende- und invertierende Beschaltung.

.. figure:: img/Experiment_01/Experiment_01_fig_03.png
	 :name: 01_fig_04
	 :align: center

	 Nichtinvertierende (links) und invertierende (rechts) Verstärker

Sowohl bei dem nichtinvertierenden sowie dem invertierenden Verstärker hängt der
Verstärkungsfaktor :math:`A_0` von dem Verhältnis der beiden Widerstände. Somit ergibt sich für die beiden Beschaltungsarten

.. math::
   :label: 01_eq_04

   A_0 = \frac{R_2}{R_1}

Dabei ist :math:`R_1` der Widerstand der an dem invertierenden Eingang anliegt und :math:`R_2` der zwischen
dem Ausgang und dem invertierenden Eingang liegt (:numref:`01_fig_04`).  
Der Unterschied zwischen den beiden Schlatungsarten ist das Phasenverhältnis. Bei dem nichtinvertierenden
Verstärker wird das Eingangssignal in Phase um das Widerstandsverhältnis verstärkt. Die Simulation und
Messung sind in :numref:`01_fig_03` (mitte) graphisch dargestellt.  
