clear all
close all
clc

%% Einlesen der Rohdaten
step_in = fopen('step_integrator.txt','r');
heading_step_in = textscan(step_in,'%s %s',1);
fgetl(step_in);
data1 = textscan(step_in,'%n %n');
fclose(step_in);

square_in = fopen('squarewave_integrator.txt','r');
heading_sq_in = textscan(square_in,'%s %s %s %s',1);
fgetl(square_in);
data2 = textscan(square_in,'%n %n %n %n');
fclose(square_in); 

square_di = fopen('squarewave_differentiator.txt','r');
heading_sq_di = textscan(square_di,'%s %s %s %s',1);
fgetl(square_di);
data3 = textscan(square_di,'%n %n %n %n');
fclose(square_di); 

tri_di = fopen('triangular_differentiator.txt','r');
heading_tri_di = textscan(tri_di,'%s %s %s %s',1);
fgetl(tri_di);
data4 = textscan(tri_di,'%n %n %n %n');
fclose(tri_di);

%% anlegen der Vektoren
t_step = (0:14/16382:14);
in_step = cell2mat(data1(1)).*10;
out_step = cell2mat(data1(2)).*10;

time_sq_in = cell2mat(data2(1));
in_sq = cell2mat(data2(2)).*2;
out_sq = cell2mat(data2(3)).*2;

fehler = abs(time_sq_in)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_sq_in = flipud(fehler .* time_sq_in);

time_sq_di = cell2mat(data3(1));
in_sq_di = flipud(cell2mat(data3(2)).*2);
out_sq_di = flipud(cell2mat(data3(3)).*2);

fehler = abs(time_sq_di)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_sq_di = flipud(fehler .* time_sq_di);
null = find(time_sq_di >= 0);
time_sq_di = time_sq_di(null);
in_sq_di = flipud(in_sq_di(null));
out_sq_di = flipud(out_sq_di(null));

time_tri_di = cell2mat(data4(1));
in_tri = cell2mat(data4(2)).*2;
out_tri = cell2mat(data4(3)).*2;

fehler = abs(time_tri_di)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_tri_di = flipud(fehler .* time_tri_di);
null_1 = find(time_tri_di >= 0);
time_tri_di = time_tri_di(null_1);
in_tri = in_tri(null_1);
out_tri = out_tri(null_1);

%% plot der Simulationen
figure(1)
hold all
plot(t_step, in_step)
plot(t_step, out_step)
title('Sprungantwort Integrator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
grid;

figure(2)
hold all
plot(time_sq_in, in_sq)
plot(time_sq_in, out_sq)
title('Rechtecksignal Integrator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
grid;

figure(3)
hold all
p = plot(time_sq_di, in_sq_di)
plot(time_sq_di, out_sq_di);
title('Rechtecksignal Differentiator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;

figure(4)
hold all
p = plot(time_tri_di, in_tri)
plot(time_tri_di, out_tri)
title('Dreiecksignal Differentiator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;