clear all 
close all
clc

%% Einlesen der Rohdaten
m_kipp = fopen('monostabile_kippstufe.txt','r');
heading_inv_R500 = textscan(m_kipp,'%s %s %s',1);
fgetl(m_kipp);
data_1 = textscan(m_kipp,'%n %n %n');
fclose(m_kipp); 

%% Anlegen der Matrizen
time = cell2mat(data_1(1)).*1e3;
Vtr = cell2mat(data_1(2));
Vc = cell2mat(data_1(3));

%% Plot der Simulationsergebnisse
figure(1)
hold all
plot(time, Vtr)
plot(time,Vc)
title('Monostabile Kippstufe \tau = 4ms')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('Spannung V_{tr}','Spannung V_c')
legend('Location','northwest')
xlim([0 105])
grid;