clear all 
close all
clc

%% Einlesen der Rohdaten
a_kipp = fopen('monostabile_kippstufe.txt','r');
heading_akipp = textscan(a_kipp, '%s %s %s', 1);
fgetl(a_kipp);
data_1 = textscan(a_kipp, '%n %n %n');
fclose(a_kipp);

%% Anlegen der Matrizen
time = flipud(cell2mat(data_1(1)));
Vtr = cell2mat(data_1(2));
Vc = cell2mat(data_1(3));

fehler = abs(time)>100;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time = (fehler .* time);

%% Plot der Messergebnisse
figure(1)
hold all
plot(time, Vtr)
plot(time, Vc)
title('Monostabile Kippstufe Messung \tau = 4ms')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_{tr}','Spannung V_c')
legend('Location','northwest')
xlim([0 105])
grid;