clear all 
close all
clc

%% Einlesen der Rohdaten
a_kipp = fopen('astabile_Kippstufe.txt','r');
heading_akipp = textscan(a_kipp, '%s %s %s', 1);
fgetl(a_kipp);
data_1 = textscan(a_kipp, '%n %n %n');
fclose(a_kipp);

%% Anlegen der Matrizen
time = flipud(cell2mat(data_1(1)));
Vc = cell2mat(data_1(2));
Vo = cell2mat(data_1(3));

fehler = abs(time)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time = (fehler .* time);

%% Plot der Ergebnisse
figure(1)
hold all
plot(time, Vc)
plot(time,Vo)
title('Astabile Kippstufe Messung f = 1,5kHz')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_c','Spannung V_0')
xlim([0 5.5])
grid;