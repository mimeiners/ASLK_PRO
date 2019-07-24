Experiment 6: Voltage controlled oscillator (VCO)
=====================================================


Theorie und Motivation
----------------------
Voltage controlled oscillator sind Schaltungen, die die Frequenz der Ausgangsspannung in Abhängigkeit der Eingangsspannung ändern. Bekannt ist auch die Wirkung als Funktionsgenerator mit einem Rechtecksignal am Ausgang.
In der Praxis kann die Schaltung in der elektronischen Musik als Synthesizer, bei Motorregelungen, als Funktionsgenerator und beim  Sendersuchlauf in Verbindung mit PLL genutzt werden.

Ein VCO kann mit Hilfe eines Multiplizierers, eine Integrierers und eines nicht invertierenden Schmitt-Triggers realisiert werden.
Als erstes wird das Schmitt-Trigger-Glied versuchstechnisch genauer unter die Lupe genommen. Dazu ändert sich der Rückführungswiderstand und die Wirkungsweise wird analysiert in Abhängigkeit eines Sinus-Signals. Dafür liegt eine Spice-Simulation vor, die anschließend messtechnisch aufgenommen wird. Anschließend werden die simulierten Werte mit den Gemessenen unter Zuhilfenahme von Matlab verglichen.

Als zweiten Versuch wird die gesamte VCO-Schaltung untersucht. Die Eingangsgleichspannung wird von 1V bis 10V variiert und die Ausgangsspannung gemessen. Ein Matlabprogramm legt nun beide Ausgangskurven eingerückt übereinander und setzt sie in Verbindung mit der Eingangsspannung. Für einen gleichmäßigen High- und Low-Pegel muss eine kleine Anpassschaltung das Ausgangssignal leicht manipulieren. Die Veränderung dieser Anpassschaltung wird mit der Frequenz der Ausgangsspannung in einen Grafen und mit der Eingangsspannung in einen anderen Grafen aufgetragen.



Spezifikation
-------------

Schaltungsaufbau Schmitt-Trigger
-------------------------------
Der Schmitt Trigger besteht in diesem Fall aus 3 Bauelementen:
- 2 Widerstände
- Operationsverstärker

Die Abbildung zeigt den Aufbau eines nicht invertierenden Schmitt-Triggers mit einer Versorgungsspannung des Operationsverstärkers von +/-10 V. Die Schaltung arbeitet wie ein Komparator, bei dem der Ein- und Ausschaltpegel nicht den selben Wert haben. Das heißt eine Schalthysterese des Komparators wird erzielt. Ausschaltpegel :math:`U_{e, aus}` beziehungsweise Einschaltpegel :math:`U_{e, ein}` lassen sich berechnen und als Schalthysterese :math:`\Delta U_{e}` zusammenfassen. Es lassen sich also gut analoge Signale in digitale Signale umwandeln. Für den Versuch wird der Schmitt-Trigger eingangsseitig mit einer Sinus-Wechelspannung (4 V Amplitude) gespeist. 


.. role:: raw-math(raw)
    :format: latex html

:raw-math:`$$ U_{e, aus}=-\frac{R_1}{R_2}U_{a, max} $$`
:raw-math:`$$ U_{e, ein}=-\frac{R_1}{R_2}U_{a, min} $$`
:raw-math:`$$ \Delta U_{e}=\frac{R_1}{R_2}(U_{a, max}-U_{a, min}) $$`
	  



.. figure:: img/Experiment_06/Voltage_Controlled_Oscillator_Schaltplan_Schmitt_Trigger.png
	    :name:  06_fig_01
	    :align: center
	    :scale: 30%

	    Schmitt Trigger Schaltplan

	    
.. figure:: img/Experiment_06/Schmitt_Trigger_Titze_Kennlinie.png
	    :name:  06_fig_02
	    :align: center
	    :scale: 30%

	    Schmitt Trigger Hysteresekurve, Tietze/Schenk

	    
Schaltungsaufbau VCO
-------------------------------
Der VCO besteht aus 3 wichtige Komponenten:
- Multiplizierer
- Integrierer
- Schmitt-Trigger
Als Anpassungsschaltung dient hier eine kleine Dioden-Widerstand-Schaltung. Versorgt werden die Operationsverstärker sowie der Multiplizierer mit +/-10V. Eingangsseitig sorgt ein Gleichsignal mit verschiedenen Spannungsleveln von 1-10 V für eine beispielhafte Beschaltung.

Für den  Multiplizierer (hier: MPY 634) lässt sich das Ausgangssignal berechnen. X1/ X2 stellen dabei Eingang 1, Y1/ Y2 Eingang 2 dar. Über SF lässt sich der Skalierungsfaktor steuern und  an VS gehört die Versorgungsspannung. Z1 wird meist gegen Ground oder sehr hochohmig angeschlossen, Z2 erlaubt einen Offset am Ausgang. 

:raw-math:`$$ V_{out} = A \cdot \frac{(X1-X2)(Y1-Y2)}{SF}(Z1-Z2) $$`
  

.. figure:: img/Experiment_06/Voltage_Controlled_Oscillator_Schaltplan.png
	    :name:  06_fig_03
	    :align: center
	    :scale: 50%

	    VCO Schaltplan
	    

Schmitt-Trigger Messung und Auswertung
-------------------------------
fwefwefew


VCO Messung und Auswertung
-------------------------------
fwefwefew


Fazit
-----

cceferfrefre


