clear all 
close all
clc

%% Einlesen der Rohdaten
a_kipp = fopen('astabile_kippstufe_simulation.txt','r');
heading_inv_R500 = textscan(a_kipp,'%s %s %s',1);
fgetl(a_kipp);
data_1 = textscan(a_kipp,'%n %n %n');
fclose(a_kipp);

a_kipp_m = fopen('astabile_kippstufe_messung.txt','r');
heading_akipp_m = textscan(a_kipp_m, '%s %s %s', 1);
fgetl(a_kipp_m);
data_2 = textscan(a_kipp_m, '%n %n %n');
fclose(a_kipp_m);

%% Anlegen der Matrizen
time = cell2mat(data_1(1)).*1e3;
Vc = cell2mat(data_1(2));
Vo = cell2mat(data_1(3));

time_m = cell2mat(data_2(1));

fehler = abs(time_m)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_m = flipud(fehler .* time_m);

Vc_m = cell2mat(data_2(2))*2;
Vo_m = cell2mat(data_2(3))*2;

%% Plot der Ergebnisse
figure(1)
subplot(121)
hold all
plot(time_m, Vc_m)
plot(time_m,Vo_m)
title('Astabile Kippstufe Messung f = 1,5kHz')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_c','Spannung V_0')
xlim([0 5.5])
ylim([-10 10])
grid;
subplot(122)
hold all
plot(time, Vo)
plot(time,Vc)
title('Astabile Kippstufe Simulation f = 1,5kHz')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_c','Spannung V_0')
grid;
