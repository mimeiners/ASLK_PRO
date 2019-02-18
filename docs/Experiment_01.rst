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

.. figure:: img/Experement_01_fig_02.png
	 :name: 01_fig_02
	 :align: center

	 Schematische Darstellung einer UnityGain-Schaltung

Aufgrund des internen Aufbaus eines Operationsverstärkers, unterliegt dieser technisch-physiklaischen Grenzen.
Diese sollen hier theoretisch und messtechnisch untersucht werden. Als Grundlage eignet sich die UnityGain-Schaltung.
Diese Schaltung ist eine *Rückkopplung* des Ausgangs auf den invertierenden Eingang des Opams.
Aus der Theorie wissen wir, dass der Ausgang eines unberschaltetenen Opams gleich dem
Verstärkungsfaktor :math:`A_0` multipliziert mit der Differenz der beiden Eingänge ist.
Damit ergibt sich für den unbeschalteten Operationsverstärker:

.. math::
   :label: 01_eq_01

   U_{OUT} = A_0 \cdot (U_+ - U_-)

Durch die Beschaltung des UnityGain

