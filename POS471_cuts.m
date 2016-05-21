%% TODO
% + automatische Stationsstarts (über m_maps?)
% + Interpolation der Bodenwerte und geschätzte Linie für Meeresboden
% + bessere Anpassung (der Farbskala) an temp, salt, oxy
% * Anpassung für andere Variablen-Pakete (POS294, POS303, KJ2001)

%% Start
clc
clear all
close all
load pos471_ctd

%%% FARBACHSEN EVENTUELL BEI DEN SUBPLOTS KORRIGIEREN

%% globale Einstellungen & feste Variablen
Xs = ctd_station;
Ys = ctd_pres;
Os = ctd_oxy;
Ts = ctd_temp;
Ss = ctd_salt;

% Stationen bei
Start = [1 4  16 26 32 41 47 56 76];
End   = [3 15 25 31 40 46 54 75 80];

%%
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%%% GESAMTPLOT
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% gesamt_Temperatur


% Anzahl der Konturlinien regulieren
% hierzu Vektor mit Wertebereich definieren
lo_lim_t=round(nanmin(nanmin(Ts')));
up_lim_t=round(nanmax(nanmax(Ts')));
res_t=1;
s_scale_t=lo_lim_t:res_t:up_lim_t;
% Konturlinien hervorheben
s_line_t=[0 10];

figure(1)
subplot(2,2,1)
contourf(Xs,Ys(1,:),Ts')
% Y Skala umdrehen
set(gca,'YDir','reverse')

% Farbskala 
%h_t=colorbar('fontsize',12,'fontweight','b');
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale_t)-1));
% Farbachse lässt sich so verschieben
caxis([min(s_scale_t) max(s_scale_t)]);
hold on
% Konturlinien hervorheben
[C h]=contour(Xs,Ys(1,:),Ts',s_line_t,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung der Temperatur')

%% gesamt_Sauerstoffgehalt

% Anzahl der Konturlinien regulieren
% hierzu Vektor mit Wertebereich definieren
lo_lim_o=round(nanmin(nanmin(Os')));
up_lim_o=round(nanmax(nanmax(Os')));
res_o=1;
s_scale_o=lo_lim_o:res_o:up_lim_o;
% Konturlinien hervorheben
s_line_o=0:1:13;


figure(1)
subplot(2,2,2)
contourf(Xs,Ys(1,:),Os')
% Y Skala umdrehen
set(gca,'YDir','reverse')

% Farbskala 
h=colorbar('fontsize',12,'fontweight','b');
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale_o)-1));
% Farbachse lässt sich so verschieben
caxis([min(s_scale_o) max(s_scale_o)]);
hold on
% Konturlinien hervorheben
[C h]=contour(Xs,Ys(1,:),Os',s_line_o,'k','linewidth',2);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung des Sauerstoffs')

%% gesamt_Salzgehalt


% Anzahl der Konturlinien regulieren
% hierzu Vektor mit Wertebereich definieren
lo_lim_s=round(nanmin(nanmin(Ss')));
up_lim_s=round(nanmax(nanmax(Ss')));
res_s=0.25;
s_scale_s=lo_lim_s:res_s:up_lim_s;
% Konturlinien hervorheben
s_line_s=31:1:35;


figure(1)
subplot(2,2,3)
contourf(Xs,Ys(1,:),Ss')
% Y Skala umdrehen
set(gca,'YDir','reverse')

% Farbskala 
h=colorbar('fontsize',12,'fontweight','b');
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale_s)-1));
% Farbachse lässt sich so verschieben
caxis([min(s_scale_s) max(s_scale_s)]);
hold on
% Konturlinien hervorheben
[C h]=contour(Xs,Ys(1,:),Ss',s_line_s,'k','linewidth',2);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung des Salzgehaltes')

%% Als PDF Abspeichern

filename = strcat ('POS471_gesamt.pdf');
%print(1,'-dpdf',filename)


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%%% EINZELNE STATIONEN
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
for Station=1:length(Start)
%% Temperatur
% Tiefsten Messwert finden
[M,I]       = max(ctd_pres,[],2);
deepest = max(I(Start(Station):End(Station)));

X = Xs(Start(Station):End(Station));
Y = Ys(1,1:deepest);
T = Ts(Start(Station):End(Station),1:deepest)';

figure(Station+1)
subplot(2,2,1)
contourf(X,Y,T)

% Y Skala umdrehen
set(gca,'YDir','reverse')
% Farbskala 
h=colorbar('fontsize',12,'fontweight','b');
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale_t)-1));
% Farbachse lässt sich so verschieben
caxis([min(s_scale_t) max(s_scale_t)]);
hold on
[C h]=contour(X,Y,T,s_line_t,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung der Temperatur')

%% Sauerstoffgehalt

% Tiefsten Messwert finden
[M,I]       = max(ctd_pres,[],2);
deepest = max(I(Start(Station):End(Station)));

X = Xs(Start(Station):End(Station));
Y = Ys(1,1:deepest);
O = Os(Start(Station):End(Station),1:deepest)';

figure(Station+1)
subplot(2,2,2)
contourf(X,Y,O)

% Y Skala umdrehen
set(gca,'YDir','reverse')
% Farbskala 
h=colorbar('fontsize',12,'fontweight','b');
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale_o)-1));
% Farbachse lässt sich so verschieben
caxis([min(s_scale_o) max(s_scale_o)]);
hold on
% Konturlinien hervorheben
s_line_o=0:1:13;
[C h]=contour(X,Y,O,s_line_o,'k','linewidth',2);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung des Sauerstoffs')

%% Salzgehalt

% Tiefsten Messwert finden
[M,I]       = max(ctd_pres,[],2);
deepest = max(I(Start(Station):End(Station)));

X = Xs(Start(Station):End(Station));
Y = Ys(1,1:deepest);
S = Ss(Start(Station):End(Station),1:deepest)';

figure(Station+1)
subplot(2,2,3)
contourf(X,Y,S)

% Y Skala umdrehen
set(gca,'YDir','reverse')
% Farbskala 
h=colorbar('fontsize',12,'fontweight','b');
% Farbpalette an Zahl der Konturlinien anpassen
% Farbpalette ist "jet"
cm=colormap(jet(length(s_scale_s)-1));
% Farbachse lässt sich so verschieben
caxis([min(s_scale_s) max(s_scale_s)]);
hold on
% Konturlinien hervorheben
s_line_s=31:1:35;
[C h]=contour(X,Y,S,s_line_s,'k','linewidth',2);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung des Salzgehaltes')

%% Als PDF Abspeichern
filename = strcat ('POS471_cut_',num2str(Xs(Start(Station))),'_to_',num2str(Xs(End(Station))),'.pdf');
% print(Station+1,'-dpdf',filename)
end



