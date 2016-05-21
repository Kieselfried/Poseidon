%% Todo
% Karte falsch oder blick ichs nicht? um 90* gedreht
% Farben?
% Portbarkeit auf andere Variablen-Pakete

%% Start
clc
clear all
close all

load KJ_2001_ctd

% Initialize he projection. 
m_proj('oblique mercator','longitudes',[min(ctd_lon) max(ctd_lon)],'latitudes',[max(ctd_lat) min(ctd_lat)],'direction','vertical','aspect',.5);
% Filled coastlines drawn, using the 'patch' option
m_coast('patch',[.7 .7 .7],'edgecolor','none');
% The third line superimposes a grid.
m_grid get
% Converting longitude & latitude to X&Y Values
[X,Y]=m_ll2xy(ctd_lon,ctd_lat,'clip',('off'));
line(X,Y,'marker','square','markersize',4,'color','r','linestyle','-');
for Station=1:length(ctd_station)
%     text(X(i),Y(i),num2str(ctd_station(i)),'vertical','top');
    text(X(Station),Y(Station),num2str(Station),'vertical','top');
end

%% Als PDF Abspeichern
filename = strcat ('KJ_2001_map.pdf');
print(1,'-dpdf',filename)
