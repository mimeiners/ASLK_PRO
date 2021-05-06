clc 
close all
clear all

Iout=[0.241,0.161,0.122,0.097,0.081,0.07,0.061,0.056,0.047,0.043,0.04,0.037,0.034,0.032,0.03,0.028,0.026,0.025,0.024,0.023,0.021,0.021,0.019,0.017,0.016,0.015,0.014,0.013,0.012,0.009,0.008,0.007,0.005,0.003,0.001];
Vout1=[4.857,4.901,4.923,4.938,4.948,4.955,4.961,4.966,4.969,4.971,4.974,4.976,4.978,4.979,4.981,4.982,4.983,4.983,4.985,4.985,4.986,4.987,4.988,4.99,4.991,4.991,4.992,4.993,4.994,4.996,4.998,4.999,5,5.003,5.006];

Vin=[5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11];
Vout2=[5.007,5.008,5.009,5.01,5.011,5.01,5.01,5.009,5.009,5.009,5.008,5.008];

figure
plot(Vin,Vout2)
xlabel('Vout/V')
ylabel('Vin/A')

figure
plot(Iout,Vout1)
xlabel('Vout/V')
ylabel('Iout/A')