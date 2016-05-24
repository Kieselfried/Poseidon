% ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% T-S-Diagramme

% Für POS471


clear all
clc
load pos471_ctd.mat

d = 100;

%% Grönland-Island
figure(1)
plot(ctd_salt(3:31,1:d),ctd_temp(3:31,1:d),'r.',ctd_salt(3:31,d:2103),ctd_temp(3:31,d:2103),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Grönland - Island')

%% Östlich Island
figure(2)
plot(ctd_salt(32:54,1:d),ctd_temp(32:54,1:d),'r.',ctd_salt(32:54,d:2103),ctd_temp(32:54,d:2103),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Östlich Island (western valley)')


%% Südlich Färöer
figure(3)
plot(ctd_salt(56:75,1:d),ctd_temp(56:75,1:d),'r.',ctd_salt(56:75,d:2103),ctd_temp(56:75,d:2103),'b.')

legend('Oberhalb 100m','Unterhalb 100m','Location','northwest')
xlabel('Salzgehalt')
ylabel('Temperatur')
title('Südlich Färöer')
