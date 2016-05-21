%% TODO
% + automatische Stationsstarts (über m_maps?)
% + Interpolation der Bodenwerte und geschätzte Linie für Meeresboden
% + Beschriftung (Axen, evtl Titel)
% + bessere Anpassung (der Farbskala) an temp, salt, oxy
% * Anpassung für andere Variablen-Pakete (POS294, POS303, KJ2001)

%% Start
clc
clear all
close all
load pos471_ctd

%% globale Einstellungen & feste Variablen
Xs = ctd_station;
Ys = ctd_pres;
Zs = ctd_temp;

% Stationen bei
Start = [1 4  16 26 32 41 47 56 76];
End   = [3 15 25 31 40 46 54 75 80];

% Anzahl der Konturlinien regulieren
% hierzu Vektor mit Wertebereich definieren
lo_lim=nanmin(nanmin(Zs'));
up_lim=nanmax(nanmax(Zs'));
res=0.1;
s_scale=lo_lim:res:up_lim;
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale)-1));
% Konturlinien hervorheben
s_line=[0 10];

%% Gesamt Plot
contourf(Xs,Ys(1,:),Zs')
% Y Skala umdrehen
set(gca,'YDir','reverse')

% Farbskala 
h=colorbar('fontsize',12,'fontweight','b');
% Farbachse lässt sich so verschieben
caxis([min(s_scale) max(s_scale)]);
hold on
% Konturlinien hervorheben
[C h]=contour(Xs,Ys(1,:),Zs',s_line,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);

%% Plot einzelner Stationen
for Station=1:length(Start)

% Tiefsten Messwert finden
[M,I]       = max(ctd_pres,[],2);
deepest = max(I(Start(Station):End(Station)));

X = Xs(Start(Station):End(Station));
Y = Ys(1,1:deepest);
Z = Zs(Start(Station):End(Station),1:deepest)';

figure
contourf(X,Y,Z)

% Y Skala umdrehen
set(gca,'YDir','reverse')
% Farbskala 
h=colorbar('fontsize',12,'fontweight','b');
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale)-1));
% Farbachse lässt sich so verschieben
caxis([min(s_scale) max(s_scale)]);
hold on
% Konturlinien hervorheben
% s_line=[0 10];
[C h]=contour(X,Y,Z,s_line,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
end
