%% Notizen zum Vector Diagramm
% Keine LADCP Daten von POS294 zu DMS
% ctd_station Nummer stimm überein mit  ladcp_station, allerdings nur in Nummer, nicht in der Array Groesse

%%Im folgenden ein erster Versuch zum Plotten der ladcp Daten in der Dänemarkstrasse:

%%%Island Faroe Ridge - die Velocity Schnitte
%##########################################################################
clear all
close all

for k=1:2
clearvars -except k
plot_velo=1;
print_velo=0;

Fahrt={'POS294'
       'POS303'
       'POS471'
       };

ladcp={'pos294_ladcp'
       'pos303_ladcp'
       'pos471_ladcp'
       };

load(ladcp{k})

stations=[[766 790 816 830]; % Poseidon Cruise 294
          [705 -99 -99 736]; % Poseidon Cruise 303
%          [760 -99 -99 765]; % Poseidon Cruise 471
          ];

% Variablen auf relevante Stationen reduzieren
cutout=[ladcp_station(find(ladcp_station<stations(k,1))) ladcp_station(find(ladcp_station==stations(k,2)+1):find(ladcp_station==stations(k,3)-1)) ladcp_station(find(ladcp_station>stations(k,4)))];
cut_stations=ladcp_station;
cut_stations(find(ismember(ladcp_station,cutout)))=[];
cut_ladcp_lon=ladcp_lon;
cut_ladcp_lon(find(ismember(ladcp_station,cutout)))=[];
cut_ladcp_lat=ladcp_lat;
cut_ladcp_lat(find(ismember(ladcp_station,cutout)))=[];
ladcp_depth=ladcp_depth(:,find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,end)));

% Distanz zwischen Stationen (
% Faengt bei Null an und wird in Kilometern kumulativ berechnet)
dist=cumsum([0 gsw_distance(cut_ladcp_lon,cut_ladcp_lat)]/1000);

% auf gleichmaessiges Gitter interpolieren
% vertikal in dBar
Depth=1:1:max(max(ladcp_depth));

% Arrays erstellen um Rechenpower zu sparen
veloI=(zeros(length(Depth),length(dist)));           
ladcp_u_corrI=(zeros(length(Depth),length(dist))); 
ladcp_v_corrI=(zeros(length(Depth),length(dist))); 

% vertikale Interpolation
for ii = 1:length(cut_stations(:));

    % Werte finden die nicht NaN sind
    ind=find(~isnan(ladcp_depth(:,ii))==1);

    % auf neues Gitter interpolieren
    ladcp_u_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_u_corr(ind,ii),Depth);
    ladcp_v_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_v_corr(ind,ii),Depth);
    
end

% maximale Geschwindigkeit berechnen (fuer Colorbar Skala)
v_max=max([max(max(abs(ladcp_u_corrI))) max(max(abs(ladcp_v_corrI)))]);

% Colormap erstellen
mincolor    = [1 0 0]; % red
mediancolor = [1 1 1]; % white   
maxcolor    = [0 0 1]; % blue         

ColorMapSize = 16;
int1 = zeros(ColorMapSize,3); 
int2 = zeros(ColorMapSize,3);

for i=1:3
    int1(:,i) = linspace(mincolor(i), mediancolor(i), ColorMapSize);
    int2(:,i) = linspace(mediancolor(i), maxcolor(i), ColorMapSize);
end

meep = [int1(1:end-1,:); int2];


%% Schnitte Plotten (West-East)
if plot_velo==1
    figure(k)
    
    subplot(1,2,1)
    contourf(dist,Depth,ladcp_u_corrI)
    set(gca,'YDir','reverse') 
    
    % Titel- und Achsenbeschriftung
    title(strcat(Fahrt(k),', Island Faroe Ridge (West-East)'))
    xlabel('Distance [km]')
    ylabel('Depth [dBar]')
% SKALA
% ANPASSEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    colormap(meep)
    colorbar('southoutside');
    caxis([-v_max v_max])
end

%% Schnitte Plotten (South-North)
if plot_velo==1
    figure(k)
    subplot(1,2,2)
    contourf(dist,Depth,ladcp_v_corrI)
    set(gca,'YDir','reverse') 
    
    % Titel- und Achsenbeschriftung
    title(strcat(Fahrt(k),', Island Faroe Ridge (South-North)'))
    xlabel('Distance [km]')
    ylabel('Depth [dBar]')
    
    colormap(meep)
    colorbar('southoutside');
    caxis([-v_max v_max])
end

end
