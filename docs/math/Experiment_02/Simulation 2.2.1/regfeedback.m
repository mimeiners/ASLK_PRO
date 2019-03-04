clear all
close all
clc

%%Einlesen der Rohdaten
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

%% Anlegen der Vektoren
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


%%Plot der Ergebnisse
figure(1)
subplot(311)
hold all
plot(in_1, out_1)
plot(in_2, out_2)
legend('DCsweep 2,5V bis -2,5V','DCsweep -2,5V bis 2,5V')
legend('Location','northwest') 
title('Non-inverting Schmitt Trigger Simulation R1 = 470\Omega')
ylabel('Ausgangsspannung')
xlabel('Eingangsspannung')
grid;
subplot(312)
hold all
plot(in_3, out_3)
plot(in_4, out_4)
legend('DCsweep 2,5V bis -2,5V','DCsweep -2,5V bis 2,5V')
legend('Location','northwest') 
title('Non-inverting Schmitt Trigger Simulation R1 = 1000\Omega')
ylabel('Ausgangsspannung')
xlabel('Eingangsspannung')
grid;
subplot(313)
hold all
plot(in_5, out_5)
plot(in_6, out_6)
legend('DCsweep 2,5V bis -2,5V','DCsweep -2,5V bis 2,5V')
legend('Location','northwest') 
title('Non-inverting Schmitt Trigger Simulation R1 = 2200\Omega')
ylabel('Ausgangsspannung')
xlabel('Eingangsspannung')
grid;