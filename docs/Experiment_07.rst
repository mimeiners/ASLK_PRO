Experiment 7: Phase Locked Loop (PLL)
=====================================

Grundlagen
-------------------------------------

.. _exp07-pll-high-level:
.. figure:: img/Experiment_07/pll_high_level.png
   :figwidth: 40%
   :align: right

   PLL als Black-Box mit Ein- und Ausgang dargestellt

Die Bezeichnung *PLL* ist ein Akronym des Wortes *Phase Locked Loop* (Phasenregelschleife).
Eine PLL besteht aus einer Anordnung verschiedener Schaltungen, die zum Ziel haben, ein
Ausgangssignal zu generieren, das in fester Phasenrelation zum Eingangssignal steht:

.. math::
    \phi_{out}(t) = \phi_{ref}(t) + const

Eine PLL kann also in erster Näherung als Zweitor mit einem Eingang und einem Ausgang angesehen werden (siehe :numref:`exp07-pll-high-level`)

Durch den Zusammenhang zwischen Phase und Frequenz (:math:`\omega(t) = \frac{\text{d}\phi}{\text{d}t}`) ergibt sich daraus folgende Beziehung:

.. math:: \omega_{out}(t) = \omega_{ref}(t)

.. admonition:: PLL in einem Satz

    Eine PLL besteht aus einem VCO, der über einen Regelkreis so abgestimmt wird, dass sich am Ausgang eine **konstante Phasenbeziehung** zum Eingangssignal einstellt.





Aufbau
------------
In folgendem Abschnitt soll geklärt werden, aus welchen Blöcken bzw. Schaltungselementen eine PLL besteht.
In :numref:`exp07-pll-block` ist die Minimalkonfiguration mit drei Systemkomponenten dargestellt.

.. _exp07-pll-block:
.. figure:: img/Experiment_07/pll_block.png
   :figwidth: 60%
   
   Grundlegendes Blockschaltbild einer PLL

Eine PLL kann z.B. komplett analog, komplett digital, als Mixed-Signal Schaltung oder sogar komplett in Software implementiert werden.
In diesem Dokument wird der Aufbau in analoger Schaltungstechnik beschrieben. Die Grundlegenden Konzepte sind jedoch auch auf andere Implementierungen übertragbar. 

Phasenkomparator
^^^^^^^^^^^^^^^^

Der Phasenkomparator vergleicht das Eingangssignal :math:`u_{ref}` der PLL mit dem generierten
Ausgangssignal :math:`u_{fb}` und gibt eine zur Phasenverschiebung proportionale Spannung :math:`u_e` aus (in Form eines PWM Ausgangs).
In :numref:`exp07-phasecomp-waveforms` ist das Ausgangssignal des Phasenkomparators bei konstantem
Phasenversatz dargestellt.

.. _exp07-phasecomp-waveforms:
.. figure:: img/Experiment_07/phase_comp_waveforms.png
   :figwidth: 60%
   
   Darstellung der Funktionsweise eines Phasenkomparators anhand zweier Beispiele mit unterschiedlichen Phasenverschiebungen

Es ist zu erkennen, dass die gemittelte Ausgangsspannung :math:`\overline{u}_e` größer ist, je
kleiner die Phasenverschiebung zwischen den beiden Eingangssignalen ist.

In :numref:`exp07-phasecomp-freerunning` ist das Ausgangssignal des Phasenkomparators dargestellt,
wenn die beiden Eingangssignale :math:`u_{ref}` und :math:`u_{fb}` eine ungleiche Frequenz
aufweisen:

.. _exp07-phasecomp-freerunning:
.. figure:: img/Experiment_07/phase_comp_freerunning.png
   :figwidth: 60%

   Ausgangssignal bei :math:`f_{ref} \neq f_{fb}`

Durch die Multiplikation der beiden Signale kommt es zu einer Mischung der Frequenzen. Das
Ausgangssignal :math:`u_e` enthält nun die Summen- und Differenzfrequenzen der beiden Eingänge. In
dem unteren Graphen ist das Ausgangssignal zusätzlich mit einem Tiefpass gefiltert dargestellt. Nach
der Filterung ist hier fast ausschließlich die Differenzfrequenz :math:`|f_{ref} - f_{fb}|` erkennbar. Je größer die
Differenz der Frequenzen der Eingänge ist, desto größer ist die Frequenz des Ausgangssignals
:math:`\overline{u}_e`. Mit diesem Verständnis kann später bei der Auslegung des Schleifenfilters
die Capture Range optimiert werden.
   
Phasenkomparatoren können z.B. mit einem Analogmultiplizierer oder für digitale PLLs mit einem XOR-Glied oder einem Flip-Flop realisiert werden.
Abhängig von der gewählten Implementierung können sich die
Phasenverschiebungs/Ausgangsspannungs-Kennlinien unterscheiden. Da hier eine analoge PLL aufgebaut
werden soll, wird für den Phasenkomparator ein Anlogmultiplizierer eingesetzt. 
Die Kennlinie eines idealen Analogmultiplizierers ist in :numref:`exp07-phasecomp-mult` dargestellt:

.. _exp07-phasecomp-mult:
.. figure:: img/Experiment_07/analog_mult.png
   :figwidth: 70%
   
   Kennlinie eines analogen Analogmultiplizierers
   
Es ist zu erkennen, dass die Ausgangsspannung :math:`\overline{U}_e` bei einer Phasenverschiebung
von 90° einen Wert von 0V annimmt. Da eine Spannung von 0V jedoch am VCO eine Frequenz von 0Hz
ergeben würde (siehe Abschnitt :ref:`exp07-vco`), muss die Ausgangsspannung des Multiplizierers noch mit einem Offset versehen werden:

.. _exp07-phasecomp-mult-offset:
.. figure:: img/Experiment_07/analog_mult_offset.png
   :figwidth: 70%
   
   Kennlinie eines Analogen Analogmultiplizierers mit Offset
   
In :numref:`exp07-phasecomp-mult-offset` ist der Analogmultiplizierer mit nachgeschaltetem Addierer
für den Offset dargestellt. 
Über die Offsetspannung :math:`U_{bias}` kann die Free-running Frequenz der PLL eingestellt werden.
Zusätzlich wurde der Ausgang des Multiplizierers mit einem Skalierungsfaktor beaufschlagt.


Schleifenfilter
^^^^^^^^^^^^^^^^

Dem Phasenkomparator nachgeschaltet ist der Schleifenfilter. Dieser dient hauptsächlich zur Glättung
des vom Phasenkomparator generierten PWM Signals. Im einfachsten Fall kann ein simpler RC-Tiefpass
eingesetzt werden.

Dennoch ist der Schleifenfilter ein kritisches Element im Regelkreis einer PLL. Er hat z.B. Einfluss
auf die Stabilität des Regelkreises, die Capture-Range, das Phasenrauschen des Ausgangs und die
Einreglzeit. Nachfolgend sind die Auswirkungen der Bandbreite auf verschiedene Eigenschaften einer PLL
aufgelistet:

==============================  =======  =======
Bandbreite:                     Niedrig  Hoch
==============================  =======  =======
Phase margin:                   Gering   Hoch
Capture-Range:                  Klein    Groß
Jitter durch Phasenkomparator:  Gering   Hoch
Jitter durch VCO:               Hoch     Gering
Einregelzeit:                   Langsam  Schnell
==============================  =======  =======

.. _exp07-vco:
VCO
^^^^^^^^^^^^^^^^
Der VCO (Voltage Controlled Oscillator) generiert das Ausgangssignal der PLL.
Die Frequenz des Ausgangssignals ist abhängig von der Eingangsspannung des VCO. In
:numref:`exp07-vco-theoretical-curve` ist die Kennlinie eines idealen VCO dargestellt.

.. _exp07-vco-theoretical-curve:
.. figure:: img/Experiment_07/vco_theoretical_curve.png
   :figwidth: 50%

   :math:`u/f` Kennlinie eines Idealen VCO
   
Da in :doc:`Experiment_06` bereits näher auf die Funktionsweise und die Hintergründe zu dem hier
verwendeten VCO erläutert wurden, soll hier nicht näher darauf eingegangen werden.

Anwendung
------------
PLLs werden in nahezu allen Bereichen der Elektrotechnik verwendet. Nachfolgend sind drei gängige
Anwendungsbeispiele beschrieben:


**Frequenzsynthese:**
Durch den Einsatz eines Frequenzteilers im Feedback-Pfad der PLL kann die Frequenz des Ausgangs um
einen bestimmten Faktor vervielfacht werden.
In modernen Mikroprozessoren sind häufig mehrere PLLs integriert, die für die Generierung der
verschiedenen intern benötigten Frequenzen (z.B. CPU-Clock, Memory-Clock, Peripheral-Clock etc.)
zuständig sind. In einem *i.MX6* (einem ARM A9 SOC) des Herstellers NXP sind für genau diesen
Einsatzzweck 6 verschiedene PLLs eingebaut.

**FM Demodulation:**
Wird am Eingang der PLL ein Frequenzmoduliertes Signal angelegt, sorgt der Regelkreis dafür, dass am Eingang des VCOs immer eine zur momentanen Eingangsfrequenz proportionale Gleichspannung anliegt.
Diese Spannung entspricht direkt dem demodulierten Signal.

**Clock/Carrier Recovery**
Bei der seriellen, asynchronen Datenübertragung (z.B. SATA, SDI) wird genau wie bei den gängigen
Verfahren der Funktechnik (z.B. PSK, ASK) kein separates Taktsignal übertragen.
Im Empfänger muss diese Taktinformation somit aus dem eigentlichen Datenstrom extrahiert werden.
Auch für diesen Einsatzzweck (genannt Clock Recovery bzw. Carrier Recovery) werden PLLs verwendet.

Modellisierung im linearisierten Phasenraum
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Zur Auslegung und Charakterisierung der PLL kann dessen Regelkreis aus systemtheorethischer Sicht
betrachtet werden. Hierzu wird zunächst die LTI Übertragungsfunktion des Regelkreises aufgestellt.
Als Eingangs- bzw. Ausgangsgröße dient hier die Momentanphase der Signale.
In :numref:`exp07-phase-space-model` ist das Blockschaltbild des LTI Systems dargestellt.
Der Phasenkomparator wird als P-Glied mit dem Faktor :math:`K_p` (Steigung der :math:`u/\Delta \phi` Kurve) modelliert. 
:math:`G(s)` bezeichnet die Übertragungsfunktion des Filters, die es herauszufinden bzw. zu
optimieren gilt.
Der VCO wird als I-Glied modelliert, da seine Eingangsspannung nicht direkt die Phase, sondern
die Frequenz steuert. Über die Beziehung :math:`\phi = \int{f}` kann jedoch wieder auf die
Ausgangsphase geschlossen werden.

.. _exp07-phase-space-model:
.. figure:: img/Experiment_07/phase_space_model.png
   :figwidth: 70%

   LTI Modell der PLL im Phasenraum
   
Mit dem aufgestellten Modell wurde zunächst die Stabilität des Regelkreises überprüft.
Hierzu wurde der Regelkreis geöffnet um die open-loop Frequenzantwort zu erhalten. Für den
Der Schleifenfilter wurde auf eine Frequenz von

.. _exp07-phase-margin:
.. figure:: img/Experiment_07/phase_margin.png
   :figwidth: 70%

   Frequenzgang des Open Loop Regelkreises


SPICE Simulation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Praxis
-------------------------------------

Schaltung
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Messungen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

