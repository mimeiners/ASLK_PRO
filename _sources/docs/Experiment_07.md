# Phase Locked Loop (PLL)

## Grundlagen

> PLL als Black-Box mit Ein- und Ausgang dargestellt

Die Bezeichnung *PLL* ist ein Akronym des Wortes *Phase Locked Loop*
(Phasenregelschleife). Eine PLL besteht aus einer Anordnung
verschiedener Schaltungen, die zum Ziel haben, ein Ausgangssignal zu
generieren, das in fester Phasenrelation zum Eingangssignal steht:

$$\phi_{out}(t) = \phi_{ref}(t) + const$$

Eine PLL kann also in erster Näherung als Zweitor mit einem Eingang und
einem Ausgang angesehen werden (siehe
`exp07-pll-high-level`{.interpreted-text role="numref"})

Durch den Zusammenhang zwischen Phase und Frequenz
($\omega(t) = \frac{\text{d}\phi}{\text{d}t}$) ergibt sich daraus
folgende Beziehung:

$$\omega_{out}(t) = \omega_{ref}(t)$$

::: admonition
PLL in einem Satz

Eine PLL besteht aus einem VCO, der über einen Regelkreis so abgestimmt
wird, dass sich am Ausgang eine **konstante Phasenbeziehung** zum
Eingangssignal einstellt.
:::

## Aufbau

In folgendem Abschnitt soll geklärt werden, aus welchen Blöcken bzw.
Schaltungselementen eine PLL besteht. In
`exp07-pll-block`{.interpreted-text role="numref"} ist die
Minimalkonfiguration mit drei Systemkomponenten dargestellt.

> Grundlegendes Blockschaltbild einer PLL

Eine PLL kann z.B. komplett analog, komplett digital, als Mixed-Signal
Schaltung oder sogar komplett in Software implementiert werden. In
diesem Dokument wird der Aufbau in analoger Schaltungstechnik
beschrieben. Die Grundlegenden Konzepte sind jedoch auch auf andere
Implementierungen übertragbar.

### Phasenkomparator

Der Phasenkomparator vergleicht das Eingangssignal $u_{ref}$ der PLL mit
dem generierten Ausgangssignal $u_{fb}$ und gibt eine zur
Phasenverschiebung proportionale Spannung $u_e$ aus (in Form eines PWM
Ausgangs). In `exp07-phasecomp-waveforms`{.interpreted-text
role="numref"} ist das Ausgangssignal des Phasenkomparators bei
konstantem Phasenversatz dargestellt.

> Darstellung der Funktionsweise eines Phasenkomparators anhand zweier
> Beispiele mit unterschiedlichen Phasenverschiebungen

Es ist zu erkennen, dass die gemittelte Ausgangsspannung
$\overline{u}_e$ größer ist, je kleiner die Phasenverschiebung zwischen
den beiden Eingangssignalen ist.

In `exp07-phasecomp-freerunning`{.interpreted-text role="numref"} ist
das Ausgangssignal des Phasenkomparators dargestellt, wenn die beiden
Eingangssignale $u_{ref}$ und $u_{fb}$ eine ungleiche Frequenz
aufweisen:

> Ausgangssignal bei $f_{ref} \neq f_{fb}$

Durch die Multiplikation der beiden Signale kommt es zu einer Mischung
der Frequenzen. Das Ausgangssignal $u_e$ enthält nun die Summen- und
Differenzfrequenzen der beiden Eingänge. In dem unteren Graphen ist das
Ausgangssignal zusätzlich mit einem Tiefpass gefiltert dargestellt. Nach
der Filterung ist hier fast ausschließlich die Differenzfrequenz
$|f_{ref} - f_{fb}|$ erkennbar. Je größer die Differenz der Frequenzen
der Eingänge ist, desto größer ist die Frequenz des Ausgangssignals
$\overline{u}_e$. Mit diesem Verständnis kann später bei der Auslegung
des Schleifenfilters die Capture Range optimiert werden.

Phasenkomparatoren können z.B. mit einem Analogmultiplizierer oder für
digitale PLLs mit einem XOR-Glied oder einem Flip-Flop realisiert
werden. Abhängig von der gewählten Implementierung können sich die
Phasenverschiebungs/Ausgangsspannungs-Kennlinien unterscheiden. Da hier
eine analoge PLL aufgebaut werden soll, wird für den Phasenkomparator
ein Anlogmultiplizierer eingesetzt. Die Kennlinie eines idealen
Analogmultiplizierers ist in `exp07-phasecomp-mult`{.interpreted-text
role="numref"} dargestellt:

> Kennlinie eines analogen Analogmultiplizierers

Es ist zu erkennen, dass die Ausgangsspannung $\overline{U}_e$ bei einer
Phasenverschiebung von 90° einen Wert von 0V annimmt. Da eine Spannung
von 0V jedoch am VCO eine Frequenz von 0Hz ergeben würde, muss die
Ausgangsspannung des Multiplizierers noch mit einem Offset versehen
werden:

> Kennlinie eines Analogen Analogmultiplizierers mit Offset

In `exp07-phasecomp-mult-offset`{.interpreted-text role="numref"} ist
der Analogmultiplizierer mit nachgeschaltetem Addierer für den Offset
dargestellt. Über die Offsetspannung $U_{bias}$ kann die Free-running
Frequenz der PLL eingestellt werden. Zusätzlich wurde der Ausgang des
Multiplizierers mit einem Skalierungsfaktor beaufschlagt.

### Schleifenfilter

Dem Phasenkomparator nachgeschaltet ist der Schleifenfilter. Dieser
dient hauptsächlich zur Glättung des vom Phasenkomparator generierten
PWM Signals. Im einfachsten Fall kann ein simpler RC-Tiefpass eingesetzt
werden.

Dennoch ist der Schleifenfilter ein kritisches Element im Regelkreis
einer PLL. Er hat z.B. Einfluss auf die Stabilität des Regelkreises, die
Capture-Range, das Phasenrauschen des Ausgangs und die Einreglzeit.
Nachfolgend sind die Auswirkungen der Bandbreite auf verschiedene
Eigenschaften einer PLL aufgelistet:

  Bandbreite:                      Niedrig   Hoch
  -------------------------------- --------- ---------
  Phase margin:                    Gering    Hoch
  Capture-Range:                   Klein     Groß
  Jitter durch Phasenkomparator:   Gering    Hoch
  Jitter durch VCO:                Hoch      Gering
  Einregelzeit:                    Langsam   Schnell

### VCO

Der VCO (Voltage Controlled Oscillator) generiert das Ausgangssignal der
PLL. Die Frequenz des Ausgangssignals ist abhängig von der
Eingangsspannung des VCO. In
`exp07-vco-theoretical-curve`{.interpreted-text role="numref"} ist die
Kennlinie eines idealen VCO dargestellt.

> $u/f$ Kennlinie eines Idealen VCO

Da in `Experiment_06`{.interpreted-text role="doc"} bereits näher auf
die Funktionsweise und die Hintergründe zu dem hier verwendeten VCO
erläutert wurden, soll hier nicht näher darauf eingegangen werden.

## Anwendung

PLLs werden in nahezu allen Bereichen der Elektrotechnik verwendet.
Nachfolgend sind drei gängige Anwendungsbeispiele beschrieben:

**Frequenzsynthese:** Durch den Einsatz eines Frequenzteilers im
Feedback-Pfad der PLL kann die Frequenz des Ausgangs um einen bestimmten
Faktor vervielfacht werden. In modernen Mikroprozessoren sind häufig
mehrere PLLs integriert, die für die Generierung der verschiedenen
intern benötigten Frequenzen (z.B. CPU-Clock, Memory-Clock,
Peripheral-Clock etc.) zuständig sind. In einem *i.MX6* (einem ARM A9
SOC) des Herstellers NXP sind für genau diesen Einsatzzweck 6
verschiedene PLLs eingebaut.

**FM Demodulation:** Wird am Eingang der PLL ein Frequenzmoduliertes
Signal angelegt, sorgt der Regelkreis dafür, dass am Eingang des VCOs
immer eine zur momentanen Eingangsfrequenz proportionale Gleichspannung
anliegt. Diese Spannung entspricht direkt dem demodulierten Signal.

**Clock/Carrier Recovery** Bei der seriellen, asynchronen
Datenübertragung (z.B. SATA, SDI) wird genau wie bei den gängigen
Verfahren der Funktechnik (z.B. PSK, ASK) kein separates Taktsignal
übertragen. Im Empfänger muss diese Taktinformation somit aus dem
eigentlichen Datenstrom extrahiert werden. Auch für diesen Einsatzzweck
(genannt Clock Recovery bzw. Carrier Recovery) werden PLLs verwendet.

## Modellisierung im linearisierten Phasenraum

Zur Auslegung und Charakterisierung der PLL kann dessen Regelkreis aus
systemtheorethischer Sicht betrachtet werden. Hierzu wird zunächst die
LTI Übertragungsfunktion des Regelkreises aufgestellt. Als Eingangs-
bzw. Ausgangsgröße dient hier die Momentanphase der Signale. In
`exp07-phase-space-model`{.interpreted-text role="numref"} ist das
Blockschaltbild des LTI Systems dargestellt. Der Phasenkomparator wird
als P-Glied mit dem Faktor $K_p$ (Steigung der $u/\Delta \phi$ Kurve)
modelliert. $G(s)$ bezeichnet die Übertragungsfunktion des Filters, die
es herauszufinden bzw. zu optimieren gilt. Der VCO wird als I-Glied
modelliert, da seine Eingangsspannung nicht direkt die Phase, sondern
die Frequenz steuert. Über die Beziehung $\phi = \int{f}$ kann jedoch
wieder auf die Ausgangsphase geschlossen werden.

> LTI Modell der PLL im Phasenraum

Mit dem aufgestellten Modell wurde zunächst die Stabilität des
Regelkreises überprüft. Hierzu wurde der Regelkreis geöffnet um die
open-loop Frequenzantwort zu erhalten. Für den Der Schleifenfilter wurde
auf eine Grenzfrequenz von 50Hz ausgelegt. In
`exp07-phase-margin`{.interpreted-text role="numref"} ist der
Frequenzgang dargestellt.

> Frequenzgang des Open Loop Regelkreises

Aus dem Frequenzgang lässt sich die Phasenreserve zu 21,1° bestimmten.
Damit ist zwar die relative Stabilität des Systems nachgewiesen, jedoch
ist es gängige Praxis eine höhere Phasenreserve anzustreben (bei einem
eventuellen Nachbau sollte also die Grenzfrequenz höher gewählt werden).

Wird der Regelkreis wieder geschlossen, kann der Closed-Loop
Frequenzgang ermittelt werden (siehe `exp07-freq-resp`{.interpreted-text
role="numref"}).

> Frequenzgang des Closed Loop Regelkreises

Aus dem Frequenzgang lässt sich die Grenzfrequenz des gesamten
Regelkreises zu ca. 138Hz bestimmen. Die Capture-Range der PLL wird
ungefähr der doppelten Grenzfrequenz entsprechen (also ca. 276Hz).

## Schaltung

In `exp07-schematic`{.interpreted-text role="numref"} ist der Schaltplan
der PLL dargestellt. Ein Großteil der Schaltung ist allein dem VCO
zuzuordnen. Da dieser Teil bereits in `Experiment_06`{.interpreted-text
role="doc"} genauer erläutert wurde, wird hier nur auf den \"vorderen
Teil\" der Schaltung eingegangen.

> Vollständiger Schaltplan der PLL

Der Eingang der PLL wird direkt auf den Analogmultiplizierer geschaltet
(hier als idealer Multiplizierer dargestellt. Für den Schaltungsaufbau
wurde ein MPY634 eingesetzt). Der Schleifenfilter wird aus R1 und C1
gebildet. Die Offsetspannung $u_{bias}$ wird über den Widerstand R2
eingeprägt. Die Kombination aus R1 und R2 bewirkt zudem eine Skalierung
des Multiplizierer-Ausgangs.

## SPICE Simulation

Aufgrund der vorher durchgeführten systemtheorethischen Berechnungen
wurde die SPICE Simulation nur noch zur Validierung der grundlegenden
Funktion verwendet. In `exp07-spice`{.interpreted-text role="numref"}
ist ein Einschwingvorgang der PLL in der Simulation dargestellt. Es ist
zu erkennen, dass die VCO Spannung (Pink) zu Beginn leicht schwingt und
nach ca. 25ms konstant bleibt. Ab diesem Zeitpunkt stehen Eingangs- und
Ausgangssignal mit einer festen Phasenbeziehung zueinander.

> Einregelvorgang der PLL in SPICE Simuliert.

## Messungen

**VCO Kennlinie**

Zunächst wurde ausschließlich der VCO aufgebaut und dessen Kennlinie
aufgenommen (Siehe `exp07-vco-curve-real`{.interpreted-text
role="numref"}). Zwischen 2V und 6V verläuft die Kennlinie sehr linear.
Dieser Bereich sollte beim Betrieb der PLL nicht verlassen werden.

> Aufgenommene VCO Kennlinie

**PLL - einfacher test**

Anschließend wurde die komplette Schaltung nach
`exp07-schematic`{.interpreted-text role="numref"} aufgebaut. Mit einem
rechteckigen Referenzsignal mit $\pm 8\,\text{V}$ und einer Frequenz von
1kHz ergibt sich das in `exp07-timedomain`{.interpreted-text
role="numref"} dargestellte Ausgangssignal.

**Lock Range**

Um die Lock-Range der PLL zu testen, wurde in laufendem Betrieb die
Referenzfrequenz so lange nach oben bzw. nach unten verändert, bis der
Regelkreis der PLL keine konstante Phasenbeziehung mehr herstellen kann.
Die Capture-Range wurde ermittelt, indem die Frequenz ermittelt wurde,
bei der die PLL sich beim Einschalten des Referenzsignals
aufsynchronisieren kann. In `exp07-lock-range`{.interpreted-text
role="numref"} sind die Bereiche für zwei verschieden eingestellte
Offset-Spannungen dargestellt (um 1kHz und um 2kHz):

> Lock-Range (Hellblau) und Capture-Range (Dunkelblau) der PLL

**Jitter**

Als Jitter wird die zeitliche Streuung von Flanken eines Signals
bezüglich eines bestimmten Referenzpunktes bezeichnet. Cycle-Jitter
bezeichnet die maximale Streuung der Periodendauern des Ausgangssignals.
Absolute Jitter bezeichnet die maximale Abweichung der
Phasenverschiebung zwischen Eingangs- und Ausgangssignal. In
`exp07-jitter`{.interpreted-text role="numref"} sind diese Jitter-Arten
noch einmal illustriert:

> Exemplarische Darstellung von Cycle- ud Absolutem-Jitter

Der Cycle- und Absolute-Jitter der PLL wurde für drei verschiedene
Arbeitspunkte (Eingangsfrequenzen) ermittelt:

  $f_{ref}$   Cycle-Jitter       Absolute-Jitter
  ----------- ------------------ -------------------
  500 Hz      19,8 us (9,90 ‰)   24,30 us (12,0 ‰)
  1 kHz       3,60 us (3,60 ‰)   7,44 us (7,4 ‰)
  2 kHz       0,68 us (1,36 ‰)   3,70 us (3,7 ‰)

Es ist zu erkennen, dass der relative Jitter (ausgedrückt durch die
Promille-Werte) mit steigender Frequenz zunimmt.

**Phasenbeziehung**

Aufgrund der linearen VCO Kennlinie ist auch hier eine lineare
Abhängigkeit zu erwarten. In `exp07-phase-relation`{.interpreted-text
role="numref"} sind die Messwerte dargestellt:

> Phasenbeziehung zwischen Eingangs- und Ausgangssignal über die gesamte
> Lock-Range

Innerhalb der Lock-Range nimmt die Phasendifferenz Werte zwischen
ungefähr 70° bis 122° an. Der Arbeitsbereich des Phasenkomparators (45°
bis 180°) wird also nicht vollständig ausgenutzt.
