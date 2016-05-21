%% Start
clc
clear all
close all
load pos303_ctd

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

%% Als PDF Abspeichern
filename = strcat ('POS303_map.pdf');
print(1,'-dpdf',filename)
