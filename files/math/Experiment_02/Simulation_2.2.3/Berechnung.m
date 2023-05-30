clear all
close all
clc

%% Parameter f�r die a- und monostabile Kippstufe
f = 1500;
T = 1/f;
R1 = 2200;
R2 = 10000;
beta = R1/(R1+R2);
beta_ka = log((1+beta)/(1-beta));
tau = 4e-3;
beta_km = log(1/(1-beta));


%% Berechnung der RC-Konstanten f�r die astabile Kippstufe 
%Formel: T = 2*RC*ln((1+beta)/(1-beta))
RC_a = T/(beta_ka*2);
format = ('Die RC-Konstante f�r die astabile Kippstufe betr�gt:\n\n %d\n\n');
fprintf(format, RC_a);

%% Berechnung der RC-Konstanen f�r die monostabile Kippstufe
% tau = RC*ln(1/(1-beta))

RC_m = tau/beta_km;
format = ('Die RC-Konstante f�r die monostabile Kippstufe betr�gt:\n\n %d\n');
fprintf(format, RC_m);



