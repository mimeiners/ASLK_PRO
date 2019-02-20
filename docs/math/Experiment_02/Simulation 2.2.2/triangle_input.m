clear all 
close all
clc

%% Einlesen der Rohdaten

inv_R500 = fopen('triangle_input_inv_R500.txt','r');
heading_inv_R500 = textscan(inv_R500,'%s %s %s',1);
fgetl(inv_R500);
data_1 = textscan(inv_R500,'%n %n %n');
fclose(inv_R500); 

inv_R2500 = fopen('triangle_input_inv_R2500.txt','r');
heading_inv_R2500 = textscan(inv_R2500,'%s %s %s',1);
fgetl(inv_R2500);
data_2 = textscan(inv_R2500,'%n %n %n');
fclose(inv_R2500); 

noninv_R500 = fopen('triangle_input_noninv_R500.txt','r');
heading_noninv_R500 = textscan(noninv_R500,'%s %s %s',1);
fgetl(noninv_R500);
data_3 = textscan(noninv_R500,'%n %n %n');
fclose(noninv_R500); 

noninv_R2500 = fopen('triangle_input_noninv_R2500.txt','r');
heading_noninv_R2500 = textscan(noninv_R2500,'%s %s %s',1);
fgetl(noninv_R2500);
data_4 = textscan(noninv_R2500,'%n %n %n');
fclose(noninv_R2500); 

%% Anlegen der Matrizen
time_inv_R500 = cell2mat(data_1(1)).*1e3;
V_in_inv_R500 = cell2mat(data_1(2));
V_out_inv_R500 = cell2mat(data_1(3));

time_inv_R2500 = cell2mat(data_2(1)).*1e3;
V_in_inv_R2500 = cell2mat(data_2(2));
V_out_inv_R2500 = cell2mat(data_2(3));

time_noninv_R500 = cell2mat(data_3(1)).*1e3;
V_in_noninv_R500 = cell2mat(data_3(2));
V_out_noninv_R500 = cell2mat(data_3(3));

time_noninv_R2500 = cell2mat(data_4(1)).*1e3;
V_in_noninv_R2500 = cell2mat(data_4(2));
V_out_noninv_R2500 = cell2mat(data_4(3));

%% Plot der Ergebnisse

figure(1)
subplot(221)
hold all
plot(time_inv_R500, V_in_inv_R500)
plot(time_inv_R500, V_out_inv_R500)
title('Invertiernder Schmitt Trigger R1 = 500\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;

figure(1)
subplot(223)
hold all
plot(time_inv_R2500(1:487), V_in_inv_R2500(1:487))
plot(time_inv_R2500(1:487), V_out_inv_R2500)
title('Invertiernder Schmitt Trigger R1 = 2500\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;

figure(1)
subplot(222)
hold all
plot(time_noninv_R500, V_in_noninv_R500)
plot(time_noninv_R500, V_out_noninv_R500)
title('Nicht Invertiernder Schmitt Trigger R1 = 500\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;

figure(1)
subplot(224)
hold all
plot(time_noninv_R2500, V_in_noninv_R2500)
plot(time_noninv_R2500, V_out_noninv_R2500)
title('Nicht Invertiernder Schmitt Trigger R1 = 2500\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
xlim([0 7])
grid;



