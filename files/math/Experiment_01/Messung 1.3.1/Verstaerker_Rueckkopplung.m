clear all
close all
clc

%% Rohdaten
sys1 = dlmread('eingangssignal.CSV');       %Spalteninformation: t in s, Eingangsspannung
sys2 = dlmread('einheitsverstaerker.CSV');  %Spalteninformation: t in s, Ausgangsspannung
sys3 = dlmread('nichtinv_verstaerker.CSV'); %Spalteninformation: t in s, Ausgangsspannung
sys4 = dlmread('inv_verstaerker.CSV');      %Spalteninformation: t in s, Ausgangsspannung

%% anlegen von Vektoren mit den benötigten Daten
% Betrachtungszeitraum
t1 = sys1(:,1); 
t2 = sys1(:,1);
t3 = sys1(:,1);
t4 = sys1(:,1);
% Betrachungszeitraum >= null
t1 = t1(find(t1 >= 0));
t2 = t2(find(t2 >= 0));
t3 = t3(find(t3 >= 0));
t4 = t4(find(t4 >= 0));

t = find(t1 >= 0);

% zeitlicher Verlauf der einzelnen Ausgangssignale und Eingangssignal
in1 = sys1(:,2);
in2 = sys2(:,2);
in3 = sys3(:,2);
in4 = sys4(:,2);
% zeitlicher Verlauf >= null
in1 = in1(t);
in2 = in2(t);
in3 = in3(t);
in4 = in4(t);
%% plot der Ergebnisse
figure(1)
hold on
plot(t1, in1)
plot(t2, in2)
plot(t3, in3)
plot(t4, in4)
title('Messung der Verstaerker-Schaltungen mit negativer Rückkopplung')
xlabel('t in s')
ylabel('Spannung in V')
legend('Eingangsignal', 'Einheitsverstärker', 'nicht inventierender Verstärker', 'inventierender Verstärker')
grid;


