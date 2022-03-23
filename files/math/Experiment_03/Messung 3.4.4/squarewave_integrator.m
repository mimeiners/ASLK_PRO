clear all
close all
clc

%% Einlesen der Rohdaten
square_in_1V = fopen('squarewave_integrator_1V.txt','r');
heading_sq_in_1V = textscan(square_in_1V,'%s %s %s %s',1);
fgetl(square_in_1V);
data1 = textscan(square_in_1V,'%n %n %n %n');
fclose(square_in_1V);

square_in_2V = fopen('squarewave_integrator_2V.txt','r');
heading_sq_in_2V = textscan(square_in_2V,'%s %s %s %s',1);
fgetl(square_in_2V);
data2 = textscan(square_in_2V,'%n %n %n %n');
fclose(square_in_2V); 

square_in_3V = fopen('squarewave_integrator_3V.txt','r');
heading_sq_in_3V = textscan(square_in_3V,'%s %s %s %s',1);
fgetl(square_in_3V);
data3 = textscan(square_in_3V,'%n %n %n %n');
fclose(square_in_3V);


%% Anlegen der Vektoren
time_sq_in_1V = cell2mat(data1(1)).*1e-3;
in_sq_1V = cell2mat(data1(2))*2;
out_sq_1V = cell2mat(data1(3))*2;

time_sq_in_2V = cell2mat(data2(1)).*1e-3;
in_sq_2V = cell2mat(data2(2))*2;
out_sq_2V = cell2mat(data2(3))*2;

time_sq_in_3V = cell2mat(data3(1)).*1e-3;
in_sq_3V = cell2mat(data3(2))*2;
out_sq_3V = cell2mat(data3(3))*2;

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
ylim([-4 10])
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
ylim([-4 10])
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
