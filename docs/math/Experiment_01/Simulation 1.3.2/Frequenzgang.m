clear all
close all
clc

%% Einlesen der Rohdaten
file = fopen('unitygain.txt','r');
heading_un = textscan(file,'%s %s %s',1);
fgetl(file);
data1 = textscan(file,'%n %n %n');
fclose(file); 

file2 = fopen('noninv.txt','r');
heading_noninv = textscan(file2,'%s %s %s',1);
fgetl(file2);
data2 = textscan(file2,'%n %n %n');
fclose(file2);

file3 = fopen('inv.txt','r');
heading_inv = textscan(file3,'%s %s %s',1);
fgetl(file3);
data3 = textscan(file3,'%n %n %n');
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

%%
figure(1)
subplot(211)
plot(fre_unity,out_unity)
title('Unity Gain Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log') 
grid;
subplot(212)
plot(fre_unity, phase_unity)
ylabel('Phase in degree')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log') 
grid;

figure(2)
subplot(211)
plot(fre_noninv,out_noninv)
title('Non Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log') 
grid;
subplot(212)
plot(fre_noninv, phase_noninv)
ylabel('Phase in degree')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log') 
grid;

figure(3)
subplot(211)
plot(fre_inv,out_inv)
title('Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log') 
grid;
subplot(212)
plot(fre_inv, phase_inv)
ylabel('Phase in degree')
xlabel('Frequenz in Hz')
set(gca, 'XScale', 'log') 
grid;