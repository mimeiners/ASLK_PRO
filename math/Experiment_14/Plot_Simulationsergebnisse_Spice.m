close all

Bit = [256 512 768 1024 1280 1536 1792 2048 2304 2560 2816 3072 3328 3584 3840];
V = [1.051 2.102 3.152 4.206 5.256 6.302 7.352 8.416 9.456 10.500 11.558 12.640 13.658 14.700 15.740];
f = [25.113 50.200 75.597 100.200 125.313 150.240 175.316 200.160 225.225 249.875 274.726 299.760 324.675 349.406 374.252];

figure;
plot(V,f,'-o');
grid;
title('DAC-Output and Frequency of oszillations');
xlabel('analog output of the DAC [V]');
ylabel('frequency of oszillations');

figure;
plot(Bit,f,'-o');
grid;
title('DAC-Input and Frequency of oszillations');
xlabel('Bit Input of the DAC (unsigned)');
ylabel('frequency of oszillations');