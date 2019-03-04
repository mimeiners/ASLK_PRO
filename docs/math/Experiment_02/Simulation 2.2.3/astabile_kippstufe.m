clear all 
close all
clc

%% Einlesen der Rohdaten
a_kipp = fopen('astabile_kippstufe.txt','r');
heading_inv_R500 = textscan(a_kipp,'%s %s %s',1);
fgetl(a_kipp);
data_1 = textscan(a_kipp,'%n %n %n');
fclose(a_kipp); 

%% Anlegen der Matrizen
time = cell2mat(data_1(1)).*1e3;
Vo = cell2mat(data_1(2));
Vc = cell2mat(data_1(3));

%% Plot der Ergebnisse
figure(1)
hold all
plot(time, Vo)
plot(time,Vc)
title('Astabile Kippstufe Simulation f = 1,5kHz')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_c','Spannung V_0')
grid;
