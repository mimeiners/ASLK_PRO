clear all 
close all
clc

%% Einlesen der Rohdaten
m_kipp = fopen('monostabile_kippstufe_simulation.txt','r');
heading_inv_R500 = textscan(m_kipp,'%s %s %s',1);
fgetl(m_kipp);
data_1 = textscan(m_kipp,'%n %n %n');
fclose(m_kipp);

a_kipp_m = fopen('monostabile_kippstufe_messung.txt','r');
heading_akipp_m = textscan(a_kipp_m, '%s %s %s', 1);
fgetl(a_kipp_m);
data_2 = textscan(a_kipp_m, '%n %n %n');
fclose(a_kipp_m);

%% Anlegen der Matrizen
time = cell2mat(data_1(1)).*1e3;
Vtr = cell2mat(data_1(2));
Vc = cell2mat(data_1(3));

time_m = flipud(cell2mat(data_2(1)));
Vtr_m = cell2mat(data_2(2));
Vc_m = cell2mat(data_2(3));

fehler = abs(time_m)>100;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_m = (fehler .* time_m);

%% Plot der Simulationsergebnisse
figure(1)
subplot(121)
hold all
plot(time_m, Vtr_m)
plot(time_m, Vc_m)
title('Monostabile Kippstufe Messung \tau = 4ms')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_{tr}','Spannung V_c')
xlim([0 105])
ylim([-4 4])
grid;
subplot(122)
hold all
plot(time, Vtr)
plot(time,Vc)
title('Monostabile Kippstufe Simulation \tau = 4ms')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_{tr}','Spannung V_c')
xlim([0 105])
ylim([-4 4])
grid;