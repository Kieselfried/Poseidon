%% Notizen zum Vector Diagramm
% Keine LADCP Daten von POS294 zu DMS
% ctd_station Nummer stimm überein mit  ladcp_station, allerdings nur in Nummer, nicht in der Array Groesse

%%Im folgenden ein erster Versuch zum Plotten der ladcp Daten in der Dänemarkstrasse:

%%% Faroe Bank Channel - die Velocity Schnitte
%##########################################################################
clear all
close all

for cruise=1:1
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

load(ladcp{cruise})
stations=[[892 -99 -99 902]; % Poseidon Cruise 294
          [764 -99 -99 772]; % Poseidon Cruise 303
          [-99 -99 -99 -99]  % keine ladcp Daten fuer die DMS von POS471
          ];

% Variablen auf relevante Stationen reduzieren
cutout=[ladcp_station(find(ladcp_station<stations(cruise,1))) ladcp_station(find(ladcp_station==stations(cruise,2)+1):find(ladcp_station==stations(cruise,3)-1)) ladcp_station(find(ladcp_station>stations(cruise,4)))];
cut_stations=ladcp_station;
cut_stations(find(ismember(ladcp_station,cutout)))=[];
cut_ladcp_lon=ladcp_lon;
cut_ladcp_lon(find(ismember(ladcp_station,cutout)))=[];
cut_ladcp_lat=ladcp_lat;
cut_ladcp_lat(find(ismember(ladcp_station,cutout)))=[];
ladcp_depth=ladcp_depth(:,find(ladcp_station==stations(cruise,1)):find(ladcp_station==stations(cruise,end)));

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
    figure(cruise)
    subplot(1,2,1)
    contourf(dist,Depth,ladcp_u_corrI)
    set(gca,'YDir','reverse') 
    
    % Titel- und Achsenbeschriftung
    title(strcat(Fahrt(cruise),', Faroe Bank Channel (West-East)'))
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
    figure(cruise)
    subplot(1,2,2)
    contourf(dist,Depth,ladcp_v_corrI)
    set(gca,'YDir','reverse') 
    
    % Titel- und Achsenbeschriftung
    title(strcat(Fahrt(cruise),', Faroe Bank Channel (South-North)'))
    xlabel('Distance [km]')
    ylabel('Depth [dBar]')
    
    colormap(meep)
    colorbar('southoutside');
    caxis([-v_max v_max])
end

end
