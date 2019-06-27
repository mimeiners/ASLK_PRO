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

%% Plotbeschriftung
plotbeschriftung=fileread('plotbeschriftung.txt');
plotbeschriftung=splitlines(plotbeschriftung);
plotbeschriftung=erase(plotbeschriftung,"	");
plotbeschriftung=split(plotbeschriftung,";");

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

freq=zeros(10,1);
periodendauer=zeros(10,1);
r2=1;
for r=19:-2:1
    [periode,frequenz]=frequenzbestimmung((Data.(strcat('tab', num2str(r)))));
    freq(r2,1)=frequenz;
    periodendauer(r2,1)=periode;
    r2=r2+1;
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
    title(plotbeschriftung(i,1),'Color','k','FontSize',20)
    xlabel(plotbeschriftung(i,2),'Fontsize',20);ylabel(plotbeschriftung(i,3),'Fontsize',20);
    grid on
    ax = ancestor(p1(1), 'axes');ax.FontSize = 20;
    legend(plotbeschriftung(i,4:9),'Location', 'east')
end

for v = 26:2:28
    i=i+1;
    figure(i);
    p1=plot(Data.(strcat('tab', num2str(v)))(:,1),Data.(strcat('tab', num2str(v)))(:,2), Data.(strcat('tab', num2str(v+1)))(:,1),Data.(strcat('tab', num2str(v+1)))(:,2));
    hold on
    p1(1).LineWidth = 4;    p1(2).LineWidth = 4;
    p1=plot(Data.(strcat('tab', num2str(v+4)))(:,1),Data.(strcat('tab', num2str(v+4)))(:,2));
    ax = ancestor(p1(1), 'axes');   ax.FontSize = 20;
    p1(1).LineWidth = 4;
    xlabel(plotbeschriftung(i,2),'Fontsize',20);ylabel(plotbeschriftung(i,3),'Fontsize',20);
    title(plotbeschriftung(i,1),'Color','k','FontSize',20)
    legend(plotbeschriftung(i,4:6),'Location', 'southeast')
    grid on
end

i=i+1;
figure(i);
p1=plot((Data.(strcat('tab', num2str(34)))(:,1)),(Data.(strcat('tab', num2str(34)))(:,2)),'ro');
p1(1).LineWidth = 10; hold on
interpolx=min((Data.(strcat('tab', num2str(34)))(:,1))):10^-3:max((Data.(strcat('tab', num2str(34)))(:,1)));
interpoly = interp1((Data.(strcat('tab', num2str(34)))(:,1)),(Data.(strcat('tab', num2str(34)))(:,2)),interpolx);
p1=plot(interpolx,interpoly,'r');
p1(1).LineWidth = 4; hold on
p1=plot((Data.(strcat('tab', num2str(34)))(:,1)),(Data.(strcat('tab', num2str(34)))(:,3)),'bo');
p1(1).LineWidth = 10; hold on
interpoly = interp1((Data.(strcat('tab', num2str(34)))(:,1)),(Data.(strcat('tab', num2str(34)))(:,3)),interpolx);
p1=plot(interpolx,interpoly,'b');
p1(1).LineWidth = 4;
title(plotbeschriftung(i,1),'Color','k','FontSize',20)
xlabel(plotbeschriftung(i,2),'Fontsize',20);ylabel(plotbeschriftung(i,3),'Fontsize',20);
ax = ancestor(p1(1), 'axes');ax.FontSize = 20;grid on
legend(plotbeschriftung(i,4:7),'Fontsize',20)

i=i+1;
figure(i);
p1=plot(freq,(Data.(strcat('tab', num2str(34)))(:,2)),'ro');
p1(1).LineWidth = 10;hold on
interpolx=min(freq):1:max(freq);
interpoly = interp1(freq,(Data.(strcat('tab', num2str(34)))(:,2)),interpolx);
p1=plot(interpolx,interpoly,'r');
p1(1).LineWidth = 4; hold on
p1=plot(freq,(Data.(strcat('tab', num2str(34)))(:,3)),'bo');
p1(1).LineWidth = 10;
interpoly = interp1(freq,(Data.(strcat('tab', num2str(34)))(:,3)),interpolx);
p1=plot(interpolx,interpoly,'b');
p1(1).LineWidth = 4; hold on
title(plotbeschriftung(i,1),'Color','k','FontSize',20)
xlabel(plotbeschriftung(i,2),'Fontsize',20);ylabel(plotbeschriftung(i,3),'Fontsize',20);
ax = ancestor(p1(1), 'axes');ax.FontSize = 20;grid on
legend(plotbeschriftung(i,4:7),'Fontsize',20,'Location', 'northeast')

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

%% Funktion zur Auswertung
function [periodendauer, frequenz] = frequenzbestimmung(tabelle)
    frequenz=0;periodendauer=0;k=1;diff=[0; 0];
    for m=1:2
        while (1)
            if(tabelle(k,2) >= 0 && tabelle(k+1,2) < 0)
                break
            end
            k=k+1;
        end
        diff(m)=tabelle(k,1);
        k=k+10;
    end
    periodendauer=(diff(2,1)-diff(1,1));
    frequenz=1/((diff(2,1)-diff(1,1))*10^-3);
end