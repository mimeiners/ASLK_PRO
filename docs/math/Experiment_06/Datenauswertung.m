%% Datenauswertung Experiment 06

%% init
clc;
clear all;
close all;

%% Einlesen der CSV-Dateien
datapath = '../../spice/Experiment_06/data';
cd(datapath)
flist = dir('*.CSV');
fsort = sort({flist.name});

%% Daten in mat-struct sammeln
Data = struct();
for i=1:length(fsort)
    tabstr = strcat('tab', num2str(i));
    Data.(tabstr) = csvread(fsort{i}, 1, 0);
end
save('Messdaten.mat', '-struct', 'Data')

%% Datenbearbeitung
for i=26:33
    Data.(strcat('tab', num2str(i)))(:,1)=(Data.(strcat('tab', num2str(i)))(:,1)-Data.(strcat('tab', num2str(i)))(1,1))*10^3;
end
for i=30:32
    Data.(strcat('tab', num2str(i)))=anpassung(Data.(strcat('tab', num2str(i))),Data.(strcat('tab', num2str(i-4))));
    i=i+1;
end

for i=1:20
    Data.(strcat('tab', num2str(i)))(:,1)=Data.(strcat('tab', num2str(i)))(:,1)*10^3+1;
end
j=1;
for i=21:25
    Data.(strcat('tab', num2str(i)))(:,1)=Data.(strcat('tab', num2str(i)))(:,1)*10^3;
    Data.(strcat('tab', num2str(i)))=anpassung(Data.(strcat('tab', num2str(i))),Data.(strcat('tab', num2str(j))));
    j=j+2;
end
i=3;
while i<=20
    Data.(strcat('tab', num2str(i)))(:,1)=Data.(strcat('tab', num2str(i)))(:,1)+2;
    i=i+1;
    Data.(strcat('tab', num2str(i)))(:,1)=Data.(strcat('tab', num2str(i)))(:,1)+2;
    i=i+3;
end
i=22;
while i<=25
    Data.(strcat('tab', num2str(i)))(:,1)=Data.(strcat('tab', num2str(i)))(:,1)+2;
    i=i+2;
end

%% Erstellen der Graphen
for i=1:5
    figure(i);
    for j=1:4
        p1=plot(Data.(strcat('tab', num2str((i-1)*4+j)))(:,1),Data.(strcat('tab', num2str((i-1)*4+j)))(:,2));
        p1(1).LineWidth = 4;
        hold on
    end
    for k=1:2
        if(20+(i-1)*2+k)<=25
            p1=plot(Data.(strcat('tab', num2str(20+(i-1)*2+k)))(:,1),Data.(strcat('tab', num2str(20+(i-1)*2+k)))(:,2));
            p1(1).LineWidth = 4;
            hold on
        end
    end
    title('Voltage - Controlled Oscillator Nr.1','Color','k','FontSize',20)
    xlabel('Zeit / ms','Fontsize',20)
    ylabel('Spannung / V','Fontsize',20)
    grid on
    ax = ancestor(p1(1), 'axes');
    ax.FontSize = 20;
    legend('Ausgang Messung 9,78 V','Ausgang Simulation 9,78 V', 'Eingang Messung 9,78 V','Ausgang Messung 8 V','Ausgang Simulation 8 V', 'Eingang Messung 8 V','Location', 'east')
end

figure(6);
p1=plot(Data.(strcat('tab', num2str(26)))(:,1),Data.(strcat('tab', num2str(26)))(:,2), Data.(strcat('tab', num2str(27)))(:,1),Data.(strcat('tab', num2str(27)))(:,2));
hold on
p1(1).LineWidth = 4;p1(2).LineWidth = 4;
p1=plot(Data.(strcat('tab', num2str(30)))(:,1),Data.(strcat('tab', num2str(30)))(:,2));
ax = ancestor(p1(1), 'axes');
p1(1).LineWidth = 4;
ax.FontSize = 20;
xlabel('Zeit / ms','Fontsize',20)
ylabel('Spannung / V','Fontsize',20)
title('Schmitt-Trigger mit R2 = 9,5 k\Omega','Color','k','FontSize',20)
legend('Ausgang Messung','Eingang Messung', 'Ausgang Simulation','Location', 'southeast')
grid on

figure(7);
p1=plot(Data.(strcat('tab', num2str(28)))(:,1),Data.(strcat('tab', num2str(28)))(:,2), Data.(strcat('tab', num2str(29)))(:,1),Data.(strcat('tab', num2str(29)))(:,2));
p1(1).LineWidth = 4;p1(2).LineWidth = 4;
hold on
p1=plot(Data.(strcat('tab', num2str(32)))(:,1),Data.(strcat('tab', num2str(32)))(:,2));
p1(1).LineWidth = 4;
ax = ancestor(p1(1), 'axes');
ax.FontSize = 20;
xlabel('Zeit / ms','Fontsize',20)
ylabel('Spannung / V','Fontsize',20)
title('Schmitt-Trigger mit R2 = 2,46 k\Omega','Color','k','FontSize',20)
legend('Ausgang Messung','Eingang Messung', 'Ausgang Simulation','Location', 'southeast')
grid on

% %% Erstellen der Graphen beschriftung
% figure(1);
% p1=plot(tabelle9(:,1), tabelle9(:,2), simtabelle1(:,1), simtabelle1(:,2), tabelle10(:,1), tabelle10(:,2), tabelle7(:,1), tabelle7(:,2), simtabelle2(:,1), simtabelle2(:,2), tabelle8(:,1), tabelle8(:,2));
% ax = ancestor(p1(1), 'axes');
% p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;p1(5).LineWidth = 4;p1(6).LineWidth = 4;
% ax.FontSize = 20;
% xlabel('Zeit / ms','Fontsize',20)
% ylabel('Spannung / V','Fontsize',20)
% title('Voltage - Controlled Oscillator Nr.1','Color','k','FontSize',20)
% legend('Ausgang Messung 9,78 V','Ausgang Simulation 9,78 V', 'Eingang Messung 9,78 V','Ausgang Messung 8 V','Ausgang Simulation 8 V', 'Eingang Messung 8 V','Location', 'east')
% grid on
% print('Auswertung1.png', -dpng)
%
% figure(2);
% p1=plot(tabelle1(:,1),tabelle1(:,2), simtabelle3(:,1), simtabelle3(:,2), tabelle2(:,1),tabelle2(:,2),tabelle3(:,1),tabelle3(:,2), simtabelle4(:,1), simtabelle4(:,2), tabelle4(:,1),tabelle4(:,2));
% ax = ancestor(p1(1), 'axes');
% p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;p1(5).LineWidth = 4;p1(6).LineWidth = 4;
% ax.FontSize = 20;
% xlabel('Zeit / ms','Fontsize',20)
% ylabel('Spannung / V','Fontsize',20)
% title('Voltage - Controlled Oscillator Nr.2','Color','k','FontSize',20)
% legend('Ausgang Messung 6 V','Ausgang Simulation 6 V', 'Eingang Messung 6 V','Ausgang Messung 4 V','Ausgang Simulation 4 V', 'Eingang Messung 4 V','Location', 'east')
% grid on
%
% figure(3);
% p1=plot(tabelle5(:,1),tabelle5(:,2), simtabelle5(:,1), simtabelle5(:,2), tabelle6(:,1),tabelle6(:,2),tabelle11(:,1),tabelle11(:,2),tabelle12(:,1),tabelle12(:,2));
% ax = ancestor(p1(1), 'axes');
% p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;p1(5).LineWidth = 4;
% ax.FontSize = 20;
% xlabel('Zeit / ms','Fontsize',20)
% ylabel('Spannung / V','Fontsize',20)
% title('Voltage - Controlled Oscillator Nr.3','Color','k','FontSize',20)
% legend('Ausgang Messung 2 V','Ausgang Simulation 2 V', 'Eingang Messung 2 V','Ausgang Messung 1,8 V', 'Eingang Messung 1,8 V','Location', 'east')
% grid on
%
% figure(4);
% p1=plot(tabelle13(:,1),tabelle13(:,2),tabelle14(:,1),tabelle14(:,2),tabelle15(:,1),tabelle15(:,2),tabelle16(:,1),tabelle16(:,2));
% ax = ancestor(p1(1), 'axes');
% p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;
% ax.FontSize = 20;
% xlabel('Zeit / ms','Fontsize',20)
% ylabel('Spannung / V','Fontsize',20)
% title('Voltage - Controlled Oscillator Nr.4','Color','k','FontSize',20)
% legend('Ausgang Messung 1,6 V', 'Eingang Messung 1,6 V','Ausgang Messung 1,4 V', 'Eingang Messung 1,4 V','Location', 'east')
% grid on
%
% figure(5);
% p1=plot(tabelle17(:,1),tabelle17(:,2),tabelle18(:,1),tabelle18(:,2),tabelle19(:,1),tabelle19(:,2),tabelle20(:,1),tabelle20(:,2));
% ax = ancestor(p1(1), 'axes');
% p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;
% ax.FontSize = 20;
% xlabel('Zeit / ms','Fontsize',20)
% ylabel('Spannung / V','Fontsize',20)
% title('Voltage - Controlled Oscillator Nr.5','Color','k','FontSize',20)
% legend('Ausgang Messung 1,2 V', 'Eingang Messung 1,2 V','Ausgang Messung 1 V', 'Eingang Messung 1 V','Location', 'east')
% grid on
%
%% Funktion zur Anpassung der Datensätze
function simtabellerueckgabe = anpassung(simtabelle, tabelle)
time=0;
time2=0;
state=0;
simtabellerueckgabe=[];
offset=0;
i=1;
while (1)
    if(tabelle(i,2) < 0 && tabelle(i+1,2) >= 0)
        state=1;
        time=tabelle(i,1);
        break
    end
    if(tabelle(i,2) >= 0 && tabelle(i+1,2) < 0)
        state=-1;
        time=tabelle(i,1);
        break
    end
    i=i+1;
end
i=1;
while (state == 1)
    if(simtabelle(i,2) < 0 && simtabelle(i+1,2) >= 0)
        state=0;
        i=i+10;
        while (1)
            if(simtabelle(i,2) < 0 && simtabelle(i+1,2) >= 0)
                i=i+10;
                while (1)
                    if(simtabelle(i,2) < 0 && simtabelle(i+1,2) >= 0)
                        time2=simtabelle(i,1);
                        break
                    end
                    i=i+1;
                end
                break
            end
            i=i+1;
        end
    end
    i=i+1;
end
while (state == -1)
    if(simtabelle(i,2) >= 0 && simtabelle(i+1,2) < 0)
        state=0;
        i=i+10;
        while (1)
            if(simtabelle(i,2) >= 0 && simtabelle(i+1,2) < 0)
                i=i+10;
                while (1)
                    if(simtabelle(i,2) >= 0 && simtabelle(i+1,2) < 0)
                        time2=simtabelle(i,1);
                        break
                    end
                    i=i+1;
                end
                break
            end
            i=i+1;
        end
    end
    i=i+1;
end
i=1;
if time >= 2*10^(-3);
    offset=2*10^(-3);
end
while (simtabelle(i,1) < (time2-time+offset) || simtabelle(i,1)<=offset)
    i=i+1;
end
while simtabelle(i,1) <= (time2-time+max(tabelle(:,1)))
    simtabellerueckgabe=[simtabellerueckgabe; simtabelle(i,:)];
    i=i+1;
end
simtabellerueckgabe(:,1)=simtabellerueckgabe(:,1)-time2+time;
end