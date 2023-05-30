clear all
close all
clc

%% Einlesen der Simulationsdaten
% Widerstände R1 = 500ohm ; R2 = 10kohm
R_470_1 = fopen('regfeedback_R_470_1.txt','r');
heading_R_470_1 = textscan(R_470_1,'%s %s',1);
fgetl(R_470_1);
data_1 = textscan(R_470_1,'%n %n %n');
fclose(R_470_1);
R_470_2 = fopen('regfeedback_R_470_2.txt','r');
heading_R_470_2 = textscan(R_470_2,'%s %s',1);
fgetl(R_470_2);
data_2 = textscan(R_470_2,'%n %n');
fclose(R_470_2);

% Widerstände R1 = 1500ohm ; R2 = 10kohm
R_1000_1 = fopen('regfeedback_R_1000_1.txt','r');
heading_R_1000_1 = textscan(R_1000_1,'%s %s',1);
fgetl(R_1000_1);
data_3 = textscan(R_1000_1,'%n %n %n');
fclose(R_1000_1);
R_1000_2 = fopen('regfeedback_R_1000_2.txt','r');
heading_R_1000_2 = textscan(R_1000_2,'%s %s',1);
fgetl(R_1000_2);
data_4 = textscan(R_1000_2,'%n %n');
fclose(R_1000_2); 

% Widerstände R1 = 2500ohm ; R2 = 10kohm
R_2200_1 = fopen('regfeedback_R_2200_1.txt','r');
heading_R_2200_1 = textscan(R_2200_1,'%s %s',1);
fgetl(R_2200_1);
data_5 = textscan(R_2200_1,'%n %n %n');
fclose(R_2200_1);
R_2200_2 = fopen('regfeedback_R_2200_2.txt','r');
heading_R_2200_2 = textscan(R_2200_2,'%s %s',1);
fgetl(R_2200_2);
data_6 = textscan(R_2200_2,'%n %n');
fclose(R_2200_2);

%% Einlesen der Messdaten
R470_1 = fopen('-1V_1V_R470_messung.txt','r');
heading_R470_1 = textscan(R470_1,'%s %s %s',1);
fgetl(R470_1);
data1 = textscan(R470_1,'%n %n %n');
fclose(R470_1);

R470_2 = fopen('1V_-1V_R470_messung.txt','r');
heading_R470_2 = textscan(R470_2,'%s %s %s',1);
fgetl(R470_2);
data2 = textscan(R470_2,'%n %n %n');
fclose(R470_2); 

R1k_1 = fopen('-1,6V_1,6V_R1k_messung.txt','r');
heading_R1k = textscan(R1k_1,'%s %s %s',1);
fgetl(R1k_1);
data3 = textscan(R1k_1,'%n %n %n');
fclose(R1k_1);

R1k_2 = fopen('1,6V_-1,6V_R1k_messung.txt','r');
heading_R1_1k_2 = textscan(R1k_2,'%s %s %s',1);
fgetl(R1k_2);
data4 = textscan(R1k_2,'%n %n %n');
fclose(R1k_2); 

R2200_1 = fopen('-2,6V_2,6V_R2200_messung.txt','r');
heading_R2200 = textscan(R2200_1,'%s %s %s',1);
fgetl(R2200_1);
data5 = textscan(R2200_1,'%n %n %n');
fclose(R2200_1);

R2200_2 = fopen('2,6V_-2,6V_R2200_messung.txt','r');
heading_R2200_2 = textscan(R2200_2,'%s %s %s',1);
fgetl(R2200_2);
data6 = textscan(R2200_2,'%n %n %n');
fclose(R2200_2); 

%% Anlegen der Vektoren Simulation
in_1 = cell2mat(data_1(1));
out_1 = cell2mat(data_1(2));
in_2 = cell2mat(data_2(1));
out_2 = cell2mat(data_2(2));

in_3 = cell2mat(data_3(1));
out_3 = cell2mat(data_3(2));
in_4 = cell2mat(data_4(1));
out_4 = cell2mat(data_4(2));

in_5 = cell2mat(data_5(1));
out_5 = cell2mat(data_5(2));
in_6 = cell2mat(data_6(1));
out_6 = cell2mat(data_6(2));

%% Anlegen der Vektoren Messung
in_R470_1 = cell2mat(data1(1));
in_R470_m_1 = cell2mat(data1(2));
out_R470_1 = cell2mat(data1(3));

in_R470 = cell2mat(data2(1));
in_R470_m_2 = cell2mat(data2(2));
out_R470_2 = cell2mat(data2(3));

in_R1k_1 = cell2mat(data3(1));
in_R1k_m_1 = cell2mat(data3(2));
out_R1k_1 = cell2mat(data3(3));

in_R1k_2 = cell2mat(data4(1));
in_R1k_m_2 = cell2mat(data4(2));
out_R1k_2 = cell2mat(data4(3));

in_R2200_1 = cell2mat(data5(1));
in_R2200_m_1 = cell2mat(data5(2));
out_R2200_1 = cell2mat(data5(3));

in_R2200_2 = cell2mat(data6(1));
in_R2200_m_2 = cell2mat(data6(2));
out_R2200_2 = cell2mat(data6(3));

%% Plot der Ergebnisse
figure(1)
subplot(322)
hold all
plot(in_1, out_1)
plot(in_2, out_2)
legend('-2,5V bis 2,5V','2,5V bis -2,5V')
legend('Location','northwest') 
title('Non-inverting Schmitt Trigger Simulation R1 = 470\Omega')
ylabel('Ausgangsspannung')
xlabel('Eingangsspannung')
grid;

subplot(324)
hold all
plot(in_3, out_3)
plot(in_4, out_4)
legend('-2,5V bis 2,5V','2,5V bis -2,5V')
legend('Location','northwest') 
title('Non-inverting Schmitt Trigger Simulation R1 = 1000\Omega')
ylabel('Ausgangsspannung')
xlabel('Eingangsspannung')
grid;

subplot(326)
hold all
plot(in_5, out_5)
plot(in_6, out_6)
legend('-2,5V bis 2,5V','2,5V bis -2,5V')
legend('Location','northwest') 
title('Non-inverting Schmitt Trigger Simulation R1 = 2200\Omega')
ylabel('Ausgangsspannung')
xlabel('Eingangsspannung')
grid;

subplot(321)
hold all
plot(in_R470_m_1, out_R470_1)
plot(in_R470_m_2, out_R470_2)
title('Non-Inveting Schmitt-Trigger Messung R1 = 470\Omega')
xlabel('Eingangsspannung in V')
ylabel('Ausgangsspannung in V')
legend('-1V bis 1V Input','1V bis -1V Input')
legend('Location','northwest')
ylim([-10 10])
xlim([-2.7 2.7])
grid;

subplot(323)
hold all
plot(in_R1k_m_1, out_R1k_1)
plot(in_R1k_m_2, out_R1k_2)
title('Non-Inveting Schmitt-Trigger Messung R1 = 1000\Omega')
xlabel('Eingangsspannung in V')
ylabel('Ausgangsspannung in V')
legend('-1,6V bis 1,6V Input','1,6V bis -1,6V Input')
legend('Location','northwest')
ylim([-10 10])
xlim([-2.7 2.7])
grid;

subplot(325)
hold all
plot(in_R2200_m_1, out_R2200_1)
plot(in_R2200_m_2, out_R2200_2)
title('Non-Inveting Schmitt-Trigger Messung R1 = 2200\Omega')
xlabel('Eingangsspannung in V')
ylabel('Ausgangsspannung in V')
legend('-2,6V bis 2,6V Input','2,6V bis -2,6V Input')
legend('Location','southwest')
ylim([-10 10])
xlim([-2.7 2.7])
grid;
