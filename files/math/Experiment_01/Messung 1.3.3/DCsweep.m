clear all
close all
clc

%% einlesen der raw-data
sys = dlmread('DCsweep.csv'); % Spalteninformationen: Eingangsspannung, Ausgangsspannung

%% plot der Ergebnisse
figure(2)
plot(sys(:,1),sys(:,2))
title('DC Übertragungsverhalten')
xlabel('Eingangsspannung')
ylabel('Ausgangsspannung')
ax = gca;                   % Systemobjekt anlegen
ax.YAxisLocation = 'origin' % y-achse in den Ursprung legen
ax.XAxisLocation = 'origin' % x-achse in den Ursprung legen
grid;