clear all
close all
clc

%% Einlesen der Rohdaten 

R1_1k = fopen('-1V_1V_R1_1k.txt','r');
heading_R1_1k = textscan(R1_1k,'%s %s %s',1);
fgetl(R1_1k);
data1 = textscan(R1_1k,'%n %n %n');
fclose(R1_1k);

R1_1k_2 = fopen('1V_-1V_R1_1k.txt','r');
heading_R1_1k_2 = textscan(R1_1k_2,'%s %s %s',1);
fgetl(R1_1k_2);
data2 = textscan(R1_1k_2,'%n %n %n');
fclose(R1_1k_2); 

%% Anlegen der Vektoren
eingang_1 = cell2mat(data1(1));
eingang_m_1 = cell2mat(data1(2));
ausgang_1 = cell2mat(data1(3));

eingang_2 = cell2mat(data2(1));
eingang_m_2 = cell2mat(data2(2));
ausgang_2 = cell2mat(data2(3));

%% Plot der Messungen
figure(1)
hold on
plot(eingang_1, ausgang_1)
plot(eingang_2, ausgang_2)
title('Non Inveting Schmitt-Trigger R1 = 1000\Omega')
xlabel('Eingangsspannung in V')
ylabel('Ausgangsspannung in V')
legend('-1V bis 1V Input','1V bis -1V Input')
ylim([-10 10])
grid;

