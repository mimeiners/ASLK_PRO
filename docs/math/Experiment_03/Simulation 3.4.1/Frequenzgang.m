clear all
close all
clc

%% Einlesen der Rohdaten
inte = fopen('Response_Integrator.txt','r');
heading_in = textscan(inte,'%s %s %s',1);
fgetl(inte);
data1 = textscan(inte,'%n %n %n');
fclose(inte);

diff = fopen('Response_Differentiator.txt','r');
heading_diff = textscan(diff,'%s %s %s',1);
fgetl(diff);
data2 = textscan(diff,'%n %n %n');
fclose(diff); 

%% anlegen der Vektoren
Freq_in = cell2mat(data1(1));
ampl_in = cell2mat(data1(2));
phase_in = cell2mat(data1(3));

Freq_diff = cell2mat(data2(1));
ampl_diff = cell2mat(data2(2));
phase_diff = cell2mat(data2(3));

%% plot der Simulationen
figure(1)
hold all
subplot(211)
semilogx(Freq_in, ampl_in)
title('Amplitudengang Integrator')
xlabel('Frequenz in MHz')
ylabel('Amplitude in V')
grid;
subplot(212)
semilogx(Freq_in, phase_in)
title('Phasengang Integrator')
xlabel('Frequenz in MHz')
ylabel('Phase in degree')
ylim([-10 100])
grid;

figure(2)
hold all
hold all
subplot(211)
semilogx(Freq_diff, ampl_diff)
title('Amplitudengang Differentiator')
xlabel('Frequenz in MHz')
ylabel('Amplitude in V')
grid;
subplot(212)
semilogx(Freq_diff, phase_diff)
title('Phasengang Differentiator')
xlabel('Frequenz in MHz')
ylabel('Phase in degree')
grid;
