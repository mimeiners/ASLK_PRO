clear all
close all
clc

%% Einlesen der Simulationsdaten
step_in = fopen('step_integrator_simulation.txt','r');
heading_step_in = textscan(step_in,'%s %s %s',1);
fgetl(step_in);
data1 = textscan(step_in,'%n %n %n');
fclose(step_in);

square_in = fopen('squarewave_integrator_simulation.txt','r');
heading_sq_in = textscan(square_in,'%s %s %s',1);
fgetl(square_in);
data2 = textscan(square_in,'%n %n %n');
fclose(square_in); 

square_di = fopen('squarewave_differentiator_simulation.txt','r');
heading_sq_di = textscan(square_di,'%s %s %s',1);
fgetl(square_di);
data3 = textscan(square_di,'%n %n %n');
fclose(square_di); 

tri_di = fopen('triangular_differentiator_simulation.txt','r');
heading_tri_di = textscan(tri_di,'%s %s %s',1);
fgetl(tri_di);
data4 = textscan(tri_di,'%n %n %n');
fclose(tri_di);

%% Einlesen der Messdaten
step_in = fopen('step_integrator_messung.txt','r');
heading_step_in_m = textscan(step_in,'%s %s',1);
fgetl(step_in);
data5 = textscan(step_in,'%n %n');
fclose(step_in);

square_in = fopen('squarewave_integrator_messung.txt','r');
heading_sq_in_m = textscan(square_in,'%s %s %s %s',1);
fgetl(square_in);
data6 = textscan(square_in,'%n %n %n %n');
fclose(square_in); 

square_di = fopen('squarewave_differentiator_messung.txt','r');
heading_sq_di_m = textscan(square_di,'%s %s %s %s',1);
fgetl(square_di);
data7 = textscan(square_di,'%n %n %n %n');
fclose(square_di); 

tri_di = fopen('triangular_differentiator_messung.txt','r');
heading_tri_di_m = textscan(tri_di,'%s %s %s %s',1);
fgetl(tri_di);
data8 = textscan(tri_di,'%n %n %n %n');
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
out_sq_d = cell2mat(data3(3));

time_tri_di = cell2mat(data4(1)).*1e3;
in_tri = cell2mat(data4(2));
out_tri = cell2mat(data4(3));

%% Anlegen der Vektoren Messdaten
t_step_m = (0:14/16382:14);
in_step_m = cell2mat(data5(1)).*10;
out_step_m = cell2mat(data5(2)).*10;

time_sq_in_m = cell2mat(data6(1));
in_sq_m = cell2mat(data6(2)).*2;
out_sq_m = cell2mat(data6(3)).*2;

fehler = abs(time_sq_in_m)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_sq_in_m = flipud(fehler .* time_sq_in_m);

time_sq_di_m = cell2mat(data7(1));
in_sq_di_m = flipud(cell2mat(data7(2)).*2);
out_sq_d_m = flipud(cell2mat(data7(3)).*2);

fehler = abs(time_sq_di_m)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_sq_di_m = flipud(fehler .* time_sq_di_m);
null = find(time_sq_di_m >= 0);
time_sq_di_m = time_sq_di_m(null);
in_sq_di_m = flipud(in_sq_di_m(null));
out_sq_di_m = flipud(out_sq_d_m(null));

time_tri_di_m = cell2mat(data8(1));
in_tri_m = cell2mat(data8(2)).*2;
out_tri_m = cell2mat(data8(3)).*2;

fehler = abs(time_tri_di_m)>5;
fehler = fehler.*1e-3;
fehler(fehler==0) = 1;
time_tri_di_m = flipud(fehler .* time_tri_di_m);
null_1 = find(time_tri_di_m >= 0);
time_tri_di_m = time_tri_di_m(null_1);
in_tri_m = in_tri_m(null_1);
out_tri_m = out_tri_m(null_1);

%% plot der Simulationen
figure(1)
subplot(211)
hold all
plot(t_step_m, in_step_m)
plot(t_step_m, out_step_m)
title('Sprungantwort Integrator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
grid;
subplot(212)
hold all
plot(time_step, in_step)
plot(time_step, out_step)
title('Sprungantwort Integrator Simulation')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
grid;

figure(2)
subplot(211)
hold all
plot(time_sq_in_m, in_sq_m)
plot(time_sq_in_m, out_sq_m)
title('Rechtecksignal Integrator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','northwest')
xlim([0 6])
grid;
subplot(212)
hold all
plot(time_sq_in, in_sq)
plot(time_sq_in, out_sq)
title('Rechtecksignal Integrator Simulation')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
legend('Location','northwest')
xlim([0 6])
grid;

figure(3)
subplot(211)
hold all
p = plot(time_sq_di_m, in_sq_di_m);
plot(time_sq_di_m, out_sq_di_m)
title('Rechtecksignal Differentiator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;
subplot(212)
hold all
p = plot(time_sq_di, in_sq_di);
plot(time_sq_di, out_sq_d)
title('Rechtecksignal Differentiator Simulation')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;

figure(4)
subplot(211)
hold all
p = plot(time_tri_di_m, in_tri_m);
plot(time_tri_di_m, out_tri_m)
title('Dreiecksignal Differentiator Messung')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;
subplot(212)
hold all
p = plot(time_tri_di, in_tri);
plot(time_tri_di, out_tri)
title('Dreiecksignal Differentiator Simulation')
xlabel('t in ms')
ylabel('Amplitude in V')
legend('V_{in}', 'V_{out}')
p.LineWidth = 2;
grid;



