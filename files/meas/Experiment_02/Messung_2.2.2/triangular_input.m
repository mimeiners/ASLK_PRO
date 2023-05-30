clear all 
close all
clc

%% Einlesen der Rohdaten
non_R470 = fopen('non_R470.txt','r');
heading_non_R470 = textscan(non_R470,'%s %s %s',1);
fgetl(non_R470);
data_1 = textscan(non_R470,'%n %n %n');
fclose(non_R470); 

non_R4700 = fopen('non_R4700.txt','r');
heading_non_R4700 = textscan(non_R4700,'%s %s %s',1);
fgetl(non_R4700);
data_2 = textscan(non_R4700,'%n %n %n');
fclose(non_R4700);

inv_R470 = fopen('inv_R470.txt','r');
heading_inv_R470 = textscan(inv_R470,'%s %s %s',1);
fgetl(inv_R470);
data_3 = textscan(inv_R470,'%n %n %n');
fclose(inv_R470); 

inv_R4700 = fopen('inv_R4700.txt','r');
heading_inv_R4700 = textscan(inv_R4700,'%s %s %s',1);
fgetl(inv_R4700);
data_4 = textscan(inv_R4700,'%n %n %n');
fclose(inv_R4700);

%% Anlegen der Matrizen
time_non_R470 = flipud(cell2mat(data_1(1))).*1e-3;
V_in_non_R470 = cell2mat(data_1(2)).*2;     %(2x) weil 2V pro division
V_out_non_R470 = cell2mat(data_1(3)).*2;

fehler = abs(time_non_R470)>0.005;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_non_R470 = (fehler .* time_non_R470).*1e3;

time_non_R4700 = flipud(cell2mat(data_2(1))).*1e-3;
V_in_non_R4700 = cell2mat(data_2(2)).*2;
V_out_non_R4700 = cell2mat(data_2(3)).*2;

fehler1 = abs(time_non_R4700)>0.005;
fehler1 = fehler1.*1e-3;
fehler1(fehler1==0) = 1;
time_non_R4700 = (fehler1 .* time_non_R4700).*1e3;
 
time_inv_R470 = flipud(cell2mat(data_3(1))).*1e-3;
V_in_inv_R470 = cell2mat(data_3(2)).*2;     %(2x) weil 2V pro division
V_out_inv_R470 = cell2mat(data_3(3)).*2;

fehler = abs(time_inv_R470)>0.005;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_inv_R470 = (fehler .* time_inv_R470).*1e3;

time_inv_R4700 = flipud(cell2mat(data_4(1))).*1e-3;
V_in_inv_R4700 = cell2mat(data_4(2)).*2;
V_out_inv_R4700 = cell2mat(data_4(3)).*2;

fehler1 = abs(time_inv_R4700)>0.005;
fehler1 = fehler1.*1e-3;
fehler1(fehler1==0) = 1;
time_inv_R4700 = (fehler1 .* time_inv_R4700).*1e3;

%% Plot der Messungen
figure(1)
subplot(222)
hold all
plot(time_non_R470, V_in_non_R470)
plot(time_non_R470, V_out_non_R470)
title('Nicht-Invertiernder Schmitt Messung Trigger R1 = 470\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}','V_{out}')
legend('Location','northeast')
xlim([-0 6])
grid;

subplot(224)
hold all
plot(time_non_R4700, V_in_non_R4700)
plot(time_non_R4700, V_out_non_R4700)
title('Nicht-Invertiernder Schmitt Messung Trigger R1 = 4700\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}','V_{out}')
legend('Location','northeast')
xlim([-0 6])
grid;

subplot(221)
hold all
plot(time_inv_R470, V_in_inv_R470)
plot(time_inv_R470, V_out_inv_R470)
title('Invertiernder Schmitt Trigger Messung R1 = 470\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}','V_{out}')
legend('Location','northeast')
xlim([-0 6])
grid;

subplot(223)
hold all
plot(time_inv_R4700, V_in_inv_R4700)
plot(time_inv_R4700, V_out_inv_R4700)
title('Invertiernder Schmitt Trigger Messung R1 = 4700\Omega')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}','V_{out}')
legend('Location','northeast')
xlim([-0 6])
grid;