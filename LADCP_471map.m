% Karten fuer 471
clc
clear all
close all
load pos471_ctd
load pos471_ladcp

drucken=0;

% Colormap erstellen
mincolor    = [	0, 60, 153]/255; % red
mediancolor = [	102, 142, 204]/255; % white   
maxcolor    = [204, 224, 255]/255; % blue      

ColorMapSize = 16;
int1 = zeros(ColorMapSize,3); 
int2 = zeros(ColorMapSize,3);

for i=1:3
    int1(:,i) = linspace(mincolor(i), mediancolor(i), ColorMapSize);
    int2(:,i) = linspace(mediancolor(i), maxcolor(i), ColorMapSize);
end

oceano = [int1(1:end-1,:); int2];

%% Denmark Strait (St. 718-729)

figure(1)
% Karte initialisieren
m_proj('miller','long',[-33.5 -19.5],'lat',[63.5 69.5]);
% m_proj('miller','long',[min(ctd_lon) max(ctd_lon)],'lat',[min(ctd_lat) max(ctd_lat)]);
% Bathymetrie High Resolution Textur
m_etopo2('contourf',(-5000:100:0));
% Coastline High Resolution Textur
m_gshhs_f('patch',[.5 .5 .5]);
% Grid einfuegen und Axen anpassen
m_grid('xtick',6,'yaxislocation','right')

% Colorbar
colormap(oceano)
c = colorbar('southoutside');
c.Label.String = 'Depth [m]';

% Titel
title('Poseidon Cruise 471: Denmark Strait');

% CTD_Stations-Beschriftung
% stationen=(find(ctd_station==718):find(ctd_station==729));
stationen=(find(ctd_station==min(ctd_station)):find(ctd_station==max(ctd_station)));

[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));

for i=1:length(stationen)
%     text(X(i),Y(i),num2str(ctd_station(stationen(i))),'vertical','top','horizontal','right');
end

% LADCP_Stations-Beschriftung
% stationen=(find(ladcp_station==718):find(ladcp_station==729));
stationen=(find(ladcp_station==min(ladcp_station)):find(ladcp_station==max(ladcp_station)));

[X,Y]=m_ll2xy(ladcp_lon(stationen),ladcp_lat(stationen),'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','g','linestyle','-','linewidth',2);
[X,Y]=m_ll2xy(ladcp_lon(stationen),ladcp_lat(stationen),'clip',('off'));
for i=1:length(stationen)
    text(X(i),Y(i),num2str(ladcp_station(stationen(i))),'vertical','top','horizontal','right');
end

% Notable Cities
cities={' Tòrshavn',' Reykjavík'};
lons=[ -6.781479  -21.831501];
lats=[  62.009060 64.132114];
[X,Y]=m_ll2xy(lons,lats,'clip',('off'));
line(X(1),Y(1),'marker','o','color','r','linewidth',2)
text(X(1),Y(1),cities(1),'color','r','linewidth',2,'horizontal','left')
line(X(2),Y(2),'marker','o','color','r','linewidth',2)
text(X(2),Y(2),cities(2),'color','r','linewidth',2,'horizontal','left')


%% ISL-FAE (St.751-759; 760-765; 766-773)

figure(2)
set(gcf,'color',[0.5 0.5 0.5])
% Karte initialisieren
m_proj('miller','long',[-14.5 -5.5],'lat',[61 66]);
% m_proj('miller','long',[min(ctd_lon) max(ctd_lon)],'lat',[min(ctd_lat) max(ctd_lat)]);
% Bathymetrie High Resolution Textur
m_etopo2('contourf',(-5000:100:0));
% Coastline High Resolution Textur
m_gshhs_f('patch',[.5 .5 .5]);
% Grid einfuegen und Axen anpassen
m_grid('xtick',6,'yaxislocation','right')

% Colorbar
colormap(oceano)
c = colorbar('southoutside');
c.Label.String = 'Depth [m]';

% Titel
title('Poseidon Cruise 471: Island - Faroe');

% % Stations-Beschriftung
% stationen=(32:40);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
% stationen=([32 40]);
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','bottom','horizontal','right');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','top','horizontal','left');
% 
% stationen=(41:46);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
% stationen=([41 46]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','bottom','horizontal','right');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','top','horizontal','left');
% 
% stationen=(47:54);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
% stationen=([47 54]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','bottom','horizontal','right');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','top','horizontal','left');

% CTD_Stations-Beschriftung
stationen=(find(ctd_station==751):find(ctd_station==773));
% stationen=(find(ctd_station==min(ctd_station)):find(ctd_station==max(ctd_station)));
[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% for i=1:length(stationen)
%     text(X(i),Y(i),num2str(ctd_station(stationen(i))),'vertical','top','horizontal','right');
% end

% LADCP_Stations-Beschriftung
% stationen=(find(ladcp_station==764):find(ladcp_station==772));
stationen=(find(ladcp_station==min(ladcp_station)):find(ladcp_station==max(ladcp_station)));
[X,Y]=m_ll2xy(ladcp_lon(stationen),ladcp_lat(stationen),'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','g','linestyle','-','linewidth',2);
[X,Y]=m_ll2xy(ladcp_lon(stationen),ladcp_lat(stationen),'clip',('off'));
for i=1:length(stationen)
    text(X(i),Y(i),num2str(ladcp_station(stationen(i))),'vertical','top','horizontal','right');
end

% Notable Cities
cities={' Tòrshavn',' Reykjavík'};
lons=[ -6.781479  -21.831501];
lats=[  62.009060 64.132114];
[X,Y]=m_ll2xy(lons,lats,'clip',('off'));
line(X(1),Y(1),'marker','o','color','r','linewidth',2)
text(X(1),Y(1),cities(1),'color','r','linewidth',2,'horizontal','left')
line(X(2),Y(2),'marker','o','color','r','linewidth',2)
text(X(2),Y(2),cities(2),'color','r','linewidth',2,'horizontal','left')

%% Als PDF Abspeichern
if drucken==1
    filename = strcat ('POS471_DMS.png');
    print(1,'-dpng',filename)
    filename = strcat ('POS471_ISLFAE.png');
    print(2,'-dpng',filename)
%     filename = strcat ('POS471_FBC.png');
%     print(3,'-dpng',filename)
end
