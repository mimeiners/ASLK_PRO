clear all
close all
clc

%% Einlesen der Rohdaten
file = fopen('unitygain.txt','r');
data1 = textscan(file,'%n %n');
fclose(file); 

file2 = fopen('noninv.txt','r');
data2 = textscan(file2,'%n %n');
fclose(file2);

file3 = fopen('inv.txt','r');
data3 = textscan(file3,'%n %n');
fclose(file3);

%% anlegen der Vektoren
fre_unity = cell2mat(data1(1));
out_unity = cell2mat(data1(2));

fre_noninv = cell2mat(data2(1));
out_noninv = cell2mat(data2(2));

fre_inv = cell2mat(data3(1));
out_inv = cell2mat(data3(2));

db_3 = fre_unity(find(max(out_unity)-3 > out_unity, 1, 'first'));
db_3_1 = fre_noninv(find(max(out_noninv)-3 > out_noninv, 1, 'first'));
db_3_2 = fre_inv(find(max(out_inv)-3 > out_inv, 1, 'first'));

%%
figure(1)
subplot(311)
plot(fre_unity, out_unity)
title('Unity Gain Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log')
ylim([-50 5])
xlim([1e3 11e6])
grid;
subplot(312)
plot(fre_noninv, out_noninv)
title('Non-Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log') 
xlim([1e3 11e6])
grid;
subplot(313)
plot(fre_inv, out_inv)
title('Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log')
xlim([1e3 11e6])
grid;

