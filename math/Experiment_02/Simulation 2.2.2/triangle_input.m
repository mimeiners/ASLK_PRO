clear all 
close all
clc

%% Einlesen der Rohdaten

inv_R470 = fopen('triangle_input_inv_R470.txt','r');
heading_inv_R470 = textscan(inv_R470,'%s %s %s',1);
fgetl(inv_R470);
data_1 = textscan(inv_R470,'%n %n %n');
fclose(inv_R470); 

inv_R4700 = fopen('triangle_input_inv_R4700.txt','r');
heading_inv_R4700 = textscan(inv_R4700,'%s %s %s',1);
fgetl(inv_R4700);
data_2 = textscan(inv_R4700,'%n %n %n');
fclose(inv_R4700); 

noninv_R470 = fopen('triangle_input_R470.txt','r');
heading_noninv_R470 = textscan(noninv_R470,'%s %s %s',1);
fgetl(noninv_R470);
data_3 = textscan(noninv_R470,'%n %n %n');
fclose(noninv_R470); 

noninv_R4700 = fopen('triangle_input_R4700.txt','r');
heading_noninv_R4700 = textscan(noninv_R4700,'%s %s %s',1);
fgetl(noninv_R4700);
data_4 = textscan(noninv_R4700,'%n %n %n');
fclose(noninv_R4700); 

%% Anlegen der Matrizen
time_inv_R470 = cell2mat(data_1(1)).*1e3;
V_in_inv_R470 = cell2mat(data_1(2));
V_out_inv_R470 = cell2mat(data_1(3));

time_inv_R4700 = cell2mat(data_2(1)).*1e3;
V_in_inv_R4700 = cell2mat(data_2(2));
V_out_inv_R4700 = cell2mat(data_2(3));

time_noninv_R470 = cell2mat(data_3(1)).*1e3;
V_in_noninv_R470 = cell2mat(data_3(2));
V_out_noninv_R470 = cell2mat(data_3(3));

time_noninv_R4700 = cell2mat(data_4(1)).*1e3;
V_in_noninv_R4700 = cell2mat(data_4(2));
V_out_noninv_R4700 = cell2mat(data_4(3));

%% Plot der Ergebnisse

figure(1)
subplot(221)
hold all
plot(time_inv_R470, V_in_inv_R470)
plot(time_inv_R470, V_out_inv_R470)
title('Invertiernder Schmitt Trigger Simulation R1 = 470\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;

figure(1)
subplot(223)
hold all
plot(time_inv_R4700, V_in_inv_R4700)
plot(time_inv_R4700(1:611), V_out_inv_R4700)
title('Invertiernder Schmitt Trigger Simulation R1 = 4700\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;

figure(1)
subplot(222)
hold all
plot(time_noninv_R470, V_in_noninv_R470)
plot(time_noninv_R470, V_out_noninv_R470)
title('Nicht Invertiernder Schmitt Trigger Simulation R1 = 470\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;

figure(1)
subplot(224)
hold all
plot(time_noninv_R4700, V_in_noninv_R4700)
plot(time_noninv_R4700(1:585), V_out_noninv_R4700)
title('Nicht Invertiernder Schmitt Trigger Simulation R1 = 4700\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;



