.. _TinaSpice: https://www.ti.com/tool/TINA-TI

########################################
Experiment 10: Entwurf eines LDO Reglers
########################################

****************************
Kurze Theorie und Motivation
****************************

Um eine feste, vorgegebene Spannung in eine beliebige Wunschspannung umzuwandeln, werden Spannungsregler verwendet.  
Für niedrige Spannungen kann ein "Low Dropout Regler" (LDO) verwendet werden. Dieser zeichnet sich für seine hohe
Effizienz und seine rauscharme Umwandlung aus. Außerdem kann durch Anpassung der Ausgangsspannung des LDOs die Effizienz
der angeschlossenen Komponente gesteigert und damit einher die Abwärme reduziert werden.

Gegenüber den DC/DC PWM gesteuerten Spannungswandlern hat der LDO keine Welligkeit in der Ausgangsspannung. 
Außerdem werden nur wenige zusätzliche Bauteile benötigt, was zusätzlich das Designen von Platinen erleichtert.

Dropout
=======

Der Dropout entspricht der Differenzspannung zwischen dem Ein- und Ausgang und fällt so über dem LDO ab. 
Eine Dropoutspannung fällt immer an, sodass erst ab einer ausreichenden Eingangsspannung die gewünschte Ausgangsspannung
ausgegeben werden kann. Mit steigender Eingangsspannung steigt die Dropoutspannung ebenfalls. 

Aufschluesselung der Funktionsgruppen
=====================================

Anhand des ersten Versuchs soll ein Spannungsregler mit Hilfe eines Operationsverstärkers, einem PMOS-FET und weiteren
Bauteilen realisiert werden. Das Ziel ist es eine Ausgangsspannung :math:`V_{0}` von :math:`3V` zu erhalten, während die
Eingangsspannung :math:`V_{UN}` zwischen :math:`4V` und :math:`5V` variiert.  Zur Verfügung steht eine Schaltung mit
unbekannten Variablen. Diese gelten nun zu bestimmen. Die Schaltung sieht wie folgt aus :numref:`10_fig_01`: 

.. figure:: img/Experiment_10/LDO_Regulator.png
   :name: 10_fig_01
   :align: center
	    
   LDO-Regulator [1]

Da auf dem ASLKpro-Board bestimmte Bauteile vorgegeben sind, setzen wir bei dem Operationsverstärker auf den TL082 und
bei dem P-MOS auf den BS250P. Um die restlichen benötigte Bauteile zu bestimmen ist es hierzu von Nöten die Aufgabe der
einzelnen Bauteile zu kennen!

Referenzspannung
================

Die Referenzspannung :math:`V_{ref}` wird durch die Zenerdiode und dem Vorwiderstand :math:`R` bestimmt.  Eine
Zener-Diode wird verwendet um den Zener-Effekt zu nutzen. Solange die Eingangsspannung größer als die Durchbruchspannung
der Zener-Diode ist, liegt die Durchbruchspannung an der Zener-Diode an. Dies bedeutet, dass dort dauerhaft eine
gleichbleibende Spannung vorhanden ist, obwohl die Eingangsspannung variieren kann.  Die Spannungsdifferenz zwischen
Eingangsspannung und Durchbruchspannung fällt über den Vorwiderstand :math:`R` ab. 

.. figure:: img/Experiment_10/Referenzspannung.png
   :name: 10_fig_02
   :align: center
	    
   Referenzspannung [1]

Um die Zenerdiode zu bestimmen, muss die Referenzspannung ausgerechnet werden. 
Diese erhalten wir über die folgende Formel:

.. math::
   :label: 10_eq_01
	
   V_{ 0 }= V_{ ref }\left[ 1 + \frac{ R_{ 2 } }{ R_{ 1 } }\right]

Herauszulesen ist, dass :math:`V_{0}` über die Referenzspannung und dem Verhältnis der Widerstände :math:`R_{2}` zu
:math:`R_{1}` eingestellt werden kann.  Durch das auflösen der Klammer wird nochmal verdeutlicht, dass :math:`V_{ref}`
kleiner sein muss als :math:`V_{0}`: 

.. math::
	:label: 10_eq_02
	
	V_{ 0 }= V_{ ref } + V_{ ref }\frac{ R_{ 2 } }{ R_{ 1 } } \\

Da in unserem Fall eine Ausgangsspannung von :math:`V_{0} = 3V` gefordert ist ergibt sich hierfür folgendes Ergebnis:

.. math::
   :label: 10_eq_03
	
   V_{ ref } < V_{ 0 } \to V_{ ref } < 3V \\

Wie zuvor erwähnt, entspricht die Referenzspannung der Durchbruchspannung der Zenerdiode. 
Daher ist nun eine Zenerdiode zu wählen, deren Durchbruchspannung :math:`U_{Z} < 3V` entspricht. 
Hierfür kann z.B. eine Zenerdiode mit :math:`U_{Z} = 2,4V` oder :math:`U_{Z} = 2,7V` verwendet werden. 
In unserem Fall haben wir uns für eine Z-Diode mit :math:`U_{Z} = 2,4V` entschieden. 
Daher entspricht :math:`V_{ref} = 2,4V`

Nun wird der Vorwiderstand R bestimmt. Dieser dient dazu den Durchbruchstrom einzuhalten, der im Datenblatt der Z-Diode
zu finden ist.  In unserem Fall beträgt dieser :math:`5mA`. Mit dem Ohmschen Gesetz kann nun der Widerstand :math:`R`
bestimmt werden:

.. math::
   :label: 10_eq_04
	
   R = \frac{ V_{ UN } - U_{ z } }{ I_{ BV }+ I_{ -op } }

:math:`I_{-op}` entspricht dem Strom, der in den Operationsverstärker abgeführt wird. 
Da hier jedoch der Idealfall betrachtet wird, ist der Eingangswiderstand unendlich groß und somit wäre :math:`I_{-op} = 0A`. 
Daher ergibt sich folgender Vorwiderstand:

.. math::
   :label: 10_eq_05
	
   R = \frac{ U_{ ges } - U_{ z } }{ I_{ BV }+ I_{ L } } = \frac{ 4,5V - 2,4V }{ 5mA+ 0A} = 420 \Omega

	
Spannungsteiler/Rückführgröße
=============================

Da bereits Vref gewählt wurde, kann nun das Verhältnis der Widerstände :math:`R_{2}` zu :math:`R_{1}` bestimmt werden.

.. figure:: img/Experiment_10/Spannungsteiler.png
   :name: 10_fig_03
   :align: center
	    
   Spannungsteiler / Rückführgröße [1]


.. math::
   :label: 10_eq_06
	
   V_{ 0 } = V_{ ref }\left[ 1+ \frac{ R_{ 2 } }{ R_{ 1 }  } \right]

Durch einsetzen von :math:`V_{ref} = 2,4V` und :math:`Vo = 3V` ergibt sich folgendes Verhältnis:

.. math::
   :label: 10_eq_07
	
   3V = 2,4V \left[ 1+ \frac{ R_{ 2 } }{R_{ 1 }  } \right] \to 0,6V = 2,4 V \frac{ R_{ 2 } }{ R_{ 1 } } \to \frac{ 0,6V }{ 2,4V } = \frac{ R_{ 2 } }{ R_{ 1 } }=\frac{ 1 }{4 }

Somit muss :math:`R_{1}` viermal so groß wie :math:`R_{2}` gewählt werden. Außerdem ist zu beachten, dass um so größer
die Widerstände gewählt werden, Toleranzen immer weniger eine Rolle spielen und so die Ausgangsspannung :math:`V_{0}`
stabiler wird. Daher haben wir uns für :math:`R_{1} = 100k\Omega` und :math:`R_{2} = 25k\Omega` entschieden. 


PMOS
====

Wie schon erwähnt, können mit einem LDO Spannungen auf eine stabile Spannung hochtransformiert werden. Beispielsweise
von :math:`3,3V` auf :math:`4V`. Der PMOS ist so verbaut, dass die entstehende Spannung vom Source-Anschluss zum
Gate-Anschluss die :math:`U_{DS}` Spannung bildet. Diese wiederum beeinflusst unsere Zielspannung
:math:`V_{0}`. :math:`V_{0}` ist die Differenz aus der Eingangsspannung :math:`V_{UN}` und der Spannung :math:`U_{SG}`,
die am PMOS anliegt und auch Dropout-Spannung genannt wird. Die Spannung :math:`U_{SG}` reguliert den Stromfluss
zwischen dem Source-Anschluss und dem Drain-Anschluss. Somit steuert allgemein gesagt die Spannung :math:`U_{SG}`
die Spannung :math:`U_{SD}`. Da bei Beeinflussung des Stromes sich auch die Spannung entsprechend ändert.  


Regelstrecke
============

Die Referenzspannung entspricht der Spannung von von :math:`R_{1}` die durch den Spannungsteiler entsteht. Diese beiden
Spannungen werden im OP miteinander verglichen. :math:`V_{ref}` zu :math:`V_{out}` ist das gleich wie :math:`R_{1}` zu
(:math:`R_{1}+R_{2}`). Vref muss kleiner als :math:`V_{0}` sein, daher wurde als Diodenspannung :math:`2,4V` gewählt. An
:math:`R_{1}` liegt die Diodenspannung an und an :math:`R_{2}` die Differenz von Diode und :math:`V_{0}`, also ungefähr
:math:`0,6V`. Die Spannung an dem Widerstand :math:`R_{1}` ist die Rückführgröße und diese wird permanent mit der
Referenzspannung verglichen. Da es sich ständig ändert (auch wenn minimal) entsteht eine Frequenz, die in
unserem Fall ca. :math:`250kHz` entspricht. Also um es nochmal zu sagen, über den OP steuert man den
Stromfluss am PMOS, der von Source zu Drain fließt, welche somit auch die VDO Spannung dann beeinflusst. Die
Spannung die aus dem OP austritt steuert folglich dann den Gate-Anschluss vom PMOS an. 

.. figure:: img/Experiment_10/Regelstrecke.jpeg
   :name: 10_fig_04
   :align: center
	    
   Darstellung Regelstrecke [1]

   
Stabilisierung der Spannung bei Änderung des Lastwiderstandes
=============================================================

Zusätzlich regelt die Regelstrecke für einen bestimmten Widerstandsbereich für :math:`R_{L}` die Spannung :math:`V_{0}`
auf konstant :math:`3V`. Wenn man :math:`R_{L}` jetzt kleiner dimensioniert dann wird der Strom :math:`I_{L}`
größer. Dieser Strom fließt auch durch den PMOS also steigt folglich der Source-Drain Strom auch. Nach den Regeln des
Ohmschen Gesetzes muss auch die Spannung :math:`V_{SD}` steigen. Dadurch sinkt dann die Spannung :math:`V_{0}`. Weil es
gilt: :math:`V_{IN} = V_{SD} + V_{0}`. Also wenn :math:`V_{SD}` größer wird muss :math:`V_{0}` kleiner werden. Folge
davon für den Rückführwert ist, dass an :math:`R_{1}` nun eine kleinere Spannung anliegt. Somit ist am + Anschluss des
OP eine kleinere Spannung, sodass der Verstärker invertiert. Jetzt liegt eine größere negative Spannung am Gate des PMOS
an. Damit steigt logischer Weise die Spannung :math:`U_{GS}` und dies führt dazu, dass ein höherer Source-Drain Strom
fließt. Denn je höher die Gate Source Spannung ist, desto größer wird der Source-Drain Strom, da der Widerstand
:math:`R_{SD}` wird kleiner. Folge davon ist, dass die Spannung :math:`V_{SD}` sinkt. Dann entsteht wieder durch das
Verhältnis :math:`V_{IN} = V_{SD} + V_{0}`ein Ausgleich, weil die Spannung an :math:`V_{0}` wieder ansteigt, da
:math:`V_{SD}` gesunken ist. Somit werden konstant :math:`3V` für einen bestimmten Widerstandsbereich der Last
gehalten. Zusammengefasst kann man sagen, dass der Regelkreis für einen bestimmten Lastbereich für
:math:`R_{L}` unabhängig arbeitet und trotzdem :math:`3V` hält.  

      
***********************
TinaSpice_ Simulationen
***********************

**10.4.1 Schaltung Nr.1**

Simuliert mit TinaSpice_ schaut der Aufbau wie folgt aus :numref:`10_fig_05`: 

.. figure:: img/Experiment_10/SCHALTPLAN_1.png
   :name: 10_fig_05
   :align: center
	    
   Schaltung 1 mit TinaSpice simuliert [2]
	    

.. figure:: img/Experiment_10/WelligkeitS1.png
   :name: 10_fig_06
   :align: center
	    
   Schaltung 1 Messung mit TinaSpice simuliert [2]

	
Anhand der Messung :numref:`10_fig_06` ist zu erkennen, dass die Ausgangsspannung Vo (in lila dargestellt) leicht
variiert. Dies ist auf die Referenzspannung Vref (in grün dargestellt) zurückzuführen. Da die Eingangsspannung um
:math:`+-0,5V` variiert ändert sich somit auch der Strom, der durch den Vorwiderstand :math:`R` eingestellt wurde. Somit
variiert die Durchbruchspannung um ungefähr :math:`0,05V`. Effektiv bleibt die Durchbruchspannung jedoch bei den
gewählten :math:`2,4V`. Durch diesen Einfluss variiert auch am Ausgang die Spannung Vo um :math:`+-0,05V`. Mit
Hilfe eines Kondensators kann bei Bedarf die Ausgangsspannung geglättet werden. Hierzu muss dieser parallel zur
Last angeschlossen werden. Vgs entspricht der Differenzspannung zwischen dem Ausgang des Operationsverstärkers und
der Sourcespannung. Die zurückgeführte Größe, die über :math:`R_{1}` gemessen wurde (VR1 in dunkelgrün) entspricht
der Referenzspannung, die aus dem Ausgang durch das Widerstandsverhältnis zurück gewandelt wurde. Somit findet
eine dauerhafte Nachregelung statt, damit der Ausgang nahezu stabil bleibt. Somit kann die Restwelligkeit bestimmt
werden, welche wie folgt bestimmt wird: 

.. math::
   :label: 10_eq_08
	
   \text{ Restwelligkeit } = \frac{ \Delta U_{ AC } }{ U_{ DC } } = \frac{ 0,11V }{ 3V } = 0.036

**10.4.2 Schaltung Nr.2**

Für die 2. Schaltung :numref:`10_fig_07` wird ein gängiger Spannungsregler verwendet. Die Komponenten wurden soweit aus
den Unterlagen des Manuels entnommen und mit den beiden Dioden verwendet. 

.. figure:: img/Experiment_10/SCHALTPLAN_2.png
   :name: 10_fig_07
   :align: center
	    
   Schaltung 2 mit TinaSpice simuliert [2]
	    
	    
Es ist das gleiche Ziel dieser Schaltung, eine Ausgangsspannung von :math:`3V` zu erzeugen, während die Eingangsspannung
von :math:`4V` bis :math:`5V` variiert (grün). Die Referenzspannung (blau) über der Diode variiert zwischen
:math:`1,62V` und :math:`1,74V`.  Die Ausgangsspannung, welche über :math:`R_{6}` gemessen wird, variiert
ebenfalls. Hier schwankt die Spannung zwischen :math:`2,5V` und :math:`3,5V`, sodass zu erkennen ist, dass der
Eingangswechselspannungsanteil 1:1 auf den Ausgang übergeben wird. Die Restwelligkeit beträgt somit:  

.. math::
   :label: 10_eq_09
	
   \text{ Restwelligkeit } = \frac{ \Delta U_{ AC } }{  U_{ DC } } = \frac{ 0,93V }{ 3V } = 0.031


.. figure:: img/Experiment_10/WelligkeitS2.png
   :name: 10_fig_08
   :align: center
	    
   Schaltung 2 Messung mit TinaSpice simuliert [2]


**10.4.3 Load Regulation im Vergleich**


Die Load Regulation beschreibt das Verhalten der Ausgangsspannung bei Änderung der Last. Die Last ist hier als Laststrom
gemeint, der mit sinkendem Ausgangswiderstand steigt. Betrachtet wird der Bereich, sobald die Ausgangsspannung von
:math:`3V` erreicht wird und berechnet sich über folgende Formel:

.. math::
   :label: 10_eq_10
	
   \text{ Load Regulation } = 100 \% \frac{ V_{ NL } - V_{ FL } }{ V_{ FL } }


Beträgt die Load Regulation 0%, so ist die Schaltung Last unabhängig, was der Idealfall wäre. Da wir jedoch nur die
Simulationen betrachten können, wird hier der Idealfall eintreten. Für die erste Schaltung (rot) ist die
Ausgangsspannung ab :math:`500 \Omega` stabil und die Load Regulation beträgt 0%. Für die 2. Schaltung beträgt die
Ausgangsspannung :math:`3V` bereits ab einen Widerstand von :math:`120\Omega`.

.. figure:: img/Experiment_10/loadvergleich.png
   :name: 10_fig_09
   :align: center
	    
   Load Regulation im Vergleich mit TinaSpice simuliert [2]
	    

**10.4.4 Line Regulation im Vergleich**


Die Line Regulation beschreibt das Verhalten der Ausgangsspannung während sich die Eingangsspannung verändert. Beträgt
die Line Regulation 0%, so wird bei einer variierenden Eingangsspannung eine saubere Gleichspannung ausgegeben. Es ist
also kein Wechselspannungsanteil mehr vorhanden. Da die Eingangsspannung in unserem Fall zwischen :math:`4V` und
:math:`5V` variiert, haben wir diese Werte gewählt. Der Lastwiderstand wurde auf :math:`10k\Omega` festgelegt.

      
.. figure:: img/Experiment_10/linevergleich.png
   :name: 10_fig_10
   :align: center
	    
   Line Regulation im Vergleich mit TinaSpice simuliert [2]


So ergibt sich für die erste Schaltung eine Line Regulation von:

.. math::
   :label: 10_eq_11
	
   \text{ Line Regulation } = 100 \% \frac{ \Delta V_{ out } }{ \Delta V_{ in } } = 100 \% \frac{ 0,115V }{ 1V } = 11,5 \%

Ebenfalls ist zu erkennen, dass die erste Schaltung in dem Bereich zwischen :math:`4V` und :math:`4,075V` sich die
Schaltung in einem instabilen Bereich befindet. Dies liegt daran, dass die Eingangsspannung die nicht die
Mindestdropoutspannung und die :math:`3V` Ausgangsspannung liefern kann.

Für die 2. Schaltung ist die Line Regulation, wie zu erwarten, schlecht.

.. math::
   :label: 10_eq_12
	
   \text{ Line Regulation } = 100 \% \frac{ \Delta V_{ out } }{\Delta V_{ in } } = 100 \% \frac{ 0,93V }{ 1V } = 93 \%

**10.4.5 Vergleich der maximalen Eingangsspannung**

Als nächstes wird das Verhalten der Ausgangsspannung im Bezug auf eine steigende Eingangsspannung betrachtet. 

.. figure:: img/Experiment_10/Vin_steigt_Vergleich.png
   :name: 10_fig_11
   :align: center
	    
   Auswirkung einer steigenden Eingangsspannung im Vergleich mit TinaSpice simuliert [2]


Wie zuvor erwähnt, befindet sich die erste Schaltung erst ab einer Eingangsspannung von etwa :math:`4,075V` in dem
Sättigungsbereich. Hieraus kann man schließen, dass die Dropoutspannung bei mindestens :math:`1,075V` liegt um eine
Ausgangsspannung von :math:`3V` liefern zu können. Bis zu einer Eingangsspannung von etwa :math:`49V` steigt die
Ausgangsspannung leicht, bis etwa :math:`3,5V`. Sobald die :math:`49V` überschritten werden, steigt die Ausgangsspannung
linear an. Dies liegt an der Durchbruchspannung des P-MOS, die bei dem Modell bei :math:`45V` liegt. Dies bedeutet, dass
die Dropoutspannung zwischen :math:`1,075V` und :math:`45V` liegen kann.

Die 2. Schaltung befindet sich bei einer Eingangsspannung von :math:`4V` bis :math:`5V` im linearen Bereich. Zu erkennen
ist, dass bei einer Eingangsspannung von :math:`7V` bis :math:`19V` eine Ausgangsspannung von :math:`5,5V` konstant
gehalten werden kann. Ab :math:`19V` steigt die Ausgangsspannung und nährt sich den :math:`7V`.

Als Test haben wir die 2. Schaltung optimiert um eine konstante Spannung von :math:`3V` liefern zu können. Der
Widerstand :math:`R_{3}` musste hierfür auf :math:`335k\Omega` gestellt werden. Jedoch muss hierfür eine
Eingangsspannung von mindestens :math:`4,6V` anliegen und darf die :math:`10V` nicht überschreiten. Ebenfalls nährt sich
die Spannung beim Überschreiten den :math:`7V`.

**10.4.6 Bestimmung des Ausgangswiderstands**

Als letzten Punkt wird die Impedanz der Schaltungen betrachtet. Dieser berechnet sich aus dem Kurzschlussstrom und der
Klemmenspannung :math:`(3V)` 

.. figure:: img/Experiment_10/Kurzschlussstromvergleich.png
   :name: 10_fig_12
   :align: center
	    
   Bestimmung der Ausgangswiderstände mit TinaSpice simuliert [2]


Für die erste Schaltung ist zu erkennen, dass der Strom begrenzt ist und maximal :math:`10mA` beträgt. Dieser wird durch
den P-MOS begrenzt. Mit steigendem Lastwiderstand sinkt der Strom ab. :math:`R_{i}` wird wie folgt bestimmt: 

.. math::
   :label: 10_eq_13
	
   R_{ i } = \frac{ U_{ 0 } }{ I_{ k } } = \frac{ 3V }{ 10,13mA }

Bei der zweiten Schaltung ist ersichtlich, dass der Kurzschlussstrom bei bis zu mehreren kA liegen kann. Daher sollte
dieser nicht in der Praxis gemessen werden! In der Simulation liegt der Kurzschlussstrom bei etwa :math:`42,76kA`. Es
befindet sich in dieser Schaltung keine Schutzeinrichtung. So bestimmt sich aus der Berechnung eine Impedanz von: 

.. math::
   :label: 10_eq_14
	
   R_{ i } = \frac{ U_{ 0 } }{ I_{ k } } = \frac{ 2,99V }{ 42,76kA }


Lösungsansätze
--------------

Kurze Beschreibung des Problems: Nach Aufbau der gegebenen Schaltung (Versuchsbeschreibung) erfolgte nicht die
gewünschte Stabilisierung der Spannung. Die Messungen der einzelnen Teilspannungen der Bauteile waren plausibel und wie
erwartet. Bei der Messung der Gesamtschaltung ergaben die Messungen keinen nachvollziehbaren Sinn und waren unseres
Erachtens völlig wahllos. 

*Zur Behebung dieses Problems wurden folgende Schritte unternommen:*

+------------------------------------------------------+---------------+
| Ansatz           				       | Erfolgreich   | 
+======================================================+===============+
| Mehrfacher Neuaufbau der Schaltung    	       | nein          | 
+------------------------------------------------------+---------------+
| Überprüfen ob die Schaltung richtig aufgebaut ist    | nein          | 
+------------------------------------------------------+---------------+
| Mehrfacher Neuaufbau der Schaltung    	       | nein          | 
+------------------------------------------------------+---------------+
| Überprüfen ob die Schaltung richtig aufgebaut ist    | nein          | 
+------------------------------------------------------+---------------+
| Mehrfacher Neuaufbau der Schaltung    	       | nein          | 
+------------------------------------------------------+---------------+
| Überprüfen ob die Schaltung richtig aufgebaut ist    | nein          | 
+------------------------------------------------------+---------------+
| Mehrfacher Neuaufbau der Schaltung    	       | nein          | 
+------------------------------------------------------+---------------+
| Überprüfen ob die Schaltung richtig aufgebaut ist    | nein          | 
+------------------------------------------------------+---------------+

**Schlussfolgerung:**

Nachdem alle Ansätze mehrfach ohne Erfolg ausprobiert wurden, wurde eine Drittmeinung eingeholt. Mit Hilfe des
Laboringenieures und dem betreuenden Professor konnte allerdings dennoch kein Erfolg erzielt werden. 

**Mögliche Optimierungen die man durchführen kann:**

Einen Glättungskondensator vor und nach dem LDO einbauen um eine bessere Stabilisierung zu erreichen. Denn die
Wechselspannungsanteile werden herausgefiltert.

Eine weitere Möglichkeit Fehlerquellen zu minimieren wäre, wenn man eine Platine anfertigt, die dafür ausgelegt ist den
LDO zu realisieren. Somit wären die Verbindungsleitungen so kurz wie möglich. Unseres Erachtens waren die Leitungen, mit
denen die Bauteile verbunden wurden, die größte Fehlerquelle. 


*******
Quellen
*******

[1] aslk-pro-manual-v103-Experiment 10

[2] Messungen mit dem Programm TinaSpice [Selbst Erstellt, Gruppe 10]

[3] https://www.mouser.de/new/stmicroelectronics/stm-ldo-regulators/  [Stand: 30.03.2020 20:22 Uhr]
