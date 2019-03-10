clear all
close all
clc

%% Einlesen der Rohdaten
diff_1 = fopen('diff.txt', 'r');
data1 = textscan(diff_1, ' %n %n');
fclose(diff_1);

diff_2 = fopen('diff2.txt', 'r');
data2 = textscan(diff_2, ' %n %n');
fclose(diff_2);

integrator = fopen('integrator.txt','r');
data3 = textscan(integrator, '%n %n');
fclose(integrator);

%% Vektoren anlegen
fre_diff_1 = cell2mat(data1(1));
ampl_1 = cell2mat(data1(2));

fre_diff_2 = cell2mat(data2(1));
ampl_2 = cell2mat(data2(2));

fre_diff = [fre_diff_1;fre_diff_2(2:end)];
ampl_diff = [ampl_1; ampl_2(2:end)];
ampl_diff = medfilt1(ampl_diff, 3);

fre_int = cell2mat(data3(1));
ampl_int = cell2mat(data3(2));
ampl_int = medfilt1(ampl_int, 3);
%% Plot der Messung
figure(1)
semilogx(fre_diff, ampl_diff)
title('Amplitudengang Differentiator Messung')
ylabel('Amplitude in V')
xlabel('Frequenz in Hz')
grid;

figure(2)
semilogx(fre_int, ampl_int)
title('Amplitudengang Integrator Messung')
ylabel('Amplitude in V')
xlabel('Frequenz in Hz')
grid;
