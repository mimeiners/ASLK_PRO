close all
clc

%workspace.mat laden

%11.3.1 Simulation der Ausgangspannung zur Eingangsspannung
Vin=[5.500000e+000,6.000000e+000,6.500000e+000,7.000000e+000,7.500000e+000,8.000000e+000,8.500000e+000,9.000000e+000,9.500000e+000,1.000000e+001,1.050000e+001,1.100000e+001];
Vout=[5.001402e+000,5.002978e+000,5.004554e+000,5.006130e+000,5.007706e+000,5.009282e+000,5.010858e+000,5.012434e+000,5.014010e+000,5.015586e+000,5.017162e+000,5.018738e+000];

%11.3.1 Messung der Ausgangspannung zur Eingangsspannung
Vin1=[5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11];
Vout1=[5.007,5.008,5.009,5.01,5.011,5.01,5.01,5.009,5.009,5.009,5.008,5.008];

figure(1)
plot(Vin,Vout,'-k*')
hold on
plot(Vin1,Vout1,'-m*')
hold on
plot(Vin1,Vout3,'-b*')
hold on
plot(Vin1,Vout4,'-r*')
hold on 
plot(Vin1,Vout6)
xlabel('Vin/V')
ylabel('Vout/V')
legend('Simulation','ohne Last','kleine Last','groﬂe Last')
grid();


%11.3.2 Simulation der Ausgangspannung zum Laststrom
figure(2)

plot(IOut,Voutput,'-b')
xlabel('Iout/A')
ylabel('Vout/V')
hold on 

%11.3.3 Messung der Ausgangspannung zum Laststrom

plot(Iout2,Vout5,'-r*')
xlabel('Iout/A')
ylabel('Vout/V')
legend('Simulation','Messung')
grid();

