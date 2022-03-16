# Regenerative rückgekoppelte Systeme: Design astabiler und monostabiler Kippstufen


## Kurze Theorie und Motivation

Als Grundlage regenerativer rückgekoppelter Systeme gilt ein sogenanntes
Schmitt-Trigger System. Bei diesen Systemen fallen die Ein- und
Ausschaltschwellen nicht zusammen, sondern sind um eine Schalthysterese
gegeneinander versetzt. Dadurch kann der Ausgang $V_{OUT}$ nur zwei
Zustände annehmen. Durch diese Eigenschaften kann der Schmitt-Trigger zu
einer Mixed-Mode Schaltung zugeordnet werden. Der Einsatzgebiet dieser
Schaltung ist vielfältig (MOSFET-Treiber als Switch-Controller etc.).

## Messungen Schmitt-Trigger

Zunächst soll ein nicht-invertierender `02_fig_01`{.interpreted-text
role="numref"} und ein invertierender Schmitt-Trigger
`02_fig_02`{.interpreted-text role="numref"} betrachtet werden.

![Nicht-invertierende Schmitt-Trigger
Schaltung](img/Experiment_02/noninv_schmitt.png){#02_fig_01
.align-center}

![Invertierende Schmitt-Trigger
Schaltung](img/Experiment_02/Inv_schmitt.png){#02_fig_02 .align-center}

Bei dem nicht-invertierendem Schmitt-Trigger geht der Zustand von
logisch 0 auf logisch 1 bei der positiven Schwellspannung über und von
logisch 1 auf logisch 0 bei der negativen Schwellspannung. Für den
invertierenden Schmitt-Trigger verhalten sich die Zustandänderung
invers. Für das Verhälnis der Ausgangs- zu Eingangsspannung ergibt sich:

$$\frac{V_{OUT}}{V_{IN}} = - A_0 \cdot \frac {1}{1-A_0 \cdot \beta}$$

wobei

$$\beta = \frac{R_1}{R_1 + R_2}$$

Das heißst, dass die Schwellspannungen mit Änderung des Wertes für
$\beta$ eingestellt werden können. Dieser ist widerum von den
Widerstandswerten abhängig. Zur Untersuchung dieser These wurde der
nicht-invertierende Schmitt-Trigger simuliert und gemessen. Die
Erbebnisse sind in `02_fig_03`{.interpreted-text role="numref"}
enstprechend graphisch dargestellt.

![Messung und Simulation des nicht-invertierenden Schmitt-Triggers für
Verschiedene
$\beta$](img/Experiment_02/non_inverting_schmitt_simulation_messung.png){#02_fig_03
.align-center}

Aus den Darstellung ist ersichlich, dass die Annahme der Abhängigkeit
der Schwellspannung von dem $\beta$ richtig ist.

## Messungen astabile und monostabile Kippstufen

Astabile Kippstuffe `02_fig_04`{.interpreted-text role="numref"}
arbeitet nach dem Prinzipp des Schmitt-Triggers. Sie wechselt periodisch
zwischen zwei Zuständen.

![Astabiler Multivibrator
(Kippstuffe)](img/Experiment_02/astab_multi.png){#02_fig_04
.align-center}

Der Periodendauer der Astabilen Kippstufe ist gegeben durch:

$$T = 2 \cdot RC \cdot ln(\frac{1 + \beta}{1 - \beta}) $$

Die Astabile Kippstuffe ist eine selbsttreibende Schaltung die die
Zustände zwischen den Versorgungsspannungen des Opams wechselt. Die
Simulations- und Messergebnisse sind in `02_fig_05`{.interpreted-text
role="numref"} entsprechend graphisch dargestellt.

![Astabiler Multivibrator (Kippstuffe) Simulation und
Messung](img/Experiment_02/astabile_kippstufe_mess_sim.png){#02_fig_05
.align-center}

Eine weiterer Einsatz des Schmitt-Triggers ist die Monostabile
Kippstufe(Multivibrator) `02_fig_07`{.interpreted-text role="numref"}.
Aus dem Namen kann die Funktion bereits abgeleitet werden.

![Monostabile Kippstufe
(Multivibrator)](img/Experiment_02/monostab_multi.png){#02_fig_07
.align-center}

Die Monostabile Kippstufe hat nur einen stabilen Zustand. Die
Zustandänderung wird mit Hilfe eines Trigger-Signals am Eingang
\"erzwungen\". Aufgrund der Beschaltung ändert sich der Zustand der
Monostabilen Kippstufe nur bei negativer Flanke in negative Richtung.
Die Dauer $\tau$ der Zustandsänderung ist definiert durch:

$$\tau =  RC \cdot ln(\frac{1}{1 - \beta}) $$

Nach der Erreichen des negativen Peaks kehrt die Kippstufe in ihren
sabilen Zustand zurück. Aufgrund der Kapazitäten in der Schaltung ist
die Rückkehr zum stabilen Zustand mit einem Zeitaufwand verbunden. Das
heißt, dass nach einer negativen Triggerflanke zum Zeitpunkt $t$ die
nächste negative Flanke zum Zeitpunkt $t + \tau '$ eingeleitet werden
darf.

$$\tau' = RC \cdot ln(\frac{1 + \beta}{\beta})$$

Die Simulation und Messung der Monostabilen Kippstufe ist in
`02_fig_08`{.interpreted-text role="numref"} graphisch dargestellt. Der
bereits beschrieben Signalverlauf ist deutlich zu erkennen.

![Messung und Simulation Monostabile Kippstufe mit einem
Triggersignal](img/Experiment_02/monostabile_kippstufe_mess_sim.png){#02_fig_08
.align-center}
