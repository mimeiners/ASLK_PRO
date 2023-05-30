clear all
close all
clc

%% einlesen der Textdatei aus LTspice
file = fopen('DCsweep.txt','r');
heading = textscan(file,'%s %s %s',1);
fgetl(file);
data = textscan(file,'%n %n %n');
fclose(file); 

% anlegen der Vektoren
eingang = cell2mat(data(2));
ausgang = cell2mat(data(3));

%% plot der Simulation
figure(1)
plot(eingang, ausgang)
title('DC Simulation')
ylabel('Ausgansspannung')
xlabel('Eingangsspannung')
grid;
ax = gca;
ax.YAxisLocation = 'origin';
ax.XAxisLocation = 'origin';
xlim([-2.7 2.7])
ylim([-10.4 10.4])