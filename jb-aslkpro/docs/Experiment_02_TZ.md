# Schmitt-Trigger

## Kurze Theorie und Motivation

In diesem Experiment werden verschiedene Schaltungen aufgebaut und durchgemessen und anschließend mit der Simulation
verglichen. Die einzelnen Versuche werden auf einem "Analog System Lab Kit PRO" von Texas Instruments aufgebaut und mit
einem "Stemlab Board 125-14" von Red Pitaya vermessen. Diese Messung erfolgt über die SCPI (Standard Commands for
Programmable Instruments) Schnittstelle des Red Pitaya, womit es möglich ist die Messungen über das Netzwerk
durchzuführen. Zum Anschprechen dieser Schnittstelle wird Python verwendet. Die Simulation wird mittels LTSpice von
Analog Devices durchgeführt.[^1]

Aufgabenpunkte aus dem `ASLK-Pro - Manual`[^2]:

1. Design und Aufbau einer rückgekoppelten Schaltung mit einer Hysterese von +-1V inklusive Aufnahme der
   Wechselspannungskennlinien

2. Variation der Rückkopplung um die Hysterese zu verändern.

3. Veränderung von $\beta$ durch Variieren von R1 und R2 an.

4. Design und Aufbau eines astabilen Multivibrators mit einer vorgegebenen Frequenz

5. Design und Aufbau einer monostabilen Kippstufe


## Messung am nicht-invertierenden Schmitt-Trigger

Als erster Versuch wird ein nicht-invertierender Schmitt-Trigger vermessen. Dieser besitzt sowohl einen Widerstand R1 am
positiven Eingang als auch einen Widerstand R2 als Rückkopplung. Der negative Eingang des Operationsverstärkers ist auf
Masse gezogen. 


```{figure} img/Experiment_02/Abbildung01.png 
:name: 02_fig_01

Nicht-invertierender Schmitt-Trigger und seine Hysterese[^2].
```

Die Widerstände R1 und R2 bilden einen Spannungsteiler zwischen der Ausgangsspannung des Operationsverstärkers U0 und
der Eingangsspannung UI. Der Mittelabgriff von diesem ist mit dem positiven Eingang des Operationsverstärkers
verbunden. Die Spannung an diesem Punkt ist somit abhängig von der Eingangsspannung und Ausgangsspannung der
Schaltung. Die Ausgangsspannung kann zwei unterschiedliche Werte annehmen und daher ergeben sich zwei unterschiedliche
Umschaltpunkte des Operationsverstärkers. Dieses Verhalten wird Hysterese genannt. Bei einem positiven Ausgang muss ein
negatives Eingangssignal anliegen, damit der Schmitt-Trigger ebenfalls auf eine negative Ausgangsspannung
umschaltet. Bei einem negativen Ausgang muss der Eingang positiv sein. Wie groß diese Differenz der beiden
Umschaltpunkte bzw. der Hysterese ist, wird durch die Widerstände und die Ausgangsspannungen bestimmt. Durch dieses
Verhalten hat ein nicht-invertierender Schmitt-Trigger auch sein eigenes Symbol mit der charakteristischen Hysterese:


```{figure} img/Experiment_02/Abbildung02.png 
:name: 02_fig_02

Symbol eines nicht-invertierenden Schmitt-Trigger[^1].
```

Die Breite der Hysteres lässt sich dabei berechnen mit der Versorgungsspannung $U_{DD}$ : 

$$
	U_{H} = 2 \cdot \beta \cdot U_{DD}
$$ (UH)

wobei $\beta$ berechnet wird mit:

$$
	\beta = \frac{R_1}{R_1 + R_2}
$$ (Beta)

Dies ist der Rückkopplungsfaktor der Schaltung. Die Hysterese ist dabei symmetrisch um den Nullpunkt. Die tatsächlichen
Umschaltpunkte für die Eingangsspannung entsprechen daher: 

$$
	U_{i1,i2} = \pm \frac{U_{H}}{2}
$$ (Ui12)

Für unseren Versuch wird der Widerstand $R_2$ fest auf 100 k$\Omega$ gehalten und der Eingangswiderstand $R_1$ wird mit
den Werten 470 $\Omega$, 1 k$\Omega$ und 2,2 k$\Omega$ dimensioniert. Für die Eingangsspannung wird ein Sinussignal mit
der Amplitude 1 V verwendet. Die Frequenz wird dabei zwischen 10 Hz und 10 kHz gewechselt, sodass sich insgesamt sechs
verschiedene Messungen ergeben. Es werden dabei die Eingangsspannung $U_I$ und die Ausgangsspannung $U_O$ gemessen.
Bei einem Schmitt-Trigger ist die Hysterese von besonderer Bedeutung und soll hier genauer untersucht werden. Hierfür
ist es notwendig die Ausgangsspannung über die Eingangsspannung darzustellen. Und es ergeben sich folgende Diagramme für
die Frequenz von 10 Hz:

```{figure} img/Experiment_02/Abbildung03.png 
:name: 02_fig_03

Hysterese des Schmitt-Trigger bei 10Hz[^1].
```

Bei der Simulation ist ein typischer Hystereseverlauf erkennbar. Es gibt keine Überschwinger an den Sprungstellen und es
ist eine sehr hohe Flankensteilheit vorhanden. Die Hysterese ist symmetrisch um den Ursprung und steigt mit zunehmendem
Widerstand $R_1$.

Bei der Messung ist die Hysterese mit Einschränkungen zu erkennen. Hier gibt es an den Übergangsstellen deutlich
sichtbare Überschwinger vom Operationsverstärker. Die Hysterese ist nicht um den Ursprung zentriert, sondern es ist ein
Verschiebung vorhanden. Auch eine Asymmetrie ist vorhanden, sodass die Hystere im negativen Bereich mit steigendem
Widerstand schneller steigt als im positiven Bereich. Eine besondere Auffälligkeit liegt bei der Messung mit 470
$\Omega$ vor, denn diese ist auffällig zur Seite geneigt und daher viel weniger Steil als die Simulation und die anderen
Messungen.

Es ist jedoch hierbei anzumerken, dass die Messungen mit 10-fach Tastköpfen durchgeführt wurden und diese zum Zeitpunkt
der Messung nicht abgeglichen wurden.

Bei einer Frequenz von 10 kHz ergibt sich ein ähnliches Bild:

```{figure} img/Experiment_02/Abbildung04.png 
:name: 02_fig_04

Hysterese des Schmitt-Trigger bei 10kHz[^1].
```


Auch hier ist in der Simulation eine nahezu ideale Hysterese zu erkennen. Durch die erhöhte Frequenz kann man erste
Abrundungen an den Übergängen erkennen. Die Messung ist hierbei stärker verrauscht, aber dafür sind keine Überschwinger
an den Übergangspunkten zu erkennen. Auch hier ist die Messung mit 470 $\Omega$ besonders, da hier erneut die Kennlinie
stärker nach rechts geneigt ist und teilweise die der 1000 $\Omega$ Kennlinie überschneidet.

Als nächstes lassen diese Werte sich mit den berechneten Werten für die Hysterese vergleichen. Hierzu werden die
unterschiedlichen Widerstandswerte in die Formel für die Berechnung von $\beta$ eingesetzt und anschließend kann mit
diesen die Hysteresebreite berechnet werden. Diese werden nun mit den Simulations- und Messergebnissen verglichen:


| **Widerstand $R_{1}$** | **Berechnung** | **Simulation** | **Messung** |
|:----------------------:|:--------------:|:--------------:|:-----------:|
|      470 $\Omega$      |     93 mV      |     83 mV      |    99 mV    |
|     1000 $\Omega$      |     198 mV     |     168 mV     |   205 mV    |
|     2200 $\Omega$      |     430 mV     |     366 mV     |   355 mV    |


Vergleich der Ergebnisse von $U_H$

Bei den Ergebnissen ist zu erkennen, dass alle Spannungen $U_H$ dem gleichen Trend folgen und mit steigendem Widerstand
$R_1$ steigen. Dennoch sind Unterschiede erkennbar, besonders hoch ist die Abweichung bei 2,2 k$\Omega$ zwischen der
Berechnung und der Messung. Eine Ursache hierfür könnte der Versatz der Messung sein, welche eine Asymmetrie erzeugt und
daher einen der Umschaltpunkte der Hysterese verschiebt. Jedoch zeigt auch hier die Simulation eine Abweichung von
ca. 64 mV zur Berechnung. Die Berechnung berücksichtigt keine Verhaltensweisen nicht idealer (also realer) Bauteile. Die
Simulation zeigt, dass trotz einer Versorgungsspannung von 10 V der Operationsverstärker nur bis 8,5 V am Ausgang
aussteuern kann und danach in der Sättigung ist. Dies zeigt, dass mit zunehmenden Widerstand diese Effekte eine größere
Rolle spielen. Es zeigt auch, dass die Simulation schon näher an der realen Messung ist als die Berechnung, aber dennoch
bestimmte Effekte nicht berücksichtigt werden, die das Messergebnis verändern.


## Astabile Kippstufe

In diesem Versuch wird eine astabile Kippstufe betrachtet. Hierbei wird im Vergleich zum Schmitt-Trigger ein weiterer
Widerstand als Gegenkopplung an den negativen Eingang des Operationsverstärkers eingefügt. Zusätzlich noch ein
Kondensator ebenfalls am negativen Eingang gegen Masse. Die Spannungsquelle der vorherigen Schaltung wird durch eine
Verbindung zur Masse ersetzt.

```{figure} img/Experiment_02/Abbildung05.png 
:name: 02_fig_05

Schaltung einer astabilen Kippstufe[^1].
```

Hieraus ergibt sich vom Ausgang des Operationsverstärkers ein Spannungsteiler zum positiven Eingang des
Operationsverstärkers mit den Widerständen $R_2$ und $R_3$. Es liegt somit am positiven Eingang immer ein Bruchteil der
Ausgangsspannung vom Operationsverstärker an. Der Kondensator wird bei einem positiven Ausgang über den Widerstand $R_1$
geladen bis die Spannung des negativen Eingangs $U_C$, die Spannung des Spannungsteilers (positiver Eingang)
übersteigt. Die Schaltung kippt und der Ausgang wird negativ. Der Kondensator entlädt sich bis die negative Spannung vom
Spannungsteiler unterschritten wird. Nun kippt die Schaltung erneut und beginnt von vorne. Die Schaltung kippt
automatisch zwischen den beiden Zuständen und erzeugt ein Rechtecksignal am Ausgang des Operationsverstärkers. Die
verwendeten Bauteile legen hierbei die Periodendauer fest. Die Periodendauer $T$ lässt sich berechnen mit:


$$
	T = 2 \cdot R_1 \cdot C \cdot \ln \left(  \frac{1 + \beta}{1 - \beta} \right)
$$ (T)

Wobei hier erneut $\beta$ durch $R_2$ und $R_3$ beschrieben wird.

Für diesen Versuch wurden alle Widerstände mit 1 k$\Omega$ dimensioniert und der Kondensator wurde auf 1µF
festgelegt. Anschließend folgte die Simulation der Schaltung mit LTSpice und die Messung wurde mit dem Red Pitaya
durchgeführt. Es entstanden dabei folgende Darstellungen:


```{figure} img/Experiment_02/Abbildung06.png 
:name: 02_fig_06

Simulation und Messung der astabilen Kippstufe[^1].
```

Sowohl in der Simulation und als auch in der Messung sind die Ergebnisse sehr ähnlich. Am Ausgang entsteht wie erwartet
ein Rechtecksignal $U_O$. Bei der Messungen sind die Dellen in den Rechtecken auf nicht abgeglichene Tastköpfe
zurückzuführen und daher zu vernachlässigen. Ebenfalls ist bei beiden Darstellungen deutlich die Auf- bzw. Entladekurve
des Kondensators $U_C$ zu erkennen. Bei der Simulation wurde eine Periodendauer $T$ von 2,2 ms gemessen und in der
Messung am Red Pitaya eine Dauer von 2,4 ms. Dies entspricht einer Frequenz $f$ von 454,54 Hz bzw. 416,67 Hz. Verglichen
mit den berechneten Werten  ergibt sich:


|                   | **Berechnung** | **Simulation** | **Messung** |
|:-----------------:|:--------------:|:--------------:|:-----------:|
| Periodendauer $T$ |    2,197 ms    |     2,2 ms     |   2,4 ms    |
|   Frequenz $f$    |   455,12 Hz    |   454,54 Hz    |  416,67 Hz  |


Vergleich der Ergebnisse von der astabilen Kippstufe

Die Periodendauer ist bei der Berechnung und der Simulation nahezu identisch. Nur eine sehr geringe Abweichung ist
erkennbar. Die Messergebnisse haben daher eine ähnliche Abweichung zu der Berechnung wie zur Simulation. Die Messung
zeigt somit, dass die Simulation und Berechnung in einem realen Aufbau umgesetzt werden können.



## Monostabile Kippstufe

Bei der Monostabilen Kippstufe wird zusätztlich zum Kondensator eine Diode parallel geschaltet. Außerdem wird ein
weiterer Kondensator an den positiven Eingang angeschlossen und dient als Trigger-Input für die Schaltung. Durch diese
zusätzliche Beschaltung hat die Schaltung nur einen stabilen Zustand indem sie ohne äußere Einflüsse bleibt. Wird ein
kurzer Impuls (oder Rechteck) auf den Trigger-Eingang gegeben, so kippt die Schaltung in den anderen Zustand (umgekehrte
Polarität am Ausgang). Dieser Zustand ist nicht stabil, daher kippt die Schaltung selbstständig nach einer Zeit $\tau$
wieder in ihren ursprünglichen Zustand vor dem Triggern zurück.


Die neu eingefügte Diode begrenzt dabei die Spannung bei einem positiven Ausgang des Operationsverstärkers, sodass der
Kondensator nie auf die Spannung aufgeladen werden kann, dass die Schaltung wie im vorherigen Versuch zurückkippen
kann. Erst wenn durch den Trigger die Schaltung am Eingang dazu gebracht wird, kippt die Schaltung zu einem negativen
Ausgang am Operationsverstärker. Der Trigger wird über einen Kondensator $C_2$, welcher mit $R_3$ einen Hochpass
(bzw. RC-Differenzierer) bildet, eingekoppelt. Dies hat zur Folge, dass von dem Trigger nur die steilen Flanken
übertragen werden. Der Kondensator am Ausgang wird jetzt entladen (bzw. negativ geladen) bis die Spannung des
Kondensators $U_C$ die Spannung über dem Spannungsteiler $R_2$ und $R_3$ entspricht. Nun kippt die Schaltung zurück und
der Kondensator wird erneut aufgeladen. Die Diode begrenzt wieder die Ladespannung und die Schaltung ist in einem
stabilen Zustand. Es kann die Schaltung erneut getriggert werden.

Aufgrund der äußeren Beschaltung reagiert die monostabile Kippstufe auf eine negative Flanke am nicht-invertierenden
Eingang und ändert dann den Zustand. Die Zeit, in der die monostabile Kippstufe in dem instabilen Zustand ist, berechnet
sich nach der folgenden Formel:


$$
	\tau =R C \cdot \ln \left(\frac{1}{1-\beta}\right)
$$ (monotau)

$\beta$ ist hierbei nach der Formel


$$
	\beta = \frac{R_3}{R_1 + R_3}
$$ (Beta2)



zu berechnen. Die Widerstandswerte sind dabei R$_1$ = 20k$\Omega$, R$_2$= 10k$\Omega$ und R$_3$ = 2,2k$\Omega$. Sobald
die monostabile Kippstufe den instabilen Zustand erreicht, beginnt der Ausgangskondensator sich zu entladen. Wird der
stabile Zustand wieder erreicht, so vergeht eine kurze Zeit, bis der Kondensator wieder aufgeladen ist. Erst dann ist es
wieder möglich, ein nächstes Triggersignal zu setzen. Diese Zeit wird mithilfe der folgenden Formel berechnet:


$$
	\tau^{\prime} = R C \cdot \ln \left(\frac{1+\beta}{\beta}\right)
$$ (monotaus)

Die Kondensatorwerte betragen C$_1$ = C$_2$ = 1$\mu$F. Die Messungen und die Simulationen wurden durchgeführt, wobei
folgende Ergebnisse entstanden:


```{figure} img/Experiment_02/Abbildung07.png 
:name: 02_fig_07

Simulation und Messung der monostabilen Kippstufe[^1].
```

Das Triggersignal hat hierbei eine Frequenz von 25 Hz und eine Tastverhältnis von 10%. Es ist zu erkennen, dass die
monostabile Kippstufe in den instabilen Zustand wechselt, sobald bei dem Triggersignal eine negative Flanke
anliegt. Zeitgleich entlädt sich der Kondensator am Ausgang. Ist nach der Zeit $\tau$ der stabile Zustand wieder
erreicht, so beginnt der Ausgangskondensator, sich erneut aufzuladen. Anhand der obigen Formeln lassen sich die Werte
für $\tau$ und $\tau'$ berechnen. In dieser Tabelle werden die berechneten, simulierten und gemessenen Werte gezeigt:



|                       | **Berechnung** | **Simulation** | **Messung** |
|:---------------------:|:--------------:|:--------------:|:-----------:|
| instabile Zeit $\tau$ |    3,98 ms     |    5,25 ms     |   5,91 ms   |
|        $\tau'$        |    37,58 ms    |    10,25 ms    |  10,51 ms   |


Vergleich der Ergebnisse von der monostabilen Kippstufe

Es ist auffällig, dass die gemessenen und die berechneten Werte sehr nahe beieinander liegen, die berechneten Werte
jedoch stark davon abweichen.

[^1]: ANS-Abschlussbericht SoSe21 von J. Rose und J. Armbrüster

[^2]: Analog System Lab Kit PRO MANUAL von 2012 - Authors: K.R.K. Rao and C.P. Ravikumar 
