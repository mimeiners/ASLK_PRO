clear all
close all
clc

%% Einlesen der Rohdaten
step_in = fopen('stepresponse_Integrator.txt','r');
heading_step_in = textscan(step_in,'%s %s %s',1);
fgetl(step_in);
data1 = textscan(step_in,'%n %n %n');
fclose(step_in);

square_in = fopen('Response_square_Integrator.txt','r');
heading_sq_in = textscan(square_in,'%s %s %s',1);
fgetl(square_in);
data2 = textscan(square_in,'%n %n %n');
fclose(square_in); 

square_di = fopen('Response_square_Differentiator.txt','r');
heading_sq_di = textscan(square_di,'%s %s %s',1);
fgetl(square_di);
data3 = textscan(square_di,'%n %n %n');
fclose(square_di); 

tri_di = fopen('Response_Triangular_Differentiator.txt','r');
heading_tri_di = textscan(tri_di,'%s %s %s',1);
fgetl(tri_di);
data4 = textscan(tri_di,'%n %n %n');
fclose(tri_di); 

%% anlegen der Vektoren
time_step = cell2mat(data1(1)).*1e3;
in_step = cell2mat(data1(2));
out_step = cell2mat(data1(3));

time_sq_in = cell2mat(data2(1)).*1e3;
in_sq = cell2mat(data2(2));
out_sq = cell2mat(data2(3));

time_sq_di = cell2mat(data3(1)).*1e3;
in_sq_di = cell2mat(data3(2));
out_sq_di = cell2mat(data3(3));

time_tri_di = cell2mat(data4(1)).*1e3;
in_tri = cell2mat(data4(2));
out_tri = cell2mat(data4(3));

%% plot der Simulationen
figure(1)
hold all
plot(time_step, in_step)
plot(time_step, out_step)
title('Sprungantwort Integrator')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
grid;

figure(2)
hold all
plot(time_sq_in, in_sq)
plot(time_sq_in, out_sq)
title('Rechtecksignal Integrator')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
grid;

figure(3)
hold all
p = plot(time_sq_di, in_sq_di)
plot(time_sq_di, out_sq_di);
title('Rechtecksignal Differentiator')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;

figure(4)
hold all
p = plot(time_tri_di, in_tri)
plot(time_tri_di, out_tri)
title('Dreiecksignal Differentiator')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;


