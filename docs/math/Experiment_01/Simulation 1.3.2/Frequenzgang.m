clear all
close all
clc

%% Einlesen der Simulationsdaten
file = fopen('unitygain_simulation.txt','r');
heading_un = textscan(file,'%s %s %s',1);
fgetl(file);
data1 = textscan(file,'%n %n %n');
fclose(file); 

file2 = fopen('noninv_simulation.txt','r');
heading_noninv = textscan(file2,'%s %s %s',1);
fgetl(file2);
data2 = textscan(file2,'%n %n %n');
fclose(file2);

file3 = fopen('inv_simulation.txt','r');
heading_inv = textscan(file3,'%s %s %s',1);
fgetl(file3);
data3 = textscan(file3,'%n %n %n');
fclose(file3);

%% Einlesen der Messdaten
file = fopen('unitygain_messung.txt','r');
fgetl(file);
data4 = textscan(file,'%n %n');
fclose(file); 

file2 = fopen('noninv_messung.txt','r');
fgetl(file2);
data5 = textscan(file2,'%n %n %n');
fclose(file2);

file3 = fopen('inv_messung.txt','r');
fgetl(file3);
data6 = textscan(file3,'%n %n %n');
fclose(file3);


%% anlegen der Vektoren
fre_unity = cell2mat(data1(1));
out_unity = cell2mat(data1(2));
phase_unity = cell2mat(data1(3));

fre_noninv = cell2mat(data2(1));
out_noninv = cell2mat(data2(2));
phase_noninv = cell2mat(data2(3));

fre_inv = cell2mat(data3(1));
out_inv = cell2mat(data3(2));
phase_inv = cell2mat(data3(3));

fre_unity_m = cell2mat(data4(1));
out_unity_m = cell2mat(data4(2));

fre_noninv_m = cell2mat(data5(1));
out_noninv_m = cell2mat(data5(3));

fre_inv_m = cell2mat(data6(1));
out_inv_m = cell2mat(data6(3));

db_3 = fre_unity(find(max(out_unity)-3 > out_unity, 1, 'first'));
db_3_1 = fre_noninv(find(max(out_noninv)-3 > out_noninv, 1, 'first'));
db_3_2 = fre_inv(find(max(out_inv)-3 > out_inv, 1, 'first'));


%%
figure(1)
subplot(311)
hold all
p_1 = plot(fre_unity_m, out_unity_m, ':');
p_2 = plot(fre_unity,out_unity, '--');
title('Unity Gain Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log')
legend('Messung','Simulation')
legend('Location','southwest')
p_1.LineWidth = 2;
p_2.LineWidth = 2;
ylim([-50 5])
xlim([1e3 11e6])
grid;
subplot(312)
hold all
p_1 = plot(fre_noninv_m,out_noninv_m, ':');
p_2 = plot(fre_noninv,out_noninv, '--');
title('Non Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log')
legend('Messung','Simulation')
legend('Location','southwest')
p_1.LineWidth = 2;
p_2.LineWidth = 2;
ylim([-50 30])
xlim([1e3 11e6])
grid;
subplot(313)
hold all
p_1 = plot(fre_inv_m,out_inv_m, ':');
p_2 = plot(fre_inv,out_inv,'--');
title('Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log')
legend('Messung','Simulation')
legend('Location','southwest')
p_1.LineWidth = 2;
p_2.LineWidth = 2;
ylim([-50 30])
xlim([1e3 11e6])
grid;
