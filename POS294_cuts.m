%====================================================================================================
%%POS294

%==================================================================
% Karte zeichnen für POS294
%% Todo
% Karte falsch? Punkte auf dem Land?
%% Start
clc
clear all
close all
load pos294_ctd

% Initialize he projection. 
m_proj('oblique mercator','longitudes',[min(ctd_lon) max(ctd_lon)],'latitudes',[max(ctd_lat) min(ctd_lat)],'direction','vertical','aspect',.5);
% Filled coastlines drawn, using the 'patch' option
m_coast('patch',[.7 .7 .7],'edgecolor','none');
% The third line superimposes a grid.
m_grid get
% Converting longitude & latitude to X&Y Values
[X,Y]=m_ll2xy(ctd_lon,ctd_lat,'clip',('off'));
% Show and label Station values
line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-');
for i=1:length(ctd_station)
% text(X(i),Y(i),num2str(ctd_station(i)),'vertical','top');
text(X(i),Y(i),num2str(i),'vertical','top');
end


%%% AUSWERTUNG- Bitte noch einmal bei den Farbskalen schauen, ich finde den Fehler nicht

%% Start
clc
clear all
close all
load pos294_ctd


%% globale Einstellungen & feste Variablen
Xs = ctd_station;
Ys = ctd_prs;

% Stationen von POS294 bei
Start = [1  34 49 76  86 102 111 136 152 156 163 181 194 205 219];
End   = [33 49 75 85 101 110 135 151 155 162 180 193 204 219 233];
%%% TEMPERATUR
Zs = ctd_temp;
% Anzahl der Konturlinien regulieren
% hierzu Vektor mit Wertebereich definieren
lo_lim_t=round(nanmin(nanmin(Zs')));
up_lim_t=round(nanmax(nanmax(Zs')));
res_t=1;
s_scale_t=lo_lim_t:res_t:up_lim_t;
% Konturlinien hervorheben
s_line_t=[0 5 10];

%% Gesamt Plot
figure(1)
subplot(2,1,1)
contourf(Xs,Ys(174,1:1366),Zs(:,1:1366)')
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
% Konturlinien hervorheben
[C h]=contour(Xs,Ys(174,1:1366),Zs(:,1:1366)',s_line_t,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung der Temperatur')

%% Plot einzelner Stationen
for Station=1:length(Start)

% Tiefsten Messwert finden
[M,I]       = max(ctd_prs,[],2);
deepest = max(I(Start(Station):End(Station)));

X = Xs(Start(Station):End(Station));
Y = Ys(174,1:deepest);
Z = Zs(Start(Station):End(Station),1:deepest)';

figure(Station+1)
subplot(2,1,1)
contourf(X,Y,Z)

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
[C h]=contour(X,Y,Z,s_line_t,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung der Temperatur')
end

%%% SALZGEHALT
Ss = ctd_salt;
% Anzahl der Konturlinien regulieren
% hierzu Vektor mit Wertebereich definieren
lo_lim_s=round(nanmin(nanmin(Ss')));
up_lim_s=round(nanmax(nanmax(Ss')));
res_s=0.5;
s_scale_s=lo_lim_s:res_s:up_lim_s;
% Konturlinien hervorheben
s_line_s=32:1:35;

%% Gesamt Plot
figure(1)
subplot(2,1,2)
contourf(Xs,Ys(174,1:1366),Ss(:,1:1366)')
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
[C h]=contour(Xs,Ys(174,1:1366),Ss(:,1:1366)',s_line_s,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung des Salzgehaltes')

%% Plot einzelner Stationen
for Station=1:length(Start)

% Tiefsten Messwert finden
[M,I]       = max(ctd_prs,[],2);
deepest = max(I(Start(Station):End(Station)));

X = Xs(Start(Station):End(Station));
Y = Ys(174,1:deepest);
S = Ss(Start(Station):End(Station),1:deepest)';

figure(Station+1)
subplot(2,1,2)
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
[C h]=contour(X,Y,S,s_line_s,'k','linewidth',3);
% Konturlinien beschriften
hl=clabel(C,h);
set(hl,'FontSize',10,'FontWeight','demi','color','k');
% Box als Hintergrund für Label malen
set(hl,'BackgroundColor',[1 1 1],'Edgecolor',[.7 .7 .7]);
xlabel('Messstation')
ylabel('Druck')
title(' Darstellung des Salzgehaltes')
end
