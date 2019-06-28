close all
clc

%workspace.mat laden

%11.3.1 Simulation der Ausgangspannung zur Eingangsspannung
Vin= [5.500000e+000,6.000000e+000,6.500000e+000,7.000000e+000,7.500000e+000,8.000000e+000,8.500000e+000,9.000000e+000,9.500000e+000,1.000000e+001];
Vout= [ 5.001402e+000,5.002978e+000,5.004554e+000,5.006130e+000,5.007706e+000,5.009282e+000,5.010858e+000,5.012434e+000,5.014010e+000,5.015586e+000]
figure(1)

plot(Vin,Vout)
xlabel('Vin/V')
ylabel('Vout/V')
hold on
%11.3.1 Messung der Ausgangspannung zur Eingangsspannung
Vin1=[5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11];
Vout1=[5.007,5.008,5.009,5.01,5.011,5.01,5.01,5.009,5.009,5.009,5.008,5.008];

plot(Vin1,Vout1)
xlabel('Vin/V')
ylabel('Vout/V')

%11.3.2 Simulation der Ausgangspannung zum Laststrom
figure(2)

plot(IOut,Voutput)
xlabel('Iout/A')
ylabel('Vout/V')
hold on 

%11.3.3 Messung der Ausgangspannung zum Laststrom
Iout1=[0.241,0.161,0.122,0.097,0.081,0.07,0.061,0.056,0.047,0.043,0.04,0.037,0.034,0.032,0.03,0.028,0.026,0.025,0.024,0.023,0.021,0.021,0.019,0.017,0.016,0.015,0.014,0.013,0.012,0.009,0.008,0.007,0.005,0.003,0.001];
Vout2=[4.857,4.901,4.923,4.938,4.948,4.955,4.961,4.966,4.969,4.971,4.974,4.976,4.978,4.979,4.981,4.982,4.983,4.983,4.985,4.985,4.986,4.987,4.988,4.99,4.991,4.991,4.992,4.993,4.994,4.996,4.998,4.999,5,5.003,5.006];

plot(Iout1,Vout2)
xlabel('Iout/A')
ylabel('Vout/V')


