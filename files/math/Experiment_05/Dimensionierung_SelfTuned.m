clc;
clear;
close all;
slCharacterEncoding('UTF-8')
% pkg load control;

%Gegeben:   w0, Q
%wählbar:   R, R8, R6=R9 (Spannungsteiler)
%berechnet: C, R7

U_SF = 10;
%%
w0 = 1000*2*pi;
fp = w0/(2*pi);

f = logspace(1,4,1000);
w = 2*pi*f;

Q = 10;
%% V_F3
Vx = 0.1;           % Eingangsspannung (vlt auch 0.2) +-100 mV
Vy = Vx* 0.707;     % Aktuell Platzhalter (Dämpfung bei w = w0)
phi = pi/2;   % Aktuell Platzhalter (V'_F3 ist, bei phi=90°, = 0)
V_F3_ = Vx*Vy/U_SF * cos(phi);
V_F3 = V_F3_ + 2.43;
%% Ampl. 
R6 = 1 * 10^3;
R9 = R6;
R8 = 100 * 10^3;
fprintf('R6,R9 = %4.2f kOhm gewaehlt.\n',R6/10^3);
fprintf('R8 = %4.2f kOhm gewaehlt.\n',R8/10^3);
R7 = ((2*Q-1)*R6*R9) / (R6+R9);
fprintf('R7 = %4.2f kOhm\n -> 10 kOhm gewaehlt.\n',R7/10^3);
%% Spannungsgesteuerte Filter
R = 1 * 10^3;
C = U_SF/(R*w0*V_F3);
fprintf('C = %4.4f nF\n',C*10^9);

k = (R7/R6) * (1/Q);

wp = w0;
Qp = Q;

s = 1i*w;

tau = R*C*V_F3/U_SF;
%Hochpass
for n=1:1:length(s)
  H_HP(n) = ((s(n)^2)*(tau^2))/(1 + (s(n)/(w0*Qp)) + ((s(n)^2)/(w0^2)));
end
phi = angle(H_HP);
phi_deg = rad2deg(phi);
k = 1;
N =1000000
for i=1:1:N
    V_F3_ = Vx*Vy/U_SF * cos(phi);
    V_F3 = 100 * V_F3_  + 2.43;
    w0 = U_SF./(R.*C.*V_F3);
    tau = R*C*V_F3/U_SF;
    for n=1:1:length(s)
      H_HP(n) = ((s(n)^2)*(tau(n)^2))/(1 + (s(n)/(w0(n)*Qp)) + ((s(n)^2)/(w0(n)^2)));
    end
    phi = angle(H_HP);
    if i == N/10*k
        fprintf('%d/100  ',k*10)
        k = k+1;
    end
    %semilogx(w, H_HP,'g');
end
fprintf(' 100/100\n')
%Bandpass
for n=1:1:length(s)
  H_BP(n) = ((-s(n)*tau(n)))/(1 + (s(n)/(w0(n)*Qp)) + ((s(n)^2)/(w0(n)^2)));
end
%semilogx(w, H_BP,'b');

%Tiefpass
for n=1:1:length(s)
  H_TP(n) = 1/(1 + (s(n)/(w0(n)*Qp)) + ((s(n)^2)/(w0(n)^2)));
end
%semilogx(w, H_TP,'r');

%Bandsperre
for n=1:1:length(s)
  H_BS(n) = (1+ ((s(n)^2)/(w0(n)^2)))/(1 + (s(n)/(w0(n)*Qp)) + ((s(n)^2)/(w0(n)^2)));
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
figure;
%%Amplitude absolut
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

%%Amplitude in dB
subplot(3,1,2)
semilogx(f,HP_dB,'g');
hold on;
grid on;
semilogx(f,BP_dB,'b');
semilogx(f,TP_dB,'r');
semilogx(f,BS_dB)
xlabel('Frequenz in Hz');
ylabel('Amplitude in dB');

%%Phase
subplot(3,1,3)
semilogx(f,HP_deg,'g');
hold on;
grid on;
semilogx(f,BP_deg,'b');
semilogx(f,TP_deg,'r');
semilogx(f,BS_deg)
semilogx(f,phi_deg)
xlabel('Frequenz in Hz');
ylabel('Phase in Grad');  
legend('Hochpass','Bandpass','Tiefpass','Bandsperre','Phi0', 'Location', 'Eastoutside');