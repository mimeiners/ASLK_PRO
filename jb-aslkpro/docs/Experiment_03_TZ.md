# Charakteristik von Integrator und Differenzierer

## Kurze Theorie und Motivation

In diesem Experiment wird ein Operationsverstärker in der invertierenden Integrator- und der invertierenden
Differenzierer - Schaltung eingesetzt und dessen Verhalten untersucht.

Der erste Abschnitt beginnt mit der Aufnahme der Charakteristiken des Integrators. Dazu wird neben der mathematischen
Herleitung die Sprungantwort gemessen, also die Reaktion einer plötzlich anliegenden konstanten Eingangsspannung. Daran
lässt sich das allgemeine Verhalten des Integrators gut erkennen. Als nächstes wird ein Rechtecksignal eingespeist und
abschließend der Amplitudengang des Integrators aufgenommen, um die Frequenzabhängigkeit zu untersuchen.


Im zweiten Abschnitt wird der Differenzierer untersucht. Bei diesem wird zuerst das Verhalten am Ausgang betrachtet,
während am Eingangstor ein Dreieckssignal anliegt. Hiernach wird für den Differenzierer ebenfalls das Ausgangsverhalten
bei einer Rechteckwelle am Eingang und der Amplitudengang aufgenommen, um die Frequenzabhängigkeit mit der des
Integrators gegenüber zustellen.[^1]


Aufgabenpunkte aus dem `ASLK-Pro - Manual`[^2]:

1. Simulation des Integrators und Differenzierers auf Übertragungskennlinie und Phasengang 

2. Messung und Vergleich mit der Simulation der Übertragungskennlinie und des Phasengangs

3. Messung der Frequenzantwort

4. Messung Sprungantwort der Schaltungen 


## Invertierender Integrator

### Mathematische Herleitung

In diesem Kapitel betrachten wir nun die mathematische Herleitung der Ausgangsspannung $V_2$ des invertierenden
Integrators, dessen Schaltungsschema in {numref}`03_fig_01` dargestellt ist.


```{figure} img/Experiment_03/Abbildung01.png 
:name: 03_fig_01

Aufbau invertierender Integrator[^3].
```

Wie in der Abbildung zu erkennen ist, liegt das Eingangssignal $V_1$ am invertierenden Eingang des Operationsverstärkers
an. Somit kann man darauf schließen, dass es sich um eine invertierende Schaltung handelt. Für die Herleitung treffen
wir nun folgende Annahmen: Wir gehen davon aus, dass es sich um einen idealen Operationsverstärker handelt. Das heißt,
der Eingangswiderstand geht gegen ∞ Ω, der Ausgangswiderstand beträgt 0Ω und die (Leerlauf-) Differenzverstärkung geht
ebenfalls gegen Unendlich. Da die Differenzverstärkung ∞ beträgt können wir darauf schließen, dass die Spannung, welche
zwischen dem nicht-invertierendem und dem invertierenden Eingang anliegt, 0V beträgt ($V_d = V_+ − V_− = 0V$). Im
Folgenden werden wir die Herleitung über Maschengleichungen lösen (siehe {numref}`03_fig_02`). Hierbei ist der
Operationsverstärker als eine Art Blackbox zu betrachten, welche intern eigene Maschen besitzt. Deshalb muss darauf
geachtet werden, dass man keine Maschen durch den Operationsverstärker legt.


```{figure} img/Experiment_03/Abbildung02.png 
:name: 03_fig_02

Invertierender Integrator mit Maschen
```

Die erste Masche M1 lautet somit:

$$
	M1: −V_1 + i_1 · R − V_d = 0
$$ (03_eq_01)

Da $V_d = 0V$ ergibt sich nach Umstellung der obigen Masche 1 folgendes:

$$
	M1: V_1 = i_1 \cdot R
$$ (03_eq_02)

Aufgrund der Annahme, dass der Eingangswiderstand gegen $\infty$ geht, können wir entsprechend der Kirchhoffschen
Knotenregel sagen, dass $i_2 = i_1$ ist. Da $i_1$ durch den Kondensator C fließt, können wir diesen auch schreiben als:

$$
	i_1 = \frac{dV_C}{dt} C
$$ (03_eq_03)

Nun betrachten wir die zweite Masche M2. Es ergibt sich folgende Gleichung:

$$
	M2: −V_2 − V_C − V_d = 0
$$ (03_eq_04)

Nach Umstellen der Gleichung erhalten wir:

$$
	M2: V_2 = −V_C
$$ (03_eq_05)

Substituieren wir nun Gleichung {eq}`03_eq_05` in Gleichung {eq}`03_eq_03`, so erhalten wir den Strom $i_1$ in
Abhängigkeit von der Ausgangsspannung $V_2$. Mathematisch ausgedrückt ergibt sich somit der Ausdruck:

$$
	i_1 = -\frac{dV_2}{dt} C
$$ (03_eq_06)

Wenn man nun Gleichung {eq}`03_eq_02` nach $i_1$ umstellt und diese dann mit Gleichung {eq}`03_eq_06` gleichsetzt,
erhalten wir folgenden Ausdruck:

$$
	\frac{V_1}{R} = -\frac{dV_2}{dt} C
$$ (03_eq_07)

Da wir $V_2$ in Abhängigkeit von $V_1$ wissen möchten, stellen wir nun Gleichung {eq}`03_eq_07` nach $dV_2$ um. Es
ergibt sich somit:

$$
	dV_2 = -\frac{V_1 dt}{R \cdot C}
$$ (03_eq_08)

Wenn wir nun beide Seiten der obigen Gleichung integrieren, sprich die linke Seite nach $dV_2$ und die rechte Seite nach
$dt$, dann ergibt sich folgender Ausdruck:


$$
	\int dV_2 \, = -\int \frac{V_1 dt}{R·C}
$$ (03_eq_09)

Letztendlich ergibt sich die Ausgangsspannung $V_2(t)$ in Abhängigkeit der Eingangsspannung $V_1(t)$ zu:

$$
	V_2(t) = -\int \frac{V_1(t)dt}{R·C}+V_2(0)
$$ (03_eq_10)

Der letzte Summand der rechten Seite aus Gleichung {eq}`03_eq_10` berücksichtigt den Zustand des Kondensators zum
Zeitpunkt $t = 0$.

### Sprungantwort

Da die mathematische Ansicht nicht immer zu einem intuitiven Verständnis beiträgt, schauen wir uns den Integrator nun in
einem praktischen Beispiel an. Zuerst wird der Einheitssprung gemessen. Hierzu wird die Eingangsspannung von 0V spontan
auf 1V erhöht. Zu diesem Zeitpunkt integriert der Integrator die Eingangsspannung. Dies würde normalerweise dazu führen,
dass die Ausgangsspannung linear ansteigt. Da es sich jedoch um einen invertierenden Integrator handelt, nimmt die
Ausgangsspannung linear ab, bis diese letztendlich irgendwann gleich bleibt. Dies stellt eine wichtige Eigenschaft von
Operationsverstärkern dar, sodass diese keine Spannung ausgeben können, die größer als dessen positive
Versorgungsspannung oder kleiner als die negative Versorgungsspannung ist. Dies ist auch logisch, da die Spannung von
irgendwo kommen muss. Tatsächlich können Operationsverstärker in der Regel nicht mal die positive und negative
Versorgungsspannung erreichen, da innerhalb des OPs ein gewisser Spannungsabfall entsteht, der die maximale und minimale
Ausgangsspannung weiter einschränkt. Dies führt dazu, dass ein Operationsverstärker in einer Integrator - Schaltung nur
bis zu einem gewissen Punkt integrieren kann. 

Wenn eine konstante positive Eingangsspannung angelegt wird, sinkt (beim invertierenden Integrator) die Ausgangsspannung
stetig, bis die negative Sättigungsspannung erreicht wird. Anschließend bleibt die Spannung an diesem Punkt, bis eine
negative Eingangsspannung angelegt wird und die Ausgangsspannung wieder beginnt zu steigen.

Bei diesem Versuch ist der Ladezustand des Kondensators am Anfang der Messung wichtig. Der Ladezustand speichert den
Zustand des Integrators und dieser beeinflusst den Ablauf der Messung. Wenn die Eingangsspannung 0 V beträgt verändert
sich die Ausgangsspannung des Integrators nicht. Mathematisch gesehen ist die Steigung gleich Null. Das heißt, der
Integrator behält seinen letzten Wert bei. Wenn der Integrator also vor der Messung bei seiner positiven
Sättigungsspannung war, wird er (bei einer gleichen Eingangsspannung) länger brauchen um die negative Sättigungsspannung
zu erreichen, als wenn er bei 0V anfängt. Wenn der Integrator zu Beginn der Messung bereits bei der negativen
Sättigungsspannung liegt, passiert gar nichts. Somit ist es wichtig, dass der Kondensator zu Beginn der Messung entladen
ist, oder dass der Zustand zu Beginn der Messung zumindest berücksichtigt wird.

Um den Einheitssprung noch einmal kurz aus mathematischer Sicht zu betrachten, integrieren wir nun den
Einheitssprung. Der Einheitssprung ist mathematisch eine lineare Funktion mit einer Steigung von 0. Setzen wir nun in
Gleichung {eq}`03_eq_10` für den Widerstand R unseren Wert von $1k\Omega$, für die Kapazität C unseren Wert von $0,01
\mu F$ und für die Eingangsspannung V_1 den Spannungswert von 1V ein, so ergibt sich folgende Gleichung:


$$
	V_2(t) = -\int \frac{1V dt}{1k\Omega·0,01\mu F}+V_2(0)=-10^{5}\frac{V}{s}·t+V_2(0)
$$ (03_eq_11)

Gleichung {eq}`03_eq_11` bezieht sich natürlich auf einen idealen Operationsverstärker. Wie bereits oben erwähnt, gerät
der OP in der Realität in Sättigung. Für die Messung des Einheitssprungs ist der Ladezustand des Kondensators
wichtig. Da die Messung über das VP-Netzwerk stattgefunden hat, war das Entladen des Kondensators nicht so einfach
möglich. Es wurde versucht dieses Problem zu beheben, indem ein hochohmiger Widerstand parallel zum Kondensator
geschaltet wurde. Dies sollte den Ladezustand des Kondensators im Betrieb möglichst wenig beeinflussen, ihn jedoch
langsam entladen, wenn kein Eingangssignal anliegt. Dies hat leider nicht so gut funktioniert wie erhofft. Um die
Messung dennoch durchführen zu können, wurde anschließend eine rechteckförmige Wechselspannung mit einer Frequenz von
1kHz und einer Amplitude von 0,5V angelegt und das Verhalten bei der Schaltflanke beobachtet. Die Initial Condition war
hier somit kein entladener Kondensator (0 V am Ausgang), sondern ein vollständig geladener Kondensator (positive
Sättigungsspannung am Ausgang). Ein Einheitssprung von 0V auf 1V wäre zwar geeigneter, aber um die Funktionsweise des
Integrators zu illustrieren, ist diese Messung ausreichend.


```{figure} img/Experiment_03/Abbildung03.png 
:name: 03_fig_03

Sprungantwort des Integrators
```

Die Messung (unterer Graph) und die Simulation (oberer Graph) sind in Abbildung {numref}`03_fig_03` zu sehen. Hier fängt
der Integrator bei der positiven Sättigungsspannung an und aufgrund dessen, dass die Eingangsspannung negativ ist,
ändert sich dieses Verhalten auch nicht. Anschließend wird die Polarität des Eingangssignals schlagartig geändert und
die Ausgangsspannung des Integrators sinkt gleichmäßig, bis zur negativen Sättigungsspannung hin ab. Ab diesem Punkt
kann der Ausgang nicht weiter sinken und flacht wieder ab. Die Simulation stimmt in diesem Fall sehr gut mit der Messung
überein. Es wird jedoch eine Abweichung in der gemessenen Eingangsspannung festgestellt. Diese Abweichung ist bei allen
Messungen zu finden und liegt an einem Eingangsoffset des Red Pitayas. Dies könnte kalibriert werden, oder bei der
Messung herausgerechnet werden. Das wurde in diesem Fall nicht getan, denn das Ziel ist ja nicht dafür zu sorgen, dass
die Messungen genau dem entsprechen, was man erwartet, sondern zu schauen, inwiefern die Messung von dem zu erwartenden
Ergebnis abweicht und den Ursachen für diese Abweichung auf den Grund zu gehen.


### Rechtecksignal

Als Nächstes wird erneut eine rechteckförmige Wechselspannung mit einer Frequenz von 1kHz und einer Amplitude von 0,5V
als Eingangssignal angelegt und das resultierte Signal über mehrere Perioden untersucht. Die gemessenen Signale, sowie
die simulierten Signale sind in Abbildung {numref}`03_fig_04` zu sehen.


```{figure} img/Experiment_03/Abbildung04.png 
:name: 03_fig_04

Sprungantwort des Integrators
```

Hier stimmt die Messung (im unteren Graphen) sehr gut mit dem simulierten Signal (im oberen Graphen) überein. Genauso
wie bei der mathematischen Integration wird auch hier ein integriertes Rechtecksignal zu einem Dreiecksignal. Das
Dreiecksignal ist jedoch invertiert, denn wir arbeiten, wie bereits erwähnt, mit einem invertierenden Integrator. Es
fällt jedoch auf, dass die Dreieckswelle an den Spitzen abflacht. Dies liegt natürlich daran, dass der Integrator wie im
Unterkapitel "Sprungantwort" erklärt wurde, mit diesem Eingangssignal die Sättigung erreicht. Bei höheren Frequenzen ist
die Periodendauer kleiner und der Integrator würde somit nicht ganz so lange in die gleiche Richtung integrieren. Wenn
die Frequenz ausreichend hoch ist, wird die Dreieckwelle nicht mehr abgeflacht. Alternativ kann die Amplitude des
Eingangssignals verringert werden. Dann ist die Steigung des Ausgangssignals kleiner und der Integrator erreicht nicht
ganz so schnell seine Sättigungsspannung. Wenn die Schaltung verändert werden kann, kann natürlich auch die Wahl einer
anderen Kapazität oder eines anderen Widerstandes in Betracht gezogen werden, sodass der Integrator schneller oder
langsamer integriert. Aber auch durch Ändern der positiven und negativen Versorgungsspannung könnte die
Sättigungsspannung direkt beeinflusst werden.


### Amplitudengang

Anschließend wurde der Amplitudengang des Integrators gemessen. Hierzu wurde eine sinusförmige Wechselspannung mit einer
Amplitude von 1 V am Eingang des Integrators angelegt und die Frequenz von 1 Hz bis 1 GHz variiert. Dabei wurde am
Ausgang die Sinuswelle aufgenommen und dessen Amplitude bestimmt. Dies wurde für 1000 Frequenzen in logarithmisch
gleichmäßigen Abständen gemacht. Da niedrigere Frequenzen eine längere Periode haben, bleibt die Polarität des Signals
länger gleich und gibt dem Integrator mehr Zeit mit dem Ausgangssignal zu steigen bzw. zu sinken, als bei höheren
Frequenzen. Somit wird von dem Integrator ein Tiefpass-Verhalten erwartet. Durch das Integrieren wird das Signal
zusätzlich phasenverschoben und da es sich hier um die invertierende Variante handelt, ist das Ausgangssignal natürlich
ohnehin schon invertiert. Die Phasenverschiebung bzw. der Phasengang wird hier jedoch nicht näher betrachtet.


```{figure} img/Experiment_03/Abbildung05.png 
:name: 03_fig_05

Amplitudengang des Integrators
```

In Abbildung {numref}`03_fig_05` wird das Verhältnis der Amplitude an Aus- und Eingang in dB in Abhängigkeit zur
Frequenz grafisch dargestellt. In der Mitte des Messbereichs stimmt die Messung relativ gut mit den simulierten Daten
überein. Vorwiegend im unteren Frequenzbereich sind große Abweichungen zu sehen. Abgesehen von ein paar Ausreißern
verläuft das Signal flach im Vergleich zur Simulation. Wie wir in Abschnitt "Rechtecksignal" gesehen haben, erreicht der
Integrator bei einer 1 kHz Rechteckwelle mit einer halb so großen Amplitude die Sättigung. Bei einer Sinuswelle gerät
der Integrator erst später in Sättigung, da die durchschnittliche Amplitude einer Sinuswelle ca. 63 % so groß wie bei
einer Rechteckwelle (mit gleicher Amplitude) ist. Da die Amplitude bei dieser Messung doppelt so groß ist bezüglich der
Messung der Rechteckwelle, dürfte die Sättigung sogar ein wenig früher eintreten. Wie man an dem gemessenen
Amplitudengang sieht, verläuft das Signal relativ flach bis etwa 1 kHz und folgt anschließend gut dem Verlauf der
Simulation. Der flache Verlauf im unteren Frequenzbereich liegt also ganz klar daran, dass der Integrator in die
Sättigung getrieben wird. Die Sättigungsspannung wird zwar allgemein bei den Simulationen berücksichtigt, aber nur bei
der Simulation des Ein-/Ausgangssignals und nicht bei der Simulation des Amplitudengangs. Im höheren Frequenzbereich
weicht die Messung gar nicht so stark von der Simulation ab, ist jedoch recht stark mit Rauschen behaftet. Dies liegt
daran, dass der Red Pitaya bei höheren Frequenzen mit einer sampling rate von 125 MS/s nicht mehr schnell genug abtasten
kann, um zuverlässig den höchsten und niedrigsten Punkt der Sinuswelle aufzunehmen. Zusätzlich können bei bestimmten
Frequenzen auch durch Aliasing-Effekte ganz andere Amplituden als die echte Amplitude gemessen werden. Da es mehr oder
weniger Zufall ist, ob die Spitzen der Sinuswelle erwischt werden oder nicht, springt die gemessene Amplitude.



# Differenzierer

### Mathematische Herleitung

Wie beim Integrator beginnen wir auch hier zuerst mit der mathematischen Herleitung der Ausgangsspannung des
invertierenden Differenzierers. Die Schaltung des invertierenden Differenzierers ist in Abbildung {numref}`03_fig_06` zu
sehen. Vergleicht man nun diese Schaltung mit der des Integrators, so erkennt man, dass Widerstand und Kondensator
vertauscht sind.



```{figure} img/Experiment_03/Abbildung06.png 
:name: 03_fig_06

Aufbau invertierender Differenzierer[^3]
```

Bei dieser Herleitung gehen wir wieder davon aus, dass es sich um einen idealen Operationsverstärker handelt. Somit
gelten die gleichen Annahmen wie aus der mathematischen Herleitung des Integrators. Die eingetragenen Maschen sind in
Abbildung {numref}`03_fig_07` zu sehen.



```{figure} img/Experiment_03/Abbildung07.png 
:name: 03_fig_07

Invertierender Differenzierer mit Maschen
```

Die erste Masche M1 lautet somit:

$$
	M1: −V_1 + V_C − V_d = 0
$$ (03_eq_12)

Gleichung {eq}`03_eq_12` nach $V_1$ umgestellt lautet somit:

$$
	M1: V_1 = V_C
$$ (03_eq_13)

Den Strom $i_1$ aus Gleichung {eq}`03_eq_03` verändern wir mittels Gleichung {eq}`03_eq_13` in:

$$
	i_1 = \frac{dV_1}{dt}· C
$$ (03_eq_14)

### Dreieckssignal

Der Differenzierer macht mathematisch gesehen das Gegenteil vom Integrator. Während der Integrator die Stammfunktion des
Eingangssignals bildet, bildet der Differenzierer die Ableitung des Eingangssignals. Bei dem Integrator stellt also das
Eingangssignal die Steigung von dem Ausgangssignal dar, während bei dem Differenzierer das Ausgangssignal die Steigung
von dem Eingangssignal darstellt. Da es sich in diesem Laborversuch um einen invertierenden Integrator und ebenfalls
einen invertierendem Differenzierer handelt, ist zu beachten, dass das Ausgangssignal in beiden Fällen invertiert
ist. Bei dem Integrator wurde gezeigt, dass aus einer Rechteckwelle, wie zu erwarten, nach der Integration eine
Dreieckwelle wird. Bei dem Differenzierer würde man demzufolge erwarten, dass aus einer Dreieckwelle eine Rechteckwelle
wird. Um dies zu überprüfen, wurde eine dreieckförmige Wechselspannung mit einer Frequenz von 300 Hz und einer Amplitude
von 0,5 V in den Differenzierer gespeist und das dadurch resultierende Ausgangssignal aufgenommen. Das Ergebnis der
Messung, sowie die simulierten Werte sind in Abbildung {numref}`03_fig_08` zu sehen.


```{figure} img/Experiment_03/Abbildung08.png 
:name: 03_fig_08

Reaktion des invertierenden Differenzierer auf ein Dreiecksignal
```

Grundsätzlich lässt sich hier zwar ein Rechtecksignal erkennen. Allerdings zeigt sich sowohl in der Messung wie auch in
der Simulation eine relativ starke Oszillation des Ausgangssignals nach jeder Spitze des Dreiecksignals. Dies stellt
eines der Probleme von Differenzierern dar. Bei schnellen Änderungen, hat der OP eine Tendenz mit dem Ausgangssignal
über den eigentlich erwünschten Wert hinaus zuwachsen und sich anschließend auf den korrekten Wert einzupendeln. Dies
ist bei vielen Regelschaltungen ein Problem, wo nur die Differenz zwischen Ist- und Sollwert berücksichtigt wird,
sogenannte P-Regler. Der Operationsverstärker stellt in diesem Fall lediglich eine Regelschaltung dar, die ihre
Ausgangsspannung in Abhängigkeit zu der Eingangsspannung regelt. In vielen Regelschaltung ist das Schwingen kein großes
Problem. In sehr dynamischen Systemen mit vielen schnellen Änderungen kann es jedoch zu einem Problem werden. Dieses
Problem wird häufig durch das Einsetzen eines PID-Reglers gelöst, bei dem noch weitere Faktoren wie z. B. die
Annäherungsgeschwindigkeit von Ist- zu Sollwertes berücksichtigt werden. Um dies bei dem Differenzierer zu
bewerkstelligen, müsste mehr als nur ein OP, ein Kondensator und ein Widerstand zum Einsatz kommen, wodurch sich die
Schaltung wesentlich verändern würde. Um das Schwingen des Differenzierers auf einfache Art zu mildern wird häufig ein
Widerstand in Reihe mit dem Kondensator geschaltet. Dadurch verlangsamt sich die Reaktion des OPs, was verhindert, dass
der OP so weit über den erwünschten Wert hinausschießt. Dies löst das Problem jedoch nicht wirklich, denn dabei werden
lediglich die hochfrequenten Anteile des Eingangs- und Ausgangssignals herausgefiltert. So wird das Schwingen reduziert,
aber dafür wird die Dreieckwelle (zumindest aus Sicht des Differenzierers) an den Ecken abgerundet, was wiederum dazu
führt, dass ebenfalls die Rechteckwelle abgerundete Ecken bekommt. Ansonsten fällt ebenfalls auf, dass das Schwingen bei
den gemessenen Daten wesentlich langsamer ist und langsamer ausklingt als bei der Simulation. Das Verhalten des
gemessenen Differenzierers entspricht einem Differenzierer mit einem etwa 1000 mal größerem Kondensator, einem etwa 1000
mal größerem Widerstand oder einer Kombination der beiden, die einen Unterschied um einen Faktor von etwa 1000
bewirkt. Zum Vergleich ist in Abbildung {numref}`03_fig_09` wieder die Simulation und Messung zu sehen, mit dem
Unterschied, dass bei der Simulation von einem Widerstand von $1M\Omega$ statt $1k\Omega$ ausgegangen wurde. Der
gemessene Verlauf ist dabei unverändert.


```{figure} img/Experiment_03/Abbildung09.png 
:name: 03_fig_09

Reaktion des invertierenden Differenzierer auf ein Dreiecksignal (veränderte Widerstände)
```

Wie zu sehen ist, stimmt die Simulation hier wesentlich genauer mit den gemessenen Werten überein. Kondensatoren und
Widerstände haben natürlich eine gewisse Toleranz und das Ganze ist mit relativ dünnen Leitungen verkabelt, die
natürlich auch einen gewissen Widerstand haben. Je nachdem wie die Leitungen liegen können sie auch gewisse Kapazitäten
und Induktivitäten bilden. All diese Faktoren würden jedoch in aller Regel bei weitem keinen zusätzlichen Widerstand von
999 kΩ oder eine Kapazität von 990 nF verursachen. Eine Kombination der beiden, die eine derartige Abweichung
verursachen würde ist zwar nicht auszuschließen, ist aber durchaus unwahrscheinlich. Realistischer wäre ein schlechter
Kontakt bei dem Widerstand der zu einem hohen Übergangswiderstand geführt hat, oder dass versehentlich die Einheit der
Kapazität oder des Widerstands verwechselt wurde, wie etwa ein Widerstand mit $1M\Omega$ statt $1k\Omega$oder ein
Kondensator mit $100\mu F$ statt $100nF$, denn die Abweichung um einen Faktor von ausgerechnet 1000 ist schon recht
auffällig. Da die Messungen jedoch über das Internet aufgenommen wurden, ist es schwer einzuschätzen, was die Abweichung
am ehesten verursacht haben könnte.

### Rechtecksignal

Als Nächstes wurde eine rechteckförmige Wechselspannung mit einer Frequenz von 75Hz und einer Amplitude von 0,5V in den
Differenzierer gespeist. Ein Rechtecksignal bleibt die meiste Zeit über gleich und hat immer nur kurze Sprünge beim
Polaritätswechsel. Bei einer perfekten Rechteckwelle haben diese Sprünge für eine unendlich kurze Dauer eine unendlich
hohe Steigung. Alle anderen Bereiche haben eine Steigung von 0. Der Differenzierer kann natürlich weder eine unendlich
hohe Steigung noch eine unendlich kurze Dauer darstellen. Was die Messung und die Simulation ergeben haben, ist in
Abbildung {numref}`03_fig_10` zu sehen.


```{figure} img/Experiment_03/Abbildung10.png 
:name: 03_fig_10

Reaktion des invertierenden Differenzierer auf ein Rechtecksignal
```

Auch hier verhält sich der gemessene Differenzierer ähnlich wie einer mit einem Faktor 1000 größerem Kondensator oder
Widerstand. Zum Vergleich sind in Abbildung  {numref}`03_fig_11` wieder eine Simulation (mit $1M\Omega$ statt
$1k\Omega$) und die Messung zu sehen.


```{figure} img/Experiment_03/Abbildung11.png 
:name: 03_fig_11

Reaktion des invertierenden Differenzierer auf ein Rechtecksignal (veränderte Widerstände)
```

Hier klingt die Messung zwar schneller ab als bei der Simulation mit 1000 fachem Widerstand, aber die Schwingfrequenz
ist sehr ähnlich. Während man mathematisch gesehen eine flache Linie (0V) mit kurzen (unendlich hohen) vertikalen
Spitzen beim Polaritätswechsel erwarten würde, sehen wir auch hier das im vorigen Abschnitt bereits erklärte Problem mit
der Schwingung. Das Ganze ist hier jedoch wesentlich extremer. Der erste Impuls mit (idealer) unendlicher Steigung lädt
den Kondensator am Eingang so weit auf, dass der OP sofort in die Sättigung geht, für ca. 1 Millisekunde in der
Sättigung bleibt und sich erst danach langsam zurück auf die 0V auspendelt.


### Amplitudengang

Anschließend wurde, genauso wie bei dem Integrator, auch für den Differenzierer der Amplitudengang gemessen. Hierzu
wurde wieder eine sinusförmige Wechselspannung mit einer Amplitude von 1 V am Eingang des Differenzierers angelegt und
die Frequenz von 1 Hz bis 1 GHz variiert, während die resultierende Sinuswelle am Ausgang aufgenommen und dessen
Amplitude bestimmt wurde. Dies wurde ebenfalls für 1000 Frequenzen in logarithmisch gleichmäßigen Abständen
gemacht. Während der Integrator sich wie ein Tiefpass Filter verhielt, sollte der Differenzierer sich wie ein
Hochpassfilter verhalten. Denn je höher die Frequenz einer Sinuswelle, desto schneller steigt und fällt die Sinuswelle
und desto höher ist dessen Steigung. Allerdings kommt man früher oder später an einen Punkt, an dem der OP nicht schnell
genug auf die Änderungen am Eingangssignal reagiert und die Amplitude am Ausgang bei steigender Frequenz wieder
abfällt. Wenn man sich also einen ausreichend großen Frequenzbereich anschaut, verhält sich der Differenzierer eher wie
ein Bandpassfilter. Der gemessene und simulierte Amplitudengang ist in Abbildung {numref}`03_fig_12` zu sehen.


```{figure} img/Experiment_03/Abbildung12.png 
:name: 03_fig_12

Amplitudengang des invertierenden Differenzierers
```

Wie man sieht, stimmen die gemessenen Daten nicht sonderlich gut mit der Messung überein. Dies hat mehrere Gründe. Um
die Amplitude in dB zu bestimmen wurde für jede Frequenz das Ein- und Ausgangssignal gemessenen und jeweils der höchste
und tiefste Punkt bestimmt und dessen Differenz als Spitze-Spitze-Spannung genommen. Anschließend wurde das Verhältnis
der Aus- und Eingangsamplitude in dB errechnet. Dies ist eine recht einfache Art den Amplitudengang zu bestimmen. Sie
hat in manchen Fällen jedoch Nachteile. In dem unteren Frequenzbereich ist das Signal z.B. stark verrauscht, dies führt
dazu, dass die gemessene Spitze-Spitze-Spannung wesentlich höher sein kann, als die tatsächliche Spitze-Spitze-Spannung
des Signals. Da vorwiegend das Ausgangssignal verrauscht ist, wird vorwiegend ein zu hoher Wert für die Amplitude
berechnet. Im oberen Frequenzbereich besteht das Problem, dass die Samplingrate des Red Pitayas mit 125 MS/s zu langsam
ist, um zuverlässig die Hoch- und Tiefpunkte des Signals zu erwischen und die gemessene Amplitude somit ein wenig
willkürlich hoch und runter springt. Durch diesen Effekt würde die gemessene Amplitude eher zu niedrig ausfallen. Aber
die Ursache des Rauschens im unteren Frequenzbereich ist nicht ganz klar und im oberen Frequenzbereich ist die
Abtastrate des Red Pitayas so langsam im Vergleich zu dem gemessenen Signal, dass nicht wirklich geprüft werden kann, ob
das Signal ebenfalls verrauscht ist. Zudem fallen bei höheren Frequenzen viele weitere Einflüsse mit an, wie
z. B. Reflexionen des Signals innerhalb der Leitungen. Bei dem Aufbau der Schaltung wurden keine besonderen Maßnahmen
ergriffen, um diese Störeinflüsse zu minimieren. Ein Zusammenspiel der genannten Einflüsse würde die starke Abweichung
und das Schwanken des gemessenen Amplitudengangs im unteren und oberen Frequenzbereich erklären. Allerdings fällt auch
auf, dass der gemessene Amplitudengang in der Mitte abflacht. Dies liegt daran, dass der Differenzierer an dieser Stelle
die Sättigung erreicht. Wie bereits erklärt wurde, wird bei der Simulation des Amplitudengangs nicht die Sättigung des
OPs berücksichtigt, der reelle OP kann jedoch logischerweise maximal seine Sättigungsspannung erreichen. Die maximal zu
erreichende Amplitude könnte in diesem Fall z.B. vergrößert werden, indem die Amplitude des Eingangssignals verringert
wird. Denn die Sättigungsspannung bleibt gleich und somit auch die Spitze-Spitze-Spannung am Ausgang. Die
Spitze-Spitze-Spannung am Eingang sinkt jedoch. Und dadurch steigt logischerweise der Amplitudengang in dB. Dies würde
jedoch gleichzeitig zu noch mehr Rauschen und somit noch ungenauere Messungen führen. Das Problem mit dem Rauschen wurde
auf mehrere Arten und Weisen versucht zu minimieren. Eine Methode bestand darin, die gemessenen Signale zu einer
Sinuswelle zu fitten und dessen Amplituden zu nutzen. Dabei besteht jedoch das Problem, dass das Ausgangssignal nicht
immer sinusförmig ist. Wenn der OP z. B. in die Sättigung geht, wird das Signal oben und unten abgeschnitten. Wenn der
OP sehr stark in die Sättigung getrieben wird, kann das Ausgangssignal eher zu einer Rechteckwelle werden. Zusätzlich
besteht bei höheren Frequenzen das Problem, dass die Sinuswelle viel zu langsam abgetastet wird, um eine brauchbare
Sinuswelle fitten zu können. Es wurde ebenfalls versucht mit einem moving average Filter das Rauschen zu mildern. Diese
Lösungsansätze haben leider keinen wesentlichen Erfolg erzielt. Ein weiteres Problem war, dass die gemessenen Signale
teilweise am Anfang oder am Ende Sprünge hatten. Dies könnte daran liegen, dass bei der Messung der einzelnen Frequenzen
nicht viele „delays“ eingesetzt wurden, um die Messdauer zu minimieren. Möglicherweise konnte der Red Pitaya die
Einstellung gelegentlich nicht schnell genug übernehmen bevor die Messung gestartet wurde. Um dieses Problem zu beheben
wurde nachträglich ein Teil der Messdaten am Anfang und am Ende verworfen. Zur Erstellung des Graphen in Abbildung
{numref}`03_fig_12` wurde lediglich, wie bereits beschrieben, am Anfang und am Ende der Messdaten jeweils ein Teil
abgeschnitten, um die Sprünge zu vermeiden. Somit sind die Daten relativ unbearbeitet. Der so bestimmte Amplitudengang
wurde einmal direkt und einmal in geglätteter Form geplottet, dies hilft in dem rauschigen Bereichen den Mittelwert zu
erkennen. Zum Glätten des Amplitudengangs wurde ein moving average Filter mit einer Weite von 20 Samples (von insgesamt
1000 Samples) verwendet, es wurden also die umliegenden 2 % der Samples mitberücksichtigt. Auch wenn der gemessene
Amplitudengang weit von perfekt entfernt ist, zeigt sich dennoch eine gewisse Bandpasstendenz des Amplitudengangs. Diese
ist jedoch wesentlich weniger ausgeprägt als in dem simulierten Amplitudengang. Insgesamt muss natürlich auch
berücksichtigt werden, dass die Simulation sehr idealisiert ist und es mit einem echten OP ohnehin nicht möglich ist
dieses genaue Verhalten zu reproduzieren. Unter Berücksichtigung der Problematik mit den vielen Fehlerquellen ist das
Ergebnis des Versuchs somit gar nicht so weit von dem entfernt, was man bei einer reellen Differenzierer-Schaltung
erwarten würde.

[^1]: ANS-Abschlussbericht SoSe21 von V.Grebnev, T.Hilker und D.Klinker

[^2]: Analog System Lab Kit PRO MANUAL von 2012 - Authors: K.R.K. Rao and C.P. Ravikumar 

[^3]: Elektronische Bauelemente, Michael Reisch, 2. Auflage
