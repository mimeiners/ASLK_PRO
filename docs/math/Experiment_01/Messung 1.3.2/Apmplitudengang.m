clear all
close all
clc

%% Einlesen der Rohdaten
file = fopen('unitygain.txt','r');
heading_un = textscan(file,'%s %s',1);
fgetl(file);
data1 = textscan(file,'%n %n');
fclose(file); 

file2 = fopen('noninv.txt','r');
heading_noninv = textscan(file2,'%s %s',1);
fgetl(file2);
data2 = textscan(file2,'%n %n');
fclose(file2);

file3 = fopen('inv.txt','r');
heading_inv = textscan(file3,'%s %s',1);
fgetl(file3);
data3 = textscan(file3,'%n %n');
fclose(file3);

%% anlegen der Vektoren
fre_unity = cell2mat(data1(1))./1e6;
out_unity = cell2mat(data1(2));

fre_noninv = cell2mat(data2(1))./1e6;
out_noninv = cell2mat(data2(2));

fre_inv = cell2mat(data3(1))./1e6;
out_inv = cell2mat(data3(2));

%% Moving-Average Filter 
out_unity = mag2db(medfilt1(out_unity,8));         
out_noninv = mag2db(medfilt1(out_noninv,8));
out_inv = mag2db(medfilt1(out_inv,8));

%%
figure(1)
subplot(311)
plot(fre_unity, out_unity)
title('Unity Gain Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in MHz')
grid;
subplot(312)
plot(fre_noninv, out_noninv)
title('Non-Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in MHz')
grid;
subplot(313)
plot(fre_inv, out_inv)
title('Inverting Amplifier')
ylabel('Verstärkung in dB')
xlabel('Frequenz in MHz')
grid;

