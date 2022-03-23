clear all
close all
clc


%% Parameter f�r die �bertragungsfunktion 
% (w1 und w2 k�nnen beim open-loop gain vernachl�ssigt werden)
% Ja, das stimmt, aber hier geht es um closed-loop.
A0 = 1e4;
f_un = 3e6;
f_3_db = f_un/A0;
wd1 = 2*pi*f_3_db;
wd2 = 2*pi*4e6;
GB = A0*wd1;
w0 = sqrt(GB*wd2);

%% Formel f�r den G�te Faktor 
Q = 1/((sqrt(wd2/GB)) + ((1/A0)*(sqrt(GB/wd2))));

%% Z�hler und Nennerpolynom der �bertragungsfunktion
num = 1;
%% Zaehler war falsch sortiert und Zeilenvektor.
den = [1/wd1^2 1/(w0*Q) 1];
%        s^2      s     1 

%% Plot der Ergebnisse
f = logspace(1,6);
w = 2*pi*f;
freqs(num, den, w);