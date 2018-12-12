clear all
close all
clc

%% Parameter für die Übertragungsfunktion 
%(w1 und w2 können beim open loop gain vernachlässigt werden)
A0 = 10000;
w1 = 1;
w2 = 1;
GB = A0*w1;
w0 = 4000000;
%% Formel für den Güte Faktor 
Q = 1/((sqrt(w2/GB)) + ((1/A0)*(sqrt(GB/w2))));

%% Zähler und Nennerpolynom der Übertragungsfunktion
num = 1;
den = [1, 1/(w0*Q), 1/((w0)^2)];
%% Plot der Ergebnisse
freqs(num, den);
title('magnitude and phase response of an open loop amplifier')