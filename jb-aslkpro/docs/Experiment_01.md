# Gegenkopplungsverstärker und Instrumentenverstärker

In diesem Experiment sollen drei Grundschaltungen eines Operationsverstärkers untersucht werden.
Zu diesen gehören ein:

- Impedanzwandler/Spannungsfolger

- invertierender Verstärker

- nicht-invertierender Verstärker.


Grundsätzlich werden beim Schaltungsentwurf mit Operationsverstärkern (Opamps) die Eingengschaften für Handrechnungen
indealisiert. Das heißt, dass Opamps einen unendlich hohen Verstärkungfaktor und Eingangswiderstand aufweisen, sowie
eine unendlich große Bandbreite. Der Ausgangswiderstand wird mit $0\,\Omega$ angenommen. Geht man in die Praxis über,
stellt man sehr schnell fest, dass alle genannten Werte endlich sind und beim Schaltungsentwurf unterschiedliche
Probleme verursachen können. Das Ziel dieses Experiments ist eine messtechnische Untersuchung der Grundschaltungen eines
Opamps und ein Gewinn an Wissen und Erfahrung beim Umgang mit diesen elektronischen Bauelementen. 


## Unity Gain - Schaltung

Eine Unity Gain-Schaltung, auch Impedanzwandler oder Spannungsfolger genannt, ist ein Operationsverstärker, dessen
Ausgang mit dem invertierenden Eingang kurzgeschlossen ist {ref}`01_fig_02`.


```{figure} img/Experiment_01/Experiment_01_fig_02.png 
:name: 01_fig_02

Schematische Darstellung einer UnityGain-Schaltung.
```

Aus der Theorie wissen wir, dass der Ausgang eines unbeschalteten Opamps gleich dem Verstärkungsfaktor $A_0$ multipliziert mit der
Differenz der beiden Eingänge $U_+$ und $U_-$ ist. Dabei ist $U_+$ der nicht-invertierende und $U_-$ der invertierende Eingang des
Operationsverstärkers. Damit ergibt sich allgemein für den unbeschalteten Operationsverstärker:

$$
U_{OUT} = A_0 \cdot (U_+ - U_-)
$$

Aufgrund der *Rückkopplung* kann der Unity Gain Verstärker als eine Regelstrecke betrachtet werden. Systemtheoretisch
ist nun das Verhältnis von Ausgang zu Eingang eine Übertragungsfunktion $H(s)$ {ref}`01_eq_02`.

$$
\frac{U_{OUT}}{U_{IN}} = \frac{A_0}{1+A_0}
$$

Aufrund der direkten Rückkopplung (ohne andere Bauteile, Kurzschluss) kann idealisiert angenommen werden, dass $A_0$
gegen Unendlich strebt. Durch diese Annahme folgt nach dem Kürzen der {ref}`01_eq_02` das
Übersetzungverhältnis für eine Unity Gain-Schaltung:

$$
\frac{U_{OUT}}{U_{IN}} = 1
$$

Mit dieser Erkenntnis kann man nun den Nutzen des Unity Gain in Frage stellen. Tatsächlich ist es eine sehr nützliche
Schaltung eines Operationsverstärkers. Wie bereits erwähnt, wird diese Schaltung auch Spannungsfolger oder
Impedanzwandler genannt. Die Namen werden aus der grundlegenden Funktion dieser Schaltung abgeleitet. **Ein Unity Gain
liefert am Ausgang die vom Eingang vorgegebene Spannung. Diese ist lastunabhängig.** Durch diese Eigenschaft kann der
Unity Gain als Spannungsstabilisator oder als Entkoppler zweier Teilsystemen eingesetzt werden. Nach
{ref}`01_eq_03` ist die Übertragungsfunktion des Unity Gain gleich 1. Das heißt, dass die
Ausgangsspannung gleich der Differenz der Eingangsspannungen $U_+$ und $U_-$ ist. Die Simulations- und Messergebnisse
sind in der `01_fig_03`{.interpreted-text role="numref"} (oben) dargestellt. Daraus ist ersichtlich, dass sich die
beiden Signale überlagern, was einer Übertragung von 1 entspricht.


```{figure} img/Experiment_01/Amplifier_output.png
:name: 01_fig_03

Simulationen und Messungen der Ein- und Ausgangsspannungen der 3 grundlegenden Beschaltungsarten eines
Oparationsverstärkers \[Unity Gain (oben), nicht-invertierender Verstärker (mitte), invertierender Verstärker (unten)\]
```

## Nicht-invertierende und invertierende Operationsverstärkerschaltungen

Zwei weitere grundlegende Schaltungen des Operationsverstärkers sind die sogenannten nicht-invertierenden und
invertierenden Schaltung.

```{figure} img/Experiment_01/Experiment_01_fig_03.png
:name: 01_fig_04

Nicht-invertierender (li.) und invertierender (re.) Verstärker
```

Sowohl beim nicht-invertierenden als auch beim invertierenden Verstärker hängt der Verstärkungsfaktor $A_0$ vom
Verhältnis der beiden Widerstände ab. Für den nicht-invertieren Verstärker ergibt sich:

$$
\frac{U_{OUT}}{U_{IN}} = 1 + \frac{R_2}{R_1}
$$


Nach Ausmultiplizieren egibt sich für die Ausgangsspannung $U_{OUT}$ 

$$
U_{OUT} = U_{IN} + \frac{R_2}{R_1} \cdot U_{IN}
$$

Dabei ist $R_1$ der Widerstand, der am invertierenden Eingang $U_-$ anliegt und $R_2$ der zwischen dem Ausgang $U_{OUT}$ und dem
invertierenden Eingang liegt {ref}`01_fig_04`. $U_{IN}$ ist die Eingangsspannung, die an einem der Eingänge des Opamps anliegt.

Aus der {ref}`01_fig_03` ist ersichtlicht, dass bei einem nicht-invertierenden Verstärker die Eingangsspannung nach 
{ref}`01_eq_05` verstärkt wird. Die Ausgangsspannung liegt mit der Eingangsspannung in Phase.

Für den invertierenden Verstärker ist das Verhältnis von Ausgangsspannung zu Eingangsspannung gegeben als

$$
\frac{U_{OUT}}{U_{IN}} = -\frac{R_2}{R_1}
$$

Nach Ausmultiplizieren ergibt sich für die Ausgangsspannung $U_{OUT}$:

$$
U_{OUT} = -\frac{R_2}{R_1} \cdot U_{IN}
$$

Nach {ref}`01_eq_07` bekommt man eine um $\pi$ gedrehete und um das Widerstandsverhältnis verstärkte Ausgangsspannung
$U_{OUT}$. Diese ist in {ref}`01_fig_03` (unten) graphisch dargestellt.


### Messtechnische Untersuchung der Grenzbereiche

Wie oben beschrieben unterliegt ein Operationsverstärker physikalischen Grenzen. Diese Grenzen sollen hier untersucht werden.


### Bandbreite

Zunächst soll die Bandbreite und ihre Abhängigkeit von der Verstärkung untersucht werden. Die kann z.B. mit Hilfe von
Red Pitaya und der sich darauf befindenden App *Bode-Analyser* durchgeführt werden. Aufgrund von unzureichender
Datenexportmöglichkeiten, wurde an dieser Stelle ein Programm zur Bode-Plot-Darstellung entwickelt. Gundsätzlich wird
das Programm zur Messautomatisierung des Red Pitayas eingesetzt und ist ohne Weiteres nur mit diesem kompatibel:

```{literalinclude} ../skripte/01_Amplitudengangmessung.py
:language: python
```

Mit Hilfe des Programms konnten die Bandbreiten der jeweiligen Schaltung ermittelt werden. Um eine fundierte Aussage
über die Messgenauigkeit treffen zu können, wurden die Amplitudengänge der entsprechenden Schaltungen simuliert. Diese
sind zusammen mit den Messungen in `01_fig_06`{.interpreted-text role="numref"} dargestellt.

```{figure} img/Experiment_01/amplitudengang_messung_simulation.png
:name: 01_fig_06

Vergleich der Messungen mit den Simulationen
```

Die Simulationsergebnisse zeigen prinzipiell das gleiche Tiefpassverhalten wie die Messergebnisse. Der Amplitudengang
der Messungen weicht kaum von den Simulationsergebnissen ab. Die Abweichungen liegen nur im hohen Frequenzbereich. Daher
liegen die Fehlerquellen in den kapazitiven Eigenschaften der Messspitzen und den langen Leitung. Andererseits scheinen
die Simulationsdaten des Operationsverstärkers sehr exakt zu sein, das die beiden Ergebnisse kaum von einander abweichen.

Mit Hilfe von [Matlab](https://de.mathworks.com/products/matlab.html) können die $-3\,dB$ - Grenzen der jeweiligen
gemessenen Schaltungen ermittelt werden. Es ergeben sich für:

-   UnityGain = $3,16 \cdot 10^6\,Hz$

-   Nichtinvertierender Verstärker = $1,05 \cdot 10^6\,Hz$

-   Invertierender verstärker = $1,05 \cdot 10^6\,Hz$


Diese Information liefert eine wichtige Erkenntnis: Die Bandbreite der Operationsverstärker hängt scheinbar mit dem
Verstärkungsfaktor $A_0$ zusammen. Je größer der Verstärkungsfaktor, desto schmaler ist die Bandbreite des Opamps. Diese
Erkenntniss ist wichtig für die Auslegung hochfrequenter Schaltung mit einer Verstärkung. Auf eine mathematische
Herleitung der Bandbreite wird an dieser Stelle verzichtet. 


### Maximale Verstärkung

Nun soll der Verstärkungsfakor $A_0$ auf seinen maximalen und minimalen Wert untersucht werden. Abgeleitet aus
`01_eq_05`{.interpreted-text role="eq"} und `01_eq_06`{.interpreted-text role="eq"}, besteht die Abhängigkeit zwischen
dem Verstärkungsfaktor $A_0$, der Eigangsspannungdifferenz $U_{IN}$ und der Ausgangsspannung $U_{OUT}$.

$$
U_{OUT} = A_0 \cdot U_{IN}
$$


Da theoretisch die Eigangsspannung und der Verstärkungsfaktor variable sind, wird hier die Ausgangsspannung des Opamps
auf ihre Grenzen überprüft. Dazu wird ein DC-Sweep durchgeführt. Zu diesem Zweck wurde ein weiteres Programm erstellt

```{literalinclude} ../skripte/03_DCsweep.py
:language: python
```

Es soll mit Hilfe des nicht-invertierenden Verstärkers ein Gleichspannungsdurchlauf durchgeführt werden. Für die
Ausgangsspannung ergibt sich ein Spannungsverlauf nach `01_fig_07`{.interpreted-textrole="numref"}.

```{figure} img/Experiment_01/DCsweep.png
:name: 01_fig_07

Grenzmessung der Ausgangsspannung
```


Das Ergebnis zeigt, dass die Ausgangsspannung bei ca. $9\,V$ ihr Maximum und bei ca. $-9\,V$ ihr Minimum
aufweist. Hier wird der Zusammenhang zwischen der Ausgangsspannung und der Versorgungsspannung des Operationsverstärkers
deutlich. Die Maximalwerte der Ausgangsspannung sind gleich der Versorgungsspannung[^1]. Die Flankensteilheit ist
abhängig vom Verstärkungsfaktor.


### Fazit und Beispiele

Mit Hilfe der durchgeführten Messungen konnten die grundlegende Funktionen und die realen Grenzen eines
Operationsverstärkers aufgezeigt werden. Der Einsatz des Red Pitaya Messlabors erwies sich für hohen Frequenzbereich
eher unzuverlässig. Des Weiteren verdrehte der Red Pitaya je nach Päriodenauflösung die Phase, sodass der Datenexport
oft fehlerhaft war. Trotzdessen ist die Möglichkeit der Messautomatisierung von großem Vorteil. Daher bietet sich der
Eisatz von SCPI-fähigen Geräten bei diesen Messungen an. 

Als erstes Beispiel wird ein negativ rückgekoppelter Verstärker betrachtet. Prinzipiell ist das eine Kaskadierung
(Hintereinanderschaltung) der drei Grundschaltungen `01_fig_08`{.interpreted-text role="numref"}. 

```{figure} img/Experiment_01/negative_feedback.png
:name: 01_fig_08

Negativ-rückgekoppelter Verstärker
```

Hier wird statt eines Sinussignals ein Rechtecksignal eingespeist. Die Ausgänge der Schaltung sind in {ref}`01_fig_09`
graphisch dargestellt.

```{figure} img/Experiment_01/Verstaerker_Rueckkopplung_neu.png
:name: 01_fig_09

Messergebnisse der Ausgangsspannungen des negativ-rückgekoppelten Verstärkers
```

Aus der Messung ist zu entnehmen, dass die bei einem Rechteckeingangssignal, die Ausgangssignale bei den Grenzübergängen
eine Abrundung aufweisen. Dieses Phänomen bezeichnet man als [Slew Rate](https://en.wikipedia.org/wiki/Slew_rate) und
ist auf die kapazitive Eigeschaften des OPAMS zurück zu führen.

Als zweites Beispiel wird ein Instrumentenverstärker betrachtet. Dieser kann aus zwei oder drei Operationsverstärkern 
vgl. {ref}`01_fig_10`, aufgebaut werden und wird oft, aufgrund seiner Eigenschaften, in der Medizintechnik eingesetzt. 


```{figure} img/Experiment_01/Instrumentenverstaerker.png
:name: 01_fig_10

Instrumentenverstärker mit drei Opamps (li.) und zwei Opamps (re.)
```

Aus der Abbildung wird deutlich, dass die Verstärkung lediglich vom Widerstand $nR$ abhängt. Dies erleichtert die
Einstellung des Instumentenverstärkers. Als Beispiel wurde ein Instrumentenverstärker aus zwei Operationsverstärkern
aufgebaut und der Ausgang gemessen. Die Messergebnisse sind in der `01_fig_11`{.interpreted-text role="numref"}
graphisch dargestellt. 

```{figure} img/Experiment_01/Instrumenten.png
:name: 01_fig_11

Eingangs- und Ausgangssignale eines Instrumentenverstärkers aus 2 Opamps
```

Aufgrund der Darstellung kann festgestellt werden, dass hier die Differenz der Eingangsspannungen verstärkt wird. Dies
bezieht sich nun auf zwei Eingangssignale gegeneinander und nicht ein Signal gegen die Masse.

[^1]: Die Angaben sind aus den jeweiligen Datenblättern zu entnehmen
