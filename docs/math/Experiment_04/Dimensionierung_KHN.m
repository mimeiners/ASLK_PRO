clc;
clear;
close all;
pkg load control;

%Gegeben:   w0 = wp
%           Q = Qp
%wählbar:   R, R4, R1=R3 (Spannungsteiler)
%berechnet: C, R2

wp = 1000;
fp = wp/(2*pi);
%w = logspace(2,4);    
%f = w/(2*pi);
f = logspace(1,4);
w = 2*pi*f;

Qp = 1;

R = 159 * 10^3
R1 = 1 * 10^3
R3 = 1 * 10^3
R4 = 100 * 10^3
R2 = ((2*Qp-1)*R1*R3) / (R1+R3)

C = 1/(R*wp)

k = (R2/R1) * (1/Qp)

s = j*w;

tau = R*C;

%Hochpass
for n=1:1:length(s)
  H_HP(n) = ((s(n)^2)*(tau^2))/(1 + (s(n)/(wp*Qp)) + ((s(n)^2)/(wp^2)));
end
%semilogx(w, H_HP,'g');

%Bandpass
for n=1:1:length(s)
  H_BP(n) = ((-s(n)*tau))/(1 + (s(n)/(wp*Qp)) + ((s(n)^2)/(wp^2)));
end
%semilogx(w, H_BP,'b');

%Tiefpass
for n=1:1:length(s)
  H_TP(n) = 1/(1 + (s(n)/(wp*Qp)) + ((s(n)^2)/(wp^2)));
end
%semilogx(w, H_TP,'r');

Amp_HP = abs(H_HP);
HP_dB = mag2db(Amp_HP);
Phase_HP = arg(H_HP);
HP_deg = rad2deg(Phase_HP);

Amp_BP = abs(H_BP);
BP_dB = mag2db(Amp_BP);
Phase_BP = unwrap(arg(H_BP));
BP_deg = rad2deg(Phase_BP);

Amp_TP = abs(H_TP);
TP_dB = mag2db(Amp_TP);
Phase_TP = arg(H_TP);
TP_deg = rad2deg(Phase_TP);

%%Amplitude absolut
subplot(3,1,1)
semilogx(f,Amp_HP,'g'); 
hold on;
grid on;
semilogx(f,Amp_BP,'b');
semilogx(f,Amp_TP,'r');
xlabel('Frequenz in Hz');
ylabel('Amplitude');
legend('Hochpass','Bandpass','Tiefpass', 'Location', 'Eastoutside');

%%Amplitude in dB
subplot(3,1,2)
semilogx(f,HP_dB,'g');
hold on;
grid on;
semilogx(f,BP_dB,'b');
semilogx(f,TP_dB,'r');
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');

%%Phase
subplot(3,1,3)
semilogx(f,HP_deg,'g');
hold on;
grid on;
semilogx(f,BP_deg,'b');
semilogx(f,TP_deg,'r');
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');  