clear all;
close all;
clc;


%%% Simulation %%%

%% Daten einlesen

% Daten Simulation KHN einlesen
bode_KHN = csvread('C:/Users/Hann17-2-Stud02.AUSBBNETZA/Desktop/HS Bremen/19 SoSe/ANS/Simulation/KHN_Simulation.csv');
f_KHN = bode_KHN(:,1);
TP_dB_KHN = bode_KHN(:,2);
TP_deg_KHN = unwrap(bode_KHN(:,3));
HP_dB_KHN = bode_KHN(:,4);
HP_deg_KHN = unwrap(bode_KHN(:,5));
BP_dB_KHN = bode_KHN(:,6);
BP_deg_KHN = unwrap(bode_KHN(:,7));

% Daten Simulation Universalfilter einlesen
bode_universal = csvread('C:/Users/Hann17-2-Stud02.AUSBBNETZA/Desktop/HS Bremen/19 SoSe/ANS/Simulation/Universal_Simulation.csv');
f_universal = bode_universal(:,1);
HP_dB_universal = bode_universal(:,2);
HP_deg_universal = unwrap(bode_universal(:,3));
BP_dB_universal = bode_universal(:,4);
BP_deg_universal = unwrap(bode_universal(:,5));
TP_dB_universal = bode_universal(:,6);
TP_deg_universal = unwrap(bode_universal(:,7));
BS_dB_universal = bode_universal(:,8);
BS_deg_universal = bode_universal(:,9); 

%% KHN Bodediagramm plotten
figure(1)

% Amplitudengang KHN Simulation
subplot(2,1,1);
semilogx(f_KHN,HP_dB_KHN,'g');
hold on;
grid on;
semilogx(f_KHN,TP_dB_KHN,'r');
semilogx(f_KHN,BP_dB_KHN,'b');
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');

% Phasengang KHN Simulation
subplot(2,1,2)
semilogx(f_KHN,HP_deg_KHN,'g');
hold on;
grid on;
semilogx(f_KHN,TP_deg_KHN,'r');
semilogx(f_KHN,BP_deg_KHN,'b');
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');
legend('Hochpass','Bandpass','Tiefpass', 'Location', 'southoutside','Orientation','horizontal');


%% Universalfilter Bodediagramm plotten
figure(2)

% Amplitudengang Universalfilter
subplot(2,1,1);
semilogx(f_universal,HP_dB_universal,'g');
hold on;
grid on;
semilogx(f_universal,TP_dB_universal,'r');
semilogx(f_universal,BP_dB_universal,'b');
semilogx(f_universal,BS_dB_universal);
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');

% Phasengang Universal
subplot(2,1,2)
semilogx(f_universal,HP_deg_universal,'g');
hold on;
grid on;
semilogx(f_universal,TP_deg_universal,'r');
semilogx(f_universal,BP_deg_universal,'b');
semilogx(f_universal,BS_deg_universal);
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');
legend('Hochpass','Bandpass','Tiefpass','Bandsperre', 'Location', 'southoutside','Orientation','horizontal');


%%% Messung KHN %%%
%% http://elie1redpi.fk4.hs-bremen.de/scpi_manager/#

Messung_BP = csvread('C:/Users/Hann17-2-Stud02.AUSBBNETZA/Desktop/HS Bremen/19 SoSe/ANS/ASLK_PRO/docs/math/Experiment_04/Messung_KHN/RedPitaya/Bandpass.csv');
Messung_HP = csvread('C:/Users/Hann17-2-Stud02.AUSBBNETZA/Desktop/HS Bremen/19 SoSe/ANS/ASLK_PRO/docs/math/Experiment_04/Messung_KHN/RedPitaya/Hochpass.csv');
Messung_TP = csvread('C:/Users/Hann17-2-Stud02.AUSBBNETZA/Desktop/HS Bremen/19 SoSe/ANS/ASLK_PRO/docs/math/Experiment_04/Messung_KHN/RedPitaya/Tiefpass.csv');

f_BP = Messung_BP(:,1);
BP_dB_Messung = Messung_BP(:,3);

f_HP = Messung_HP(:,1);
HP_dB_Messung = Messung_HP(:,3);

f_TP = Messung_TP(:,1);
TP_dB_Messung = Messung_TP(:,3);

figure(3)

% Amplitudengang KHN Messung
subplot(2,1,1);
semilogx(f_HP,HP_dB_Messung,'g');
hold on;
grid on;
semilogx(f_TP,TP_dB_Messung,'r');
semilogx(f_BP,BP_dB_Messung,'b');
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');

%{
% Phasengang KHN Simulation
subplot(2,1,2)
semilogx(f_HP,HP_deg_Messung,'g');
hold on;
grid on;
semilogx(f_TP,TP_deg_Messung,'r');
semilogx(f_BP,BP_deg_Messung,'b');
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');
legend('Hochpass','Bandpass','Tiefpass', 'Location', 'southoutside','Orientation','horizontal');
%}


