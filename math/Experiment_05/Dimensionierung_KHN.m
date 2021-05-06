clc;
clear;
close all;
% pkg load control;

% Gegeben:   w0 = wp
%            Q = Qp
% wählbar:   R, R4, R1=R3 (Spannungsteiler)
% berechnet: C, R2

%% Real Parameter

wp = 1000;
fp = wp/(2*pi);
%w = logspace(2,4);    
%f = w/(2*pi);
f = logspace(1,4,1000);
w = 2*pi*f;

Qp = 1;

R = 10 * 10^3
R1 = 1 * 10^3
R3 = 1 * 10^3
R4 = 10 * 10^3
R2 = ((2*Qp-1)*R1*R3) / (R1+R3)

C = 1/(R*wp)

k = (R2/R1) * (1/Qp)

s = j*w;

tau = R*C;

%% Übertragungsfunktionen

%Hochpass
A_HP = [0 0 tau^2];
B_HP = [1 1/(wp*Qp) 1/(wp^2)];
for n=1:1:length(s)
  H_HP(n) = ((s(n)^2)*(tau^2))/(1 + (s(n)/(wp*Qp)) + ((s(n)^2)/(wp^2)));
end
% semilogx(w, H_HP,'g');

% Bandpass
A_BP = [0 -tau 0];
B_BP = [1 1/(wp*Qp) 1/(wp^2)];
for n=1:1:length(s)
  H_BP(n) = ((-s(n)*tau))/(1 + (s(n)/(wp*Qp)) + ((s(n)^2)/(wp^2)));
end
% semilogx(w, H_BP,'b');

% Tiefpass
A_TP = [1 0 0];
B_TP = [1 1/(wp*Qp) 1/(wp^2)];
for n=1:1:length(s)
  H_TP(n) = 1/(1 + (s(n)/(wp*Qp)) + ((s(n)^2)/(wp^2)));
end
% semilogx(w, H_TP,'r');

% Bandsperre
A_BS = [1 0 tau^2];
B_BS = [1 1/(wp*Qp) 1/(wp^2)];
for n=1:1:length(s)
  H_BS(n) = (1+ ((s(n)^2)/(wp^2)))/(1 + (s(n)/(wp*Qp)) + ((s(n)^2)/(wp^2)));
end  



Amp_HP = abs(H_HP);
HP_dB = mag2db(Amp_HP);
Phase_HP = angle(H_HP);
HP_deg = rad2deg(Phase_HP);

Amp_BP = abs(H_BP);
BP_dB = mag2db(Amp_BP);
Phase_BP = unwrap(angle(H_BP));
BP_deg = rad2deg(Phase_BP);

Amp_TP = abs(H_TP);
TP_dB = mag2db(Amp_TP);
Phase_TP = angle(H_TP);
TP_deg = rad2deg(Phase_TP);

Amp_BS = abs(H_BS);
BS_dB = mag2db(Amp_BS);
Phase_BS = unwrap(angle(H_BS));
BS_deg = rad2deg(Phase_BS);

%% Amplitude absolut
subplot(3,1,1)
semilogx(f,Amp_HP,'g'); 
hold on;
grid on;
semilogx(f,Amp_BP,'b');
semilogx(f,Amp_TP,'r');
semilogx(f,Amp_BS)
xlabel('Frequenz in Hz');
ylabel('Amplitude');
legend('Hochpass','Bandpass','Tiefpass','Bandsperre', 'Location', 'Eastoutside');

%% Amplitude in dB
subplot(3,1,2)
semilogx(f,HP_dB,'g');
hold on;
grid on;
semilogx(f,BP_dB,'b');
semilogx(f,TP_dB,'r');
semilogx(f,BS_dB)
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');

%% Phase
subplot(3,1,3)
semilogx(f,HP_deg,'g');
hold on;
grid on;
semilogx(f,BP_deg,'b');
semilogx(f,TP_deg,'r');
semilogx(f,BS_deg)
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');  

%% BP
figure;
subplot(2,1,1)
semilogx(f,BP_dB,'b');
hold on;
grid on;
semilogx([160,160],[min(BP_dB),max(BP_dB)],'r');
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');
ylim([min(BP_dB),max(BP_dB)])

subplot(2,1,2)
semilogx(f,BP_deg,'b');
hold on;
grid on;
semilogx([160,160],[min(BP_deg),max(BP_deg)],'r');
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');  
ylim([min(BP_deg),max(BP_deg)])

%% HP
figure;
subplot(2,1,1)
semilogx(f,HP_dB,'g');
hold on;
grid on;
semilogx([160,160],[min(HP_dB),max(HP_dB)],'r');
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');
ylim([min(HP_dB),max(HP_dB)])

subplot(2,1,2)
semilogx(f,HP_deg,'g');
hold on;
grid on;
semilogx([160,160],[min(HP_deg),max(HP_deg)],'r');
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');  
ylim([min(HP_deg),max(HP_deg)])