% ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% T-S-Diagramme
% Für KJ2001


clear all
clc
load KJ_2001_ctd.mat

d = 100;

%% Island - Färöer
figure(1)
plot(ctd_salt(1:70,1:d),ctd_temp(1:70,1:d),'r.',ctd_salt(1:70,d:1179),ctd_temp(1:70,d:1179),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Island - Färöer (St. 101 - 171)')

%% Färöer-Bank-Kanal
figure(2)
plot(ctd_salt(71:170,1:d),ctd_temp(71:170,1:d),'r.',ctd_salt(71:170,d:1179),ctd_temp(71:170,d:1179),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Färöer-Bank-Kanal (St. 172 - 271)')
