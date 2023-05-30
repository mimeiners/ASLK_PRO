clear all
close all
clc

%% Einlesen der Rohdaten 

R470_1 = fopen('-1V_1V_R470.txt','r');
heading_R470_1 = textscan(R470_1,'%s %s %s',1);
fgetl(R470_1);
data1 = textscan(R470_1,'%n %n %n');
fclose(R470_1);

R470_2 = fopen('1V_-1V_R470.txt','r');
heading_R470_2 = textscan(R470_2,'%s %s %s',1);
fgetl(R470_2);
data2 = textscan(R470_2,'%n %n %n');
fclose(R470_2); 

R1k_1 = fopen('-1,6V_1,6V_R1k.txt','r');
heading_R1k = textscan(R1k_1,'%s %s %s',1);
fgetl(R1k_1);
data3 = textscan(R1k_1,'%n %n %n');
fclose(R1k_1);

R1k_2 = fopen('1,6V_-1,6V_R1k.txt','r');
heading_R1_1k_2 = textscan(R1k_2,'%s %s %s',1);
fgetl(R1k_2);
data4 = textscan(R1k_2,'%n %n %n');
fclose(R1k_2); 

R2200_1 = fopen('-2,6V_2,6V_R2200.txt','r');
heading_R2200 = textscan(R2200_1,'%s %s %s',1);
fgetl(R2200_1);
data5 = textscan(R2200_1,'%n %n %n');
fclose(R2200_1);

R2200_2 = fopen('2,6V_-2,6V_R2200.txt','r');
heading_R2200_2 = textscan(R2200_2,'%s %s %s',1);
fgetl(R2200_2);
data6 = textscan(R2200_2,'%n %n %n');
fclose(R2200_2); 

%% Anlegen der Vektoren
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

%% Plot der Messungen
figure(1)
subplot(311)
hold on
plot(in_R470_m_1, out_R470_1)
plot(in_R470_m_2, out_R470_2)
title('Non Inveting Schmitt-Trigger Messung R1 = 470\Omega')
xlabel('Eingangsspannung in V')
ylabel('Ausgangsspannung in V')
legend('-1V bis 1V Input','1V bis -1V Input')
ylim([-10 10])
xlim([-2.7 2.7])
grid;

subplot(312)
hold on
plot(in_R1k_m_1, out_R1k_1)
plot(in_R1k_m_2, out_R1k_2)
title('Non Inveting Schmitt-Trigger Messung R1 = 1000\Omega')
xlabel('Eingangsspannung in V')
ylabel('Ausgangsspannung in V')
legend('-1,6V bis 1,6V Input','1,6V bis -1,6V Input')
ylim([-10 10])
xlim([-2.7 2.7])
grid;

subplot(313)
hold on
plot(in_R2200_m_1, out_R2200_1)
plot(in_R2200_m_2, out_R2200_2)
title('Non Inveting Schmitt-Trigger Messung R1 = 2200\Omega')
xlabel('Eingangsspannung in V')
ylabel('Ausgangsspannung in V')
legend('-2,6V bis 2,6V Input','2,6V bis -2,6V Input')
legend('Location','southeast')
ylim([-10 10])
xlim([-2.7 2.7])
grid;

