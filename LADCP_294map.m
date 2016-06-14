% Karten fuer POS 294
clc
clear all
close all
load POS294_ctd
load pos294_ladcp
ctd_lon=-ctd_lon;

drucken=0;

% %% ISL-GRE (678-710)
% 
% figure(1)
% % Karte initialisieren
% m_proj('miller','long',[-33.5 -19.5],'lat',[63.5 69.5]);
% % m_proj('miller','long',[min(ctd_lon) max(ctd_lon)],'lat',[min(ctd_lat) max(ctd_lat)]);
% % Bathymetrie High Resolution Textur
% m_etopo2('contourf',(-5000:100:0));
% % Coastline High Resolution Textur
% m_gshhs_f('patch',[.5 .5 .5]);
% % Grid einfuegen und Axen anpassen
% m_grid('xtick',6,'yaxislocation','right')
% 
% % Colorbar
% c = colorbar('southoutside');
% c.Label.String = 'Depth [m]';
% 
% % Titel
% title('Poseidon Cruise 294: Denmark Strait');
% 
% % Stations-Beschriftung
% stationen=(1:33);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
% stationen=([1 33]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','top','horizontal','left');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','bottom','horizontal','right');
% 
% % Notable Cities
% cities={' Tòrshavn',' Reykjavík'};
% lons=[ -6.781479  -21.831501];
% lats=[  62.009060 64.132114];
% [X,Y]=m_ll2xy(lons,lats,'clip',('off'));
% line(X(1),Y(1),'marker','o','color','r','linewidth',2)
% text(X(1),Y(1),cities(1),'color','r','linewidth',2,'horizontal','left')
% line(X(2),Y(2),'marker','o','color','r','linewidth',2)
% text(X(2),Y(2),cities(2),'color','r','linewidth',2,'horizontal','left')
    
    
%% ISL-FAE (711-752; 766-790; 816-831)
figure(2)
% Karte initialisieren
% m_proj('miller','long',[min(ctd_lon) max(ctd_lon)],'lat',[min(ctd_lat) max(ctd_lat)]);
m_proj('miller','long',[-14.5 -5.5],'lat',[61 66]);
% Bathymetrie High Resolution Textur
m_etopo2('contourf',(-5000:100:0));
% Coastline High Resolution Textur
m_gshhs_f('patch',[.5 .5 .5]);
% Grid einfuegen und Axen anpassen
m_grid('xtick',6,'yaxislocation','right')

% Colorbar
c = colorbar('southoutside');
c.Label.String = 'Depth [m]';

% Titel
title('Poseidon Cruise 294: Island - Faroe');

% % Stations-Beschriftung
% stationen=(34:75);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
% stationen=([34 75]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','bottom','horizontal','right');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','top','horizontal','left');
% 
% stationen=(86:110);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','g','linestyle','-','linewidth',2);
% stationen=([86 110]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','bottom','horizontal','left');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','bottom','horizontal','left');
% 
% stationen=(136:151);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','g','linestyle','-','linewidth',2);
% stationen=([136 151]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','top','horizontal','right');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','bottom','horizontal','left');

% CTD_Stations-Beschriftung
stationen=(find(ctd_station==705):find(ctd_station==736));
% stationen=(find(ctd_station==min(ctd_station)):find(ctd_station==max(ctd_station)));
[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% for i=1:length(stationen)
%     text(X(i),Y(i),num2str(ctd_station(stationen(i))),'vertical','top','horizontal','right');
% end

% LADCP_Stations-Beschriftung
stationen=[find(ladcp_station==766):find(ladcp_station==790) find(ladcp_station==816):find(ladcp_station==830)];
% stationen=(find(ladcp_station==min(ladcp_station)):find(ladcp_station==max(ladcp_station)));
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

%% FBC (753-764; 843-849; 892-902)
figure(3)
% Karte initialisieren
% m_proj('miller','long',[min(ctd_lon) max(ctd_lon)],'lat',[min(ctd_lat) max(ctd_lat)]);
m_proj('miller','long',[-9.5 -5.5],'lat',[60.5 62.5]);
% Bathymetrie High Resolution Textur
m_etopo2('contourf',(-5000:100:0));
% Coastline High Resolution Textur
m_gshhs_l('patch',[.5 .5 .5]);
% Grid einfuegen und Axen anpassen
m_grid('xtick',6,'yaxislocation','right')

% Colorbar
c = colorbar('southoutside');
c.Label.String = 'Depth [m]';

% Titel
title('Poseidon Cruise 294: Faroe Bank Channel')

% CTD_Stations-Beschriftung
stationen=(find(ctd_station==892):find(ctd_station==902));
[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-','linewidth',2);
[X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
for i=1:length(stationen)
    text(X(i),Y(i),num2str(ctd_station(stationen(i))),'vertical','top','horizontal','right');
end

% LADCP_Stations-Beschriftung
stationen=(find(ladcp_station==892):find(ladcp_station==902));
[X,Y]=m_ll2xy(ladcp_lon(stationen),ladcp_lat(stationen),'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','g','linestyle','-','linewidth',2);
[X,Y]=m_ll2xy(ladcp_lon(stationen),ladcp_lat(stationen),'clip',('off'));
for i=length(stationen)
    text(X(i),Y(i),num2str(ctd_station(stationen(i))),'vertical','top','horizontal','right');
end


% stationen=(205:215);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','b','linestyle','-','linewidth',2);
% stationen=([205 215]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','top','horizontal','left');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','top','horizontal','left');
% 
% stationen=(156:162);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% line(X,Y,'marker','square','markersize',4,'color','g','linestyle','-','linewidth',2);
% stationen=([156 162]);
% [X,Y]=m_ll2xy(ctd_lon(stationen),ctd_lat(stationen),'clip',('off'));
% text(X(1),Y(1),num2str(ctd_station(stationen(1))),'vertical','top','horizontal','left');
% text(X(2),Y(2),num2str(ctd_station(stationen(2))),'vertical','top','horizontal','left');
% 
% % Notable Cities
% cities={' Tòrshavn',' Reykjavík'};
% lons=[ -6.781479  -21.831501];
% lats=[  62.009060 64.132114];
% [X,Y]=m_ll2xy(lons,lats,'clip',('off'));
% line(X(1),Y(1),'marker','o','color','r','linewidth',2)
% text(X(1),Y(1),cities(1),'color','r','linewidth',2,'horizontal','left')
% line(X(2),Y(2),'marker','o','color','r','linewidth',2)
% text(X(2),Y(2),cities(2),'color','r','linewidth',2,'horizontal','left')

%% Als PDF Abspeichern
if drucken==1
    filename = strcat ('POS294_DMS.png');
    print(1,'-dpng',filename)
    filename = strcat ('POS294_ISLFAE.png');
    print(2,'-dpng',filename)
    filename = strcat ('POS294_FBC.png');
    print(3,'-dpng',filename)
end
