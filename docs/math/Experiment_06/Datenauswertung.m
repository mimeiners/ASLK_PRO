clc;
clear all;
close all;
tabelle1 = csvread('Messung1_1.CSV',1,0);
tabelle1(:,1)=tabelle1(:,1)+10^(-3);
tabelle2 = csvread('Messung1_2.CSV',1,0);
tabelle2(:,1)=tabelle2(:,1)+10^(-3);
tabelle3 = csvread('Messung2_1.CSV',1,0);
tabelle3(:,1)=tabelle3(:,1)+3*10^(-3);
tabelle4 = csvread('Messung2_2.CSV',1,0);
tabelle4(:,1)=tabelle4(:,1)+3*10^(-3);
tabelle5 = csvread('Messung3_1.CSV',1,0);
tabelle5(:,1)=tabelle5(:,1)+10^(-3);
tabelle6 = csvread('Messung3_2.CSV',1,0);
tabelle6(:,1)=tabelle6(:,1)+10^(-3);
tabelle7 = csvread('Messung4_1.CSV',1,0);
tabelle7(:,1)=tabelle7(:,1)+3*10^(-3);
tabelle8 = csvread('Messung4_2.CSV',1,0);
tabelle8(:,1)=tabelle8(:,1)+3*10^(-3);
tabelle9 = csvread('Messung5_1.CSV',1,0);
tabelle9(:,1)=tabelle9(:,1)+10^(-3);
tabelle10 = csvread('Messung5_2.CSV',1,0);
tabelle10(:,1)=tabelle10(:,1)+10^(-3);
tabelle11 = csvread('Messung6_1.CSV',1,0);
tabelle11(:,1)=tabelle11(:,1)+3*10^(-3);
tabelle12 = csvread('Messung6_2.CSV',1,0);
tabelle12(:,1)=tabelle12(:,1)+3*10^(-3);
tabelle13 = csvread('Messung7_1.CSV',1,0);
tabelle13(:,1)=tabelle13(:,1)+10^(-3);
tabelle14 = csvread('Messung7_2.CSV',1,0);
tabelle14(:,1)=tabelle14(:,1)+10^(-3);
tabelle15 = csvread('Messung8_1.CSV',1,0);
tabelle15(:,1)=tabelle15(:,1)+3*10^(-3);
tabelle16 = csvread('Messung8_2.CSV',1,0);
tabelle16(:,1)=tabelle16(:,1)+3*10^(-3);
tabelle17 = csvread('Messung9_1.CSV',1,0);
tabelle17(:,1)=tabelle17(:,1)+10^(-3);
tabelle18 = csvread('Messung9_2.CSV',1,0);
tabelle18(:,1)=tabelle18(:,1)+10^(-3);
tabelle19 = csvread('Messung10_1.CSV',1,0);
tabelle19(:,1)=tabelle19(:,1)+3*10^(-3);
tabelle20 = csvread('Messung10_2.CSV',1,0);
tabelle20(:,1)=tabelle20(:,1)+3*10^(-3);

simtabelle1 = csvread('Simulation1.CSV');
simtabelle1 = anpassung(simtabelle1,tabelle9);
simtabelle2 = csvread('Simulation2.CSV');
simtabelle2(:,1)=simtabelle2(:,1)+2*10^(-3);
simtabelle2 = anpassung(simtabelle2,tabelle7);
simtabelle3= csvread('Simulation3.CSV');
simtabelle3 = anpassung(simtabelle3,tabelle1);
simtabelle4 = csvread('Simulation4.CSV');
simtabelle4(:,1)=simtabelle4(:,1)+2*10^(-3);
simtabelle4 = anpassung(simtabelle4,tabelle3);
simtabelle5= csvread('Simulation5.CSV');
simtabelle5 = anpassung(simtabelle5,tabelle5);

tabelle1(:,1)=tabelle1(:,1)*10^3;
tabelle2(:,1)=tabelle2(:,1)*10^3;
tabelle3(:,1)=tabelle3(:,1)*10^3;
tabelle4(:,1)=tabelle4(:,1)*10^3;
tabelle5(:,1)=tabelle5(:,1)*10^3;
tabelle6(:,1)=tabelle6(:,1)*10^3;
tabelle7(:,1)=tabelle7(:,1)*10^3;
tabelle8(:,1)=tabelle8(:,1)*10^3;
tabelle9(:,1)=tabelle9(:,1)*10^3;
tabelle10(:,1)=tabelle10(:,1)*10^3;
tabelle11(:,1)=tabelle11(:,1)*10^3;
tabelle12(:,1)=tabelle12(:,1)*10^3;
tabelle13(:,1)=tabelle13(:,1)*10^3;
tabelle14(:,1)=tabelle14(:,1)*10^3;
tabelle15(:,1)=tabelle15(:,1)*10^3;
tabelle16(:,1)=tabelle16(:,1)*10^3;
tabelle17(:,1)=tabelle17(:,1)*10^3;
tabelle18(:,1)=tabelle18(:,1)*10^3;
tabelle19(:,1)=tabelle19(:,1)*10^3;
tabelle20(:,1)=tabelle20(:,1)*10^3;
simtabelle1(:,1)=simtabelle1(:,1)*10^3;
simtabelle2(:,1)=simtabelle2(:,1)*10^3;
simtabelle3(:,1)=simtabelle3(:,1)*10^3;
simtabelle4(:,1)=simtabelle4(:,1)*10^3;
simtabelle5(:,1)=simtabelle5(:,1)*10^3;

figure(1);
p1=plot(tabelle9(:,1), tabelle9(:,2), simtabelle1(:,1), simtabelle1(:,2), tabelle10(:,1), tabelle10(:,2), tabelle7(:,1), tabelle7(:,2), simtabelle2(:,1), simtabelle2(:,2), tabelle8(:,1), tabelle8(:,2));
ax = ancestor(p1(1), 'axes');
p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;p1(5).LineWidth = 4;p1(6).LineWidth = 4;
ax.FontSize = 20;
xlabel('Zeit / ms','Fontsize',20)
ylabel('Spannung / V','Fontsize',20)
title('Voltage - Controlled Oscillator Nr.1','Color','k','FontSize',20)
legend('Ausgang Messung 9,78 V','Ausgang Simulation 9,78 V', 'Eingang Messung 9,78 V','Ausgang Messung 8 V','Ausgang Simulation 8 V', 'Eingang Messung 8 V','Location', 'east')
grid on

figure(2);
p1=plot(tabelle1(:,1),tabelle1(:,2), simtabelle3(:,1), simtabelle3(:,2), tabelle2(:,1),tabelle2(:,2),tabelle3(:,1),tabelle3(:,2), simtabelle4(:,1), simtabelle4(:,2), tabelle4(:,1),tabelle4(:,2));
ax = ancestor(p1(1), 'axes');
p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;p1(5).LineWidth = 4;p1(6).LineWidth = 4;
ax.FontSize = 20;
xlabel('Zeit / ms','Fontsize',20)
ylabel('Spannung / V','Fontsize',20)
title('Voltage - Controlled Oscillator Nr.2','Color','k','FontSize',20)
legend('Ausgang Messung 6 V','Ausgang Simulation 6 V', 'Eingang Messung 6 V','Ausgang Messung 4 V','Ausgang Simulation 4 V', 'Eingang Messung 4 V','Location', 'east')
grid on

figure(3);
p1=plot(tabelle5(:,1),tabelle5(:,2), simtabelle5(:,1), simtabelle5(:,2), tabelle6(:,1),tabelle6(:,2),tabelle11(:,1),tabelle11(:,2),tabelle12(:,1),tabelle12(:,2));
ax = ancestor(p1(1), 'axes');
p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;p1(5).LineWidth = 4;
ax.FontSize = 20;
xlabel('Zeit / ms','Fontsize',20)
ylabel('Spannung / V','Fontsize',20)
title('Voltage - Controlled Oscillator Nr.3','Color','k','FontSize',20)
legend('Ausgang Messung 2 V','Ausgang Simulation 2 V', 'Eingang Messung 2 V','Ausgang Messung 1,8 V', 'Eingang Messung 1,8 V','Location', 'east')
grid on

figure(4);
p1=plot(tabelle13(:,1),tabelle13(:,2),tabelle14(:,1),tabelle14(:,2),tabelle15(:,1),tabelle15(:,2),tabelle16(:,1),tabelle16(:,2));
ax = ancestor(p1(1), 'axes');
p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;
ax.FontSize = 20;
xlabel('Zeit / ms','Fontsize',20)
ylabel('Spannung / V','Fontsize',20)
title('Voltage - Controlled Oscillator Nr.4','Color','k','FontSize',20)
legend('Ausgang Messung 1,6 V', 'Eingang Messung 1,6 V','Ausgang Messung 1,4 V', 'Eingang Messung 1,4 V','Location', 'east')
grid on

figure(5);
p1=plot(tabelle17(:,1),tabelle17(:,2),tabelle18(:,1),tabelle18(:,2),tabelle19(:,1),tabelle19(:,2),tabelle20(:,1),tabelle20(:,2));
ax = ancestor(p1(1), 'axes');
p1(1).LineWidth = 4;p1(2).LineWidth = 4;p1(3).LineWidth = 4;p1(4).LineWidth = 4;
ax.FontSize = 20;
xlabel('Zeit / ms','Fontsize',20)
ylabel('Spannung / V','Fontsize',20)
title('Voltage - Controlled Oscillator Nr.5','Color','k','FontSize',20)
legend('Ausgang Messung 1,2 V', 'Eingang Messung 1,2 V','Ausgang Messung 1 V', 'Eingang Messung 1 V','Location', 'east')
grid on

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