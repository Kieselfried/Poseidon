% ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% T-S-Diagramme
% Für Pos294


clear all
clc
load POS294_ctd.mat

d = 100;

%% Grönland-Island
figure(1)
plot(ctd_salt(1:33,1:d),ctd_temp(1:33,1:d),'r.',ctd_salt(1:33,d:1366),ctd_temp(1:33,d:1366),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Grönland - Island (St. 678 - 710)')

%% Island - Färöer #1
figure(2)
plot(ctd_salt(34:75,1:d),ctd_temp(34:75,1:d),'r.',ctd_salt(34:75,d:1366),ctd_temp(34:75,d:1366),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Island - Färöer (St. 711 - 752)')

%% Island - Färöer #2
figure(3)
plot(ctd_salt(86:151,1:d),ctd_temp(86:151,1:d),'r.',ctd_salt(86:151,d:1366),ctd_temp(86:151,d:1366),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Island - Färöer (St. 766 - 831)')

%% Färöer-Bank-Kanal
figure(4)
plot(ctd_salt(163:233,1:d),ctd_temp(163:233,1:d),'r.',ctd_salt(163:233,d:1366),ctd_temp(163:233,d:1366),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Färöer-Bank-Kanal (St. 850 - 920)')
