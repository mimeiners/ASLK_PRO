clear all
close all
clc

%% Einlesen der Rohdaten
square_in_1V = fopen('Response_square_Integrator_1V.txt','r');
heading_sq_in_1V = textscan(square_in_1V,'%s %s %s',1);
fgetl(square_in_1V);
data1 = textscan(square_in_1V,'%n %n %n');
fclose(square_in_1V);

square_in_2V = fopen('Response_square_Integrator_2V.txt','r');
heading_sq_in_2V = textscan(square_in_2V,'%s %s %s',1);
fgetl(square_in_2V);
data2 = textscan(square_in_2V,'%n %n %n');
fclose(square_in_2V); 

square_in_3V = fopen('Response_square_Integrator_3V.txt','r');
heading_sq_in_3V = textscan(square_in_3V,'%s %s %s',1);
fgetl(square_in_3V);
data3 = textscan(square_in_3V,'%n %n %n');
fclose(square_in_3V);

%% Anlegen der Vektoren
time_sq_in_1V = cell2mat(data1(1)).*1e3;
in_sq_1V = cell2mat(data1(2));
out_sq_1V = cell2mat(data1(3));

time_sq_in_2V = cell2mat(data2(1)).*1e3;
in_sq_2V = cell2mat(data2(2));
out_sq_2V = cell2mat(data2(3));

time_sq_in_3V = cell2mat(data3(1)).*1e3;
in_sq_3V = cell2mat(data3(2));
out_sq_3V = cell2mat(data3(3));

%% Plot der Simulationen

figure(1)
subplot(311)
hold all
plot(time_sq_in_1V, in_sq_1V)
plot(time_sq_in_1V, out_sq_1V)
title('Rechtecksignal Integrator V_{in} = 1V_p')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
grid;
subplot(312)
hold all
plot(time_sq_in_2V, in_sq_2V)
plot(time_sq_in_2V, out_sq_2V)
title('Rechtecksignal Integrator V_{in} = 2V_p')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
grid;
subplot(313)
hold all
plot(time_sq_in_3V, in_sq_3V)
plot(time_sq_in_3V, out_sq_3V)
title('Rechtecksignal Integrator V_{in} = 3V_p')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','east')
grid;



