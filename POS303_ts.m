% ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% T-S-Diagramme

% Für Pos303


clear all
clc
load POS303_ctd.mat

d = 100;

%% Grönland-Island
figure(1)
plot(ctd_salt(1:35,1:d),ctd_temp(1:35,1:d),'r.',ctd_salt(1:35,d:2292),ctd_temp(1:35,d:2292),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Grönland - Island (St. 649 - 683)')

%% Island - Färöer
figure(2)
plot(ctd_salt(53:94,1:d),ctd_temp(53:94,1:d),'r.',ctd_salt(53:94,d:2292),ctd_temp(53:94,d:2292),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Island - Färöer (St. 701 - 742)')

%% Färöer-Bank-Kanal
figure(3)
plot(ctd_salt(108:167,1:d),ctd_temp(108:167,1:d),'r.',ctd_salt(108:167,d:2292),ctd_temp(108:167,d:2292),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Färöer-Bank-Kanal (St. 756 - 815)')

%% Südöstlich Island
figure(4)
plot(ctd_salt([36:52 95:107],1:d),ctd_temp([36:52 95:107],1:d),'r.',ctd_salt([36:52 95:107],d:2292),ctd_temp([36:52 95:107],d:2292),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Südöstlich Island (St. 684 - 700 und 743 - 755)')



