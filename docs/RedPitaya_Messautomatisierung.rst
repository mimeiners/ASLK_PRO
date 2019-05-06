Red Pitaya Messautomatisierung
==============================

.. _Dokumentation: https://redpitaya.readthedocs.io/en/latest/appsFeatures/remoteControl/remoteControl.html

Author: Selim Cimen, Alexander Huber


Einleitung
----------

Viele moderen Messinstrumente wie Red Pitaya verfügen über eine SCPI (Standard Command for programmable
Instrumentation) Schnittstelle. Diese kann über einen sogennaten remote Control (Fernbedienung) von Programmen
wie Matlab, Python, LabView oder SCILAB gesteuert werden kann. Hierdurch
können zum Beispiel komplexe Signale generiert und über den Signalausgang ausgegeben werden.
Des Weitern können über die FastAnalogInputs, die sogennante FAI, Messdaten aufgezeichnet
und in gewünschten Formen, wie zum Beispiel als Rohdaten, abgespeichert werden. Da die Messdatenerfassung
mittels Matlab, Python, LabView oder SCILAB durchgeführt wird, lassen
sich die aufgezeichneten Messdaten hervorragend aufbereiten.

Eine ausführliche Dokumentation_ mit Beispielen, der Befehlskatalog und
eine Anleitung für den Verbindungsaufbau zwischen Red Pitaya und Mess-PC
ist auf der RedPitaya-Webseite zu finden.

Im Rahmen des "Projekts Analog System Lab Kit Pro Texas" wurden drei
Skripte mittels Python für die Messautomatisierung erstellt und
benutzt. Auf den folgenden Seiten wird näher auf die
Funktionsweise, Probleme bei der Entwicklung und auf evtl.
Verbesserungen der Skripte eingehen.

DCsweep
-------

Das DCsweep-Skript kann zur Ermitttlung der Übertragungseigenschaften
von Systemen für Gleichspannungsverhalten eingesetzt werden.

Hierfür werden durch den Benutzer eine Start- und Endspannung vorgegeben.
Für RedPitaya dürfen die Spannungen die Grenenzen von :math:`1\,V` und :math:`-1\,V`
nicht überschreiten. Hierbei ist eine Eingabe der Messpunkte notwendig. Dadurch wird
die Schrittweite zwischen Start- und Endwert errechnet.

 .. note::
    Als Beispiel soll ein Startwert von -1V und ein Endwert von +1V mit 11 Messpunkten gewählt werden. In diesem Fall werden folgende
    Gleichspannungen generiert und durch den 'fast analog Output'
    ausgegeben.

    math:`V_{OUT}`: -1.0\,V, -0.8\,V, -0.6\,V, -0.4\,V, -0.2\,V, 0\,V, 0.2\,V, 0.4\,V, 0.6\,V, 0.8\,V, 1.0\,V`

Probleme
~~~~~~~~

Generierung der Gleichspannung
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In der oben erwähnten Dokumentation_ ist leider nicht beschrieben, wie eine
Gleichspannung generiert werden kann. Hierfür muss die Wellenform auf
'square' und die Frequenz auf '0' gesetzt werden. Nach dem Setzen der
genannten Parameter lassen sich dann über das Einstellen der Amplitude
verschiedene Gleichspannungen generieren.

Jedoch lässt sich nicht ohne Weiters eine negative Spannung erzeugen.
Hierfür ist das Einstellen eines Offsets notwendig. Angenommen eine
Gleichspannung von :math:`-0.5\,V` soll erzeugt werden. In diesem Beispiel ist ein
Offset von :math:`-1\,V` und eine Amplitude von :math:`0.5\,V` zu wählen.

Größere und kleinere Spannungen als +1V, -1V
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ein weiters Problem ist, dass mit dem Red Pitaya sich keine größeren
Spannungen als :math:`+1\,V` und keine kleineren als .math:`-1\,V` erzeugen lassen. Doch
da sich das Projekt größtenteils mit Operationsversträkern beschäftigt
ist es naheliegend ein nicht-inventierenden Verstärker vorzuschalten um
größere oder kleinere Spannungen zu generieren.

Des Weiteren ist darauf zu achten, dass die Messspitzen auf das
Verhältnis 1:10 einzustellen sind. Hierdurch wird der Messbereich von
:math:`-1\,V - +1\,V` auf :math:`-10\,V - +10\,V` vergrößert.


Amplitundengang
---------------

Mit dem Amplitudengang-Skript lässt sich das Übertragungsverhalten von
Systemen bei verschiedenen Frequenzen messen. Hierbei wird das
Verhältnis von Ausgangsspannung zu Eingangsspannung von der
Startfrequenz bis zur Endfrequenz ermittelt. Somit lässt sich bestimmen
bei welchen Frequenzen das System ein verstärkendes oder dämpfendes
Verhalten aufweist. Die Start- und Endfrequenzen sind durch den Benutzer
zu wählen. Dabei ist, wie beim DCsweep, eine Eingabe der Messpunkte
notwendig.

.. note:: Auch in dieser Messung sind die Messspitzen auf das Verhältnis 1:10
   einzustellen.

Probleme
~~~~~~~~

Messbereich
^^^^^^^^^^^

Da das Verhältnis an den Messspitzen nicht größer als 1:10 eingestellt
werden kann, wird in manchen Fällen das Ende des Messbereichs erreicht.
In der folgenden Abbildung ist der Amplitudengang eines Differenzierers
zu sehen. Es wurde ein Frequenzsweep mit einem Sinus :math:`2\,V_{pp}`
durchgeführt. In der :numref:`redpi_fig_01` ist zu erkennen, dass die Messung nicht
ganz mit der Simulation übereinstimmt. Ursache dafür ist, dass eine
Verstärkung größer als 20dB nicht gemessen werden kann da das Ende des
Messbereichs erreicht wird.

Dieser Fehler könnte durch eine kleinere Amplitude im Eingangssignal
verringert werden. Das ist jedoch keine optimale Lösung.

.. figure:: /img/redpi/amplitudengang_messung_simulation.png
   :name: redpi_fig_01
   :align: center

Phasengang
----------

Mit dem Phasengang-Skript lässt sich die Phasenverschiebung zwischen
Eingangs- und Ausgangssignal messen und aufzeichnen. Duch die Detektion
der Nulldurchgänge vom Eingangs- und Ausgangssignal wird die
Phasenverschiebung ermittelt.

.. note:: Für die Messung sind die Messspitzen auf das Verhältnis 1:1
   einzustellen.

Bestimmung der Periode
~~~~~~~~~~~~~~~~~~~~~~

Zur Bestimmung der Periode sind weitere Aufbereitungen an den Messdaten
notwendig. Die erforderlichen Schritte sind in der :numref:`redpi_fig_02` graphisch dargestellt.
Im obersten Graphen ist das unbearbeitete Eingangssignal
dargestellt. Im ersten Schritt ist festzustellen, ob die ersten Samples
größer oder kleiner null sind. Im unteren Dargestellten Fall sind die
ersten Samples größer null und somit werden die Rohdaten folgendermaßen
aufbereitet. Alle Werte die kleiner null sind, werden durch den Wert
null ersetzt. Wie in der mittleren Abbildung zu sehen. Anschließend
werden im zweiten Schritt die ersten Samples die größer null sind
ausgeschitten. Siehe unterste Abbildung.

Durch die Aufbereitung der Messdaten wurden die unteren Halbwellen des
Sinus durch nullen ersetzt und dies entspricht genau einer halben
Periode. Zur Berechnung der Periode werden nun die Samples gezählt bis
der Eingang größer null ist und das Ergebnis wird mit zwei
Multipliziert. Dies enspricht der Periodendauer in Samples.

.. figure:: /img/redpi/T.png
   :name: redpi_fig_02
   :align: center

Bestimmung der Phasenverschiebung
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Da die Periodendauer im Schritt zuvor bestimmt worden ist, wird nun der
Zeitpunkt des ersten Nulldurchgangs sowohl vom Eingang als auch vom
Ausgang detektiert und miteinander verglichen. In der :numref:`redpi_fig_03`
tritt der erste Nulldurchgang vom Eingang bei Sample 191 und vom Ausgang
bei Sample 382 auf. Die Periodendauer beträgt 764 Sampeles. Mit
folgenden Formeln lassen sich die Phasenverschiebungen berechnen.
Hierbei sind vier Fallunterscheidungen zu beachten.

Input, Output ersten samples > 0 : :math:`\phi = ((Input-Output)/T)*360`

Input, Output ersten samples < 0 : :math:`\phi = ((Input-Output)/T)*360`

Input er. samp. < 0, Output er. samp. > 0: :math:`\phi = ((Input-(Output+T/2))/T)*360`

Input er. samp. > 0, Output er. samp. < 0: :math:`\phi = ((Input-(Output+T/2))/T)*360`

In unserem Beispiel erhalten wir für die Phasenverschiebung:

:math:`\phi = ((191-382)/764)*360 = -90°`

.. figure:: /img/redpi/Eingang_Ausgang.png
   :name: redpi_fig_03
   :align: center

Probleme 
~~~~~~~~~

Rauschen am Ausgang
^^^^^^^^^^^^^^^^^^^

Trotz eines reinen Sinus am Eingang wird das Ausgangssignal sehr
verrauscht. Wie in :numref:`redpi_fig_04` zu sehen. Das Rauschen hat zur
Folge, dass die Nulldurchgänge nicht zuverlässig detektiert werden
können.

.. figure:: /img/redpi/1-10_Verhaeltnis.png
   :name: redpi_fig_04
   :align: center

Ein Auszug(:numref:`redpi_fig_05`) aus dem Python Variablenraum zeigt wie im Ausgangssignal
innerhalb weniger sample mehrere Nulldurchgänge stattfinden. Dies macht
eine Detektion und Vergleich der Nullstellen nach dem oben beschrieben
Schema unmöglich bzw. unzuverlässig.

.. figure:: /img/redpi/Bildschirmfoto.png
   :name: redpi_fig_05
   :align: center

Um den Effekt des Rauschens zu beseitigen können die Rohdaten mit Hilfe
von Python aufbereitet werden. Eine Möglichkeit ist die lineare
Reggression. Dies hat jedoch zur Folge, dass bei hohen Frequenzen das
Ausgangssignal stark im Verlauf verfälscht wird und eine weitere
Auswertung der Daten nicht möglich ist.

Die zweite Möglichkeit ist ein Moving Average Filter, mit dem die Werte
geglättet werden. Hierdurch werden aber die ersten Messwerte
unbrauchbar. Dies stellt jedoch kein Problem dar, denn werden sowohl vom
Eingang als auch vom Ausgang die erste Werte ausgeschnitten, hat dieser
Fehler keinen weiteren Einfluss auf die Auswertung.

.. note:: Des Weiteren sollten die Messspitzen auf das Tastverhältnis von 1:1
   eingestellt werden um den oben genannten Effekt weiter zu verringern.

In der folgenden Abbildung ist der Eingang und Ausgang nach Aufbereitung
der Daten und einem Tastverhältnis von 1:1 zu sehen. Es ist eine
deutliche Verbesserung zu erkennen.

.. figure:: /img/redpi/glatt.png
   :name: redpi_fig_06
   :align: center

Fazit
-----

Mit den oben beschriebenen Skripten wurde im Rahmen des Projekts
"Projekts Analog System Lab Kit Pro Texas " drei Experimente gemessen
und ausgewertet. Das grundsätzliche Übertragungsverhalten wurde
ersichtlich, jedoch kam es zum Teil zu starken Abweichungen. Zu nennen
wäre da die Amplitundenmessung, die auf 20dB begrenzt war.

Bei der Phasenmessung kam es innerhalb einer Messreihe zu einzelenen
sporadischen Fehlmessungen.

Aus den genannten Gründen ist eine exakte Messung mittels Red Pitaya
nicht möglich. Jedoch für den erhalt des groben Übertragungsverhalten
ist die Messautomatisierung gut geeignet.

