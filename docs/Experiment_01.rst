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


Gegenkoplungverstärkerschaltungen
---------------------------------

Unity Gain Verstärker (Spannungsfolger,Impedanzwandler)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In folgenden Messungen sollen Sie die Operationsverstärkerschaltungen
hinsichtlich ihrer Parameter untersuchen. 

1. Untersuchung des Frequenzgangs

   - Bestimmen Sie mittels Matlab/Python den theoretischen
     Frequenzgang für den OP-Amp TL082CP 

   - Untersuchen Sie mit Hilfe des Red Pitaya den Frequenzgang des
     Einheitsverstärkers. 

   - Vergleichen Sie messtechnische und theoretische Ergebnisse.

2. OpAmp als Impedanzwandler

   Bauen Sie in Abb. 1 gegeben Schaltung auf.

   Als Last soll ein :math:`1\k\Omega` Widerstand angeschlossen
   werden. Was passiert mit der Ausgangsspannung? 
   Variieren Sie nun die Ausgangslast und messen Sie dabei die
   Ausgangsspannung. Was stellen Sie fest? Für welchen Zweck könnte
   diese Schaltung verwendet werden?
