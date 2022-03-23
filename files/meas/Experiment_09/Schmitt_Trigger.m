figure(1)
subplot(2,1,1)
plot(time_4_7,Vn002_4_7,'DisplayName','Vn002')
hold on
plot(time_4_7,Vvf1_4_7,'DisplayName','Vvf1')
hold on
plot(time_4_7,Vvf2_4_7,'DisplayName','Vvf2')
hold on
plot(time_4_7,Vvg1_4_7,'DisplayName','Vvg1')
hold off
legend
xlabel('Zeit in s');
ylabel('Spannung in V');
title('R4 = 4.7')

%h=legend('Vn002','Vvf1','Vvf2','Vvg1');
%set(h,'FontSize',15)
subplot(2,1,2)
plot(time_20,Vn002_20)
hold on
plot(time_20,Vvf1_20)
hold on
plot(time_20,Vvf2_20)
hold on
plot(time_20,Vvg1_20)
xlabel('Zeit in s');
ylabel('Spannung in V');
title('R4 = 20K')
%h=legend('Vn002','Vvf1','Vvf2','Vvg1');
%set(h,'FontSize',15)