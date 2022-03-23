# Grundschaltungen des OPV

## Einleitung
In diesem Experiment sollen drei Grundschaltungen eines Operationsverstärkers untersucht werden. Zu diesen gehören: 

- Impedanzwandler / Spannungsfolger

- Nicht-invertierender Verstärker

- Invertierender Verstärker

Grundsätzlich werden beim Schaltungsentwurf mit Operationsverstärkern (häufig auch bezeichnet als OP, OV, OPV oder auch
OpAmp, wobei Letzteres die Abkürzung für die englische Bezeichnung Operational Amplifier ist [^1]) die Eingengschaften
idealisiert betrachtet. 

Ein idealer Operationsverstärker hat einen unendlich großen Verstärkungsfaktor V, einen unendlich großen
Eingangswiderstand Re, einen Ausgangswiderstand Ra gleich Null und einen Frequenzbereich von Null bis
unendlich. Außerdem ist der ideale Operationsverstärker vollkommen symmetrisch. Gleiche Spannungen an den beiden
Eingängen ergeben einen Ausgangsspannung Ua von Null. Der Grund ist die Differenz UPN zwischen den Eingangsspannungen,
die Null ist. Vorausgesetzt die Amplitude und Phasenlage sind gleich. Man spricht dann von Gleichtaktaussteuerung. Die
Verstärkung heißt dann Gleichtaktverstärkung. Sie ist gleich Null. 

Das Verhältnis zwischen dem Verstärkungsfaktor V und der Gleichtaktverstärkung wird Gleichtaktunterdrückung genannt. Sie
ist unendlich groß. Verzerrungen oder Rauschen, sowie die Abhängigkeit von der Umgebungstemperatur gibt es beim idealen
Operationsverstärker nicht. Und zwischen Eingangs- und Ausgangsspannung besteht ein linearer Zusammenhang [^1].


Geht man in die Praxis über, stellt man sehr schnell fest, dass alle soeben aufgeführten Werte endlich sind und beim
Schaltungsentwurf unterschiedliche Probleme verursachen können. Das Ziel dieses Experiments ist eine messtechnische
Untersuchung der Grundschaltungen eines Opamps und ein Gewinn an Wissen und Erfahrung beim Umgang mit diesen
elektronischen Bauelementen.

## Notwendige Werkzeuge
Für das Durchführen des Experiments ist es sinnvoll, sich einiger Werkzeuge zu bedienen. Diesbezüglich ein paar Sätze zu
den zu nutzenden Werkzeugen. Vor der eigentlichen Messung ist es ratsam, die Schaltung mit einem Programm zu
simulieren. Dadurch wird einem klar, welcher Verlauf beim Messen zu erwarten ist. Das Programm LTspice ist eine
leistungsfähige Software zur Simulation elektronischer Schaltungen. Die Messung wird anschließend mit einem RedPitaya
durchgeführt. Hierbei handelt es sich um einen kleinen Microcomputer, mit dem es möglich ist, eine Messautomatisierung
durchzuführen.

Durch z.B. ein Python-Script, welches mittels SCPI-Protokoll von einem entfernten System an den Red Ptaya übertragen
wird, kann eine Fernmessung durchgeführt werden. Die Messdaten, die ermittelt werden, können danach z.B. in einer
CSV-Datei gesammelt werden [^2].

## Unity Gain - Schaltung

Eine Unity Gain-Schaltung, auch Impedanzwandler oder Spannungsfolger genannt, ist ein Operationsverstärker, dessen
Ausgang mit dem invertierenden Eingang kurzgeschlossen ist {numref}`01_fig_02`. 


```{figure} img/Experiment_01/Abbildung01.png 
:name: 01_fig_01

Schematische Darstellung einer UnityGain-Schaltung.
```

Aufgrund der erwähnten *Rückkopplung* kann die Unity Gain - Schaltung als eine Regelstrecke betrachtet
werden. Systemtheoretisch ist nun das Verhältnis von Ausgang zu Eingang eine Übertragungsfunktion H(s).

$$
	U_{OUT} = A_0 \cdot (U_+ - U_-)
$$ (01_eq_01)

Aufrund der direkten Rückkopplung (ohne andere Bauteile, Kurzschluss) kann idealisiert angenommen werden, dass
$A_0$ gegen Unendlich strebt. Durch diese Annahme folgt nach dem Kürzen der das Übersetzungverhältnis für eine
Unity Gain-Schaltung:

$$
	\frac{U_{OUT}}{U_{IN}} = \frac{A_0}{1+A_0}
$$ (01_eq_02)


Mit dieser Erkenntnis könnte man nun den Nutzen der Unity Gain - Schaltung in Frage stellen. Tatsächlich ist sie aber
eine sehr nützliche Schaltung eines Operationsverstärkers. Wie bereits erwähnt, wird diese Schaltung auch
Spannungsfolger oder Impedanzwandler genannt. Die Namen werden aus der grundlegenden Funktion dieser Schaltung
abgeleitet. **Eine Unity Gain - Schaltung liefert am Ausgang die vom Eingang vorgegebene Spannung. Diese ist
lastunabhängig.** Durch diese Eigenschaft kann der Unity Gain als Spannungsstabilisator oder als Entkoppler zweier
Teilsysteme eingesetzt werden. Die Übertragungsfunktion des Unity Gain ist 1. Das heißt, dass die Ausgangsspannung
gleich der Differenz der Eingangsspannungen $U_{+}$ und $U_{-}$ ist.

$$
	\frac{U_{OUT}}{U_{IN}} = 1
$$ (01_eq_03)


```{figure} img/Experiment_01/Abbildung02.svg
:name: 01_fig_02

Messung und Simulation der Ein- und Ausgangsspannungen der Unity Gain - Schaltung* [^2]
```

Die Mess- und Simulationsergebnisse sind in {numref}`01_fig_02` dargestellt. Daraus ist ersichtlich, dass die beiden
Signale nahezu identisch sind, was einer Übertragung von 1 entspricht.


## Nicht-invertierender und invertierender Verstärker

Zwei weitere grundlegende Schaltungen des Operationsverstärkers sind die sogenannten nicht-invertierenden und
invertierenden Schaltung.

```{figure} img/Experiment_01/Abbildung03.png
:name: 01_fig_03

Nicht-invertierender Verstärker[^2]
```

Sowohl beim nicht-invertierenden als auch beim invertierenden Verstärker hängt der Verstärkungsfaktor $A_0$ vom
Verhältnis der beiden Widerstände ab. Für den nicht-invertieren Verstärker ergibt sich:

$$
	\frac{U_{OUT}}{U_{IN}} = 1 + \frac{R_2}{R_1}
$$ (01_eq_04)


Nach Ausmultiplizieren egibt sich für die Ausgangsspannung $U_{OUT}$ 

$$
	U_{OUT} = U_{IN} + \frac{R_2}{R_1} \cdot U_{IN}
$$ (01_eq_05)

Dabei ist $R_1$ der Widerstand, der am invertierenden Eingang $U_-$ anliegt und $R_2$ der zwischen dem Ausgang $U_{OUT}$
und dem invertierenden Eingang liegt {numref}`01_fig_04`. $U_{IN}$ ist die Eingangsspannung, die an einem der Eingänge des
Opamps anliegt.

```{figure} img/Experiment_01/Abbildung04.svg
:name: 01_fig_04

Messung und Simulation der Ein- und Ausgangsspannungen des Nicht-invertierenden Verstärkers[^2]
```

Aus {numref}`01_fig_04` ist ersichtlicht, dass bei einem nicht-invertierenden Verstärker die Eingangsspannung verstärkt
wird. Die Ausgangsspannung liegt mit der Eingangsspannung in Phase.


```{figure} img/Experiment_01/Abbildung05.png
:name: 01_fig_05

Invertierender Verstärker[^2]
```

Für den invertierenden Verstärker ist das Verhältnis von Ausgangsspannung zu Eingangsspannung gegeben als

$$
	\frac{U_{OUT}}{U_{IN}} = -\frac{R_2}{R_1}.
$$ (01_eq_06)

Nach Ausmultiplizieren ergibt sich für die Ausgangsspannung $U_{OUT}$

$$
	U_{OUT} = -\frac{R_2}{R_1} \cdot U_{IN}.
$$ (01_eq_07)

Nach {eq}`01_eq_07` bekommt man eine um $\pi$ gedrehte und um das Widerstandsverhältnis verstärkte Ausgangsspannung
$U_{OUT}$. Diese ist in {numref}`01_fig_06` graphisch dargestellt.

```{figure} img/Experiment_01/Abbildung06.svg
:name: 01_fig_06

Invertierender Verstärker[^2]
```


### Messtechnische Untersuchung der Grenzbereiche

Wie oben beschrieben unterliegt ein Operationsverstärker physikalischen Grenzen. Diese Grenzen sollen hier untersucht
werden.


### Bandbreite

Zunächst soll die Bandbreite und ihre Abhängigkeit von der Verstärkung untersucht werden. Die kann z.B. mit Hilfe von
Red Pitaya und der sich darauf befindenden App *Bode-Analyser* durchgeführt werden. Aufgrund von unzureichender
Datenexportmöglichkeiten, wurde an dieser Stelle ein Programm zur Bode-Plot-Darstellung entwickelt. Gundsätzlich wird
das Programm zur Messautomatisierung des Red Pitayas eingesetzt und ist ohne Weiteres nur mit diesem kompatibel:

```{literalinclude} ../../files/meas/Experiment_01/01_Amplitudengangmessung.py
:language: python
```

Mit Hilfe des Programms konnten die Bandbreiten der jeweiligen Schaltung ermittelt werden. Um eine fundierte Aussage
über die Messgenauigkeit treffen zu können, wurden die Amplitudengänge der entsprechenden Schaltungen simuliert. Diese
sind zusammen mit den Messungen in `01_fig_06`{.interpreted-text role="numref"} dargestellt.

```{figure} img/Experiment_01/Abbildung07.png
:name: 01_fig_07

Vergleich der Messungen mit den Simulationen
```

Die Simulationsergebnisse zeigen prinzipiell das gleiche Tiefpassverhalten wie die Messergebnisse. Der Amplitudengang
der Messungen weicht kaum von den Simulationsergebnissen ab. Die Abweichungen liegen nur im hohen Frequenzbereich. Daher
liegen die Fehlerquellen in den kapazitiven Eigenschaften der Messspitzen und den langen Leitung. Andererseits scheinen
die Simulationsdaten des Operationsverstärkers sehr exakt zu sein, das die beiden Ergebnisse kaum von einander abweichen.

Mit Hilfe von [Matlab](https://de.mathworks.com/products/matlab.html) können die $-3\,dB$ - Grenzen der jeweiligen
gemessenen Schaltungen ermittelt werden. Es ergeben sich für:

- Unity Gain = $3,16 \cdot 10^6\,Hz$

- Nicht-invertierender Verstärker = $1,05 \cdot 10^6\,Hz$

- Invertierender Verstärker = $1,05 \cdot 10^6\,Hz$


Diese Information liefert eine wichtige Erkenntnis: Die Bandbreite der Operationsverstärker hängt scheinbar mit dem
Verstärkungsfaktor $A_0$ zusammen. Je größer der Verstärkungsfaktor, desto schmaler ist die Bandbreite des Opamps. Diese
Erkenntniss ist wichtig für die Auslegung hochfrequenter Schaltung mit einer Verstärkung. Auf eine mathematische
Herleitung der Bandbreite wird an dieser Stelle verzichtet. 


### Maximale Verstärkung

Nun soll der Verstärkungsfakor $A_0$ auf seinen maximalen und minimalen Wert untersucht werden. Abgeleitet aus
{eq}`01_eq_05` und {eq}`01_eq_06`, besteht die Abhängigkeit zwischen dem Verstärkungsfaktor $A_0$, der
Eigangsspannungdifferenz $U_{IN}$ und der Ausgangsspannung $U_{OUT}$.

```{math}
:label: 01_eq_08
U_{OUT} = A_0 \cdot U_{IN}
```


Da theoretisch die Eigangsspannung und der Verstärkungsfaktor variable sind, wird hier die Ausgangsspannung des Opamps
auf ihre Grenzen überprüft. Dazu wird ein DC-Sweep durchgeführt. Zu diesem Zweck wurde ein weiteres Programm erstellt

```{literalinclude} ../../files/meas/Experiment_01/03_DCsweep.py
:language: python
```

Es soll mit Hilfe des nicht-invertierenden Verstärkers ein Gleichspannungsdurchlauf durchgeführt werden. Für die
Ausgangsspannung ergibt sich ein Spannungsverlauf nach {numref}`01_fig_07`.

```{figure} img/Experiment_01/Abbildung08.png
:name: 01_fig_08

Grenzmessung der Ausgangsspannung
```


Das Ergebnis zeigt, dass die Ausgangsspannung bei ca. $9\,V$ ihr Maximum und bei ca. $-9\,V$ ihr Minimum
aufweist. Hier wird der Zusammenhang zwischen der Ausgangsspannung und der Versorgungsspannung des Operationsverstärkers
deutlich. Die Maximalwerte der Ausgangsspannung sind gleich der Versorgungsspannung [^3]. Die Flankensteilheit ist
abhängig vom Verstärkungsfaktor.


### Fazit und Beispiele

Mit Hilfe der durchgeführten Messungen konnten die grundlegende Funktionen und die realen Grenzen eines
Operationsverstärkers aufgezeigt werden. Der Einsatz des Red Pitaya Messlabors erwies sich für hohen Frequenzbereich
eher unzuverlässig. Des Weiteren verdrehte der Red Pitaya je nach Päriodenauflösung die Phase, sodass der Datenexport
oft fehlerhaft war. Trotzdessen ist die Möglichkeit der Messautomatisierung von großem Vorteil. Daher bietet sich der
Eisatz von SCPI-fähigen Geräten bei diesen Messungen an. 

Als erstes Beispiel wird ein negativ rückgekoppelter Verstärker betrachtet. Prinzipiell ist das eine Kaskadierung
(Hintereinanderschaltung) der drei Grundschaltungen {numref}`01_fig_08`. 

```{figure} img/Experiment_01/Abbildung09.png
:name: 01_fig_09

Negativ-rückgekoppelter Verstärker
```

Hier wird statt eines Sinussignals ein Rechtecksignal eingespeist. Die Ausgänge der Schaltung sind in {numref}`01_fig_09`
graphisch dargestellt.

```{figure} img/Experiment_01/Abbildung10.png
:name: 01_fig_10

Messergebnisse der Ausgangsspannungen des negativ-rückgekoppelten Verstärkers
```

Aus der Messung ist zu entnehmen, dass die bei einem Rechteckeingangssignal, die Ausgangssignale bei den Grenzübergängen
eine Abrundung aufweisen. Dieses Phänomen bezeichnet man als [Slew Rate](https://en.wikipedia.org/wiki/Slew_rate) und
ist auf die kapazitive Eigeschaften des OPAMS zurück zu führen.

Als zweites Beispiel wird ein Instrumentenverstärker betrachtet. Dieser kann aus zwei oder drei Operationsverstärkern 
vgl. {numref}`01_fig_10`, aufgebaut werden und wird oft, aufgrund seiner Eigenschaften, in der Medizintechnik eingesetzt. 


```{figure} img/Experiment_01/Abbildung11.png
:name: 01_fig_11

Instrumentenverstärker mit drei Opamps (li.) und zwei Opamps (re.)
```

Aus der Abbildung wird deutlich, dass die Verstärkung lediglich vom Widerstand $nR$ abhängt. Dies erleichtert die
Einstellung des Instumentenverstärkers. Als Beispiel wurde ein Instrumentenverstärker aus zwei Operationsverstärkern
aufgebaut und der Ausgang gemessen. Die Messergebnisse sind in der {numref}`01_fig_11` graphisch dargestellt. 

```{figure} img/Experiment_01/Abbildung12.png
:name: 01_fig_12

Eingangs- und Ausgangssignale eines Instrumentenverstärkers aus 2 Opamps
```

[^1]: https://www.elektronik-kompendium.de/sites/bau/0209092.htm - besucht am 21.03.2022
[^2]: ANS-Abschlussbericht SoSe21 von M. Lüters, L. Lagona und Ch. Stelling.
[^3]: Die Angaben sind aus den jeweiligen Datenblättern zu entnehmen.
