%% Berechnung des Frequenzgangs aus den Messungen %%
%% Messung mit Oszilloskop und AC-Sweep des Generators %%

clear;
clc;
close all;

%% Einlesen der Rohdaten
BP = csvread('Messung_KHN/Messung1/Bandpass.CSV');        
TP = csvread('Messung_KHN/Messung1/Tiefpass.CSV');        
HP = csvread('Messung_KHN/Messung1/Hochpass.CSV');

%% gewünschte FFT-Länge
N_BP = length(BP);
N_TP = length(TP);
N_HP = length(HP); 

%% Berechnung der FFT/DFT
BP_FFT = fft(BP(:,2),N_BP);
TP_FFT = fft(TP(:,2),N_TP);
HP_FFT = fft(HP(:,2),N_HP);


%% Berechnung des Amplitudengangs
BP_Amp = abs(BP_FFT);
TP_Amp = abs(TP_FFT);
HP_Amp = abs(HP_FFT);

BP_Amp = BP_Amp([2:length(BP_Amp)]);
BP_Amp2 = fftshift(BP_Amp); 
TP_Amp = TP_Amp([2:length(TP_Amp)]);
TP_Amp2 = fftshift(TP_Amp); 
HP_Amp = HP_Amp([2:length(HP_Amp)]);
HP_Amp2 = fftshift(HP_Amp); 

figure(1);

subplot(3,1,1)
plot(BP_Amp)
hold on;
plot(BP_Amp2)

subplot(3,1,2)
plot(TP_Amp)
hold on;
plot(TP_Amp2)

subplot(3,1,3)
plot(HP_Amp)
hold on;
plot(HP_Amp2)



figure(2);

subplot(4,1,1)
plot(BP(:,1),BP(:,2))

subplot(4,1,2)
plot(TP(:,1),TP(:,2))

subplot(4,1,3)
plot(HP(:,1),HP(:,2))

