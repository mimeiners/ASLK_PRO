Untersuchung der Eigenschaften von Gegenkopplungsverstärkern und Entwurf eines Instrumentenverstärkers
======================================================================================================

In diesem Experiment sollen drei Grundschaltungen eines Operationsverstärkers untersucht werden.
Zu diesen gehören ein Impedanzwandler, auch Spannungsfolger genannter Unity Gain Verstärker, ein invertierender
und ein nicht-invertierender Verstärker. Zum Schluss werden unterschiedliche Schaltungen eines Instrumentenverstärkers betrachtet.
In der Theorie, wie zum Beispiel bei Berechnungen von Schaltungen, werden die Operationsverstärker (Opvs oder auch Opams)
oft idealisiert angenommen. Das heißt, dass die Opams einen unendlich hohen Verstärkungfaktor sowie Eingangswiderstand aufweisen.
Dazu kommt ein unendlich große Bandbreite. Ein Ausgangswiderstand existiert nicht. Geht man in die Praxis über, stellt man sehr schnell fest, dass alle gennaten Werte endlich sind und beim Messen unterschiedliche Probleme verursachen können.
Das Ziel dieses Experiments ist eine messtechnische Untersuchung der Grundschaltungen eines Opams und ein Gewinn an Wissen und Erfahrung beim Umgang mit diesen elektronischen Bauelementen.


Gegenkoplungverstärkerschaltungen
---------------------------------

Unity Gain Verstärker (Spannungsfolger,Impedanzwandler)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


<<<<<<< HEAD

.. math::
   :label: 01_eq_1
	   
   f(t) = \sin(\omega t + \theta)
   
Der Wert von :math:`\theta` ist gleich 0 in der Funktion, die in
:numref:`01_fig_01` dargestellt ist. Aufgrund von :math:`sin(0) = 0`
beginnt die Funktion im Koordinatenursprung bei 0. Dies ist eine
einfache Sinuswelle ohne Zeitversatz, also ohne Phaseverschiebung.
Beachte, wenn man :math:`\omega t` in Radianten in einem Bereich von 0
bis :math:`2 \pi` oder in Gradzahlen von 0 bis :math:`360^{\circ}`
verwendet, erhält man die in :numref:`01_fig_01` dargestellte
Sinuswelle.
=======
>>>>>>> 83c04001d3c10b74ba498ab28ce74a41e7efb2d3

In folgenden Messungen sollen Sie die Operationsverstärkerschaltungen hinsichtlich ihrer Parameter untersuchen.

1. Untersuchung des Frequenzgangs

   - Bestimmen Sie mittels Matlab/Python den theoretischen Frequenzgang für den OP-Amp TL082CP

   - Untersuchen Sie mit Hilfe des RedPitayas den Frequenzgang des Einheitsverstärkers in negativer Rückkopplung

   - Vergleichen Sie die messtechnische und die theoretische Ergebnisse.

2. OP-Ams als Impedanzwandler

   Bauen Sie in Abblindung 1 gegeben Schaltung auf.



   Als Last soll ein :math:`1\k\Omega` Widerstand angeschlossen werden. Was passiert mit der Ausgangsspannung?
   Variiren Sie nun die Ausgangslast und messen Sie dabei die Ausgangsspannung. Was stellen Sie fest? Für welchen
   Zweck könnte diese Schaltung verwendet werden?




