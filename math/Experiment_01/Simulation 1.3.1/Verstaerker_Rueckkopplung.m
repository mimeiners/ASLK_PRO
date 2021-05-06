clear all 
close all
clc

%% einlesen der Textdatei aus LTspice
file = fopen('Experiment_01.txt','r');
heading = textscan(file,'%s %s %s %s %s',1);
fgetl(file);
data = textscan(file,'%n %n %n %n %n');
fclose(file); 

% anlegen der Vektoren
time = cell2mat(data(1));
eingang = cell2mat(data(5));
einheits = cell2mat(data(2));
non_inv = cell2mat(data(3));
inv = cell2mat(data(4));


%% plot der Simulationsdateien
figure(1)
hold on
plot(time, eingang)
plot(time, einheits)
plot(time, non_inv)
plot(time, inv)
title('Verstärker mit negativer Rückkopplung')
xlabel('t in s')
ylabel('Spannung in V')
legend('Eingangssignal','Einheitsverstärker','nicht invertierender Verstärker','invertierender Verstärker')
grid;

