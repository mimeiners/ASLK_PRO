clear all
close all
clc

%% Einlesen der Simulationsdaten
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

%% Einlesen der Messdaten
diff_1 = fopen('diff.txt', 'r');
data3 = textscan(diff_1, ' %n %n %n');
fclose(diff_1);

integrator = fopen('integrator.txt','r');
data4 = textscan(integrator, '%n %n %n');
fclose(integrator);

%% anlegen der Vektoren
Freq_in = cell2mat(data1(1));
ampl_in = cell2mat(data1(2));
phase_in = cell2mat(data1(3));

Freq_diff = cell2mat(data2(1));
ampl_diff = cell2mat(data2(2));
phase_diff = cell2mat(data2(3));

fre_diff_m = cell2mat(data3(1));
ampl_diff_m = cell2mat(data3(3));
ampl_diff_m = medfilt1(ampl_diff_m, 3);

fre_int = cell2mat(data4(1));
ampl_int = cell2mat(data4(3));
ampl_int = medfilt1(ampl_int, 3);

%% plot der Simulationen
figure(1)
subplot(211)
hold all
p_1 = plot(fre_int, ampl_int, ':');
p_2 = plot(Freq_in, ampl_in, '--');
title('Amplitudengang Integrator')
legend('Messung','Simulation')
xlabel('Frequenz in MHz')
ylabel('Verstärkung in db')
set(gca, 'XScale', 'log')
p_1.LineWidth = 2;
p_2.LineWidth = 2;
grid;
subplot(212)
hold all
p_1 = plot(fre_diff_m, ampl_diff_m, ':');
p_2 = plot(Freq_diff, ampl_diff, '--');
title('Amplitudengang Differentiator')
xlabel('Frequenz in MHz')
ylabel('Verstärkung in db')
legend('Messung','Simulation')
set(gca, 'XScale', 'log')
p_1.LineWidth = 2;
p_2.LineWidth = 2;
grid;

