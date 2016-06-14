%% Notizen zum Vector Diagramm
% Keine LADCP Daten von POS294 zu DMS
% ctd_station Nummer stimm überein mit  ladcp_station, allerdings nur in Nummer, nicht in der Array Groesse

%%Im folgenden ein erster Versuch zum Plotten der ladcp Daten in der Dänemarkstrasse:

%%%Faroe Bank Channel - die Velocity Schnitte
%##########################################################################
clear all
close all

for k=1:2
clearvars -except k
plot_velo=1;
print_velo=1;

Fahrt={'POS294'
       'POS303'
       'POS471'
       };

% Daten laden
% ctd={'POS294_ctd'
%      'POS303_ctd'
%      'pos471_ctd'
%      };
 
ladcp={'pos294_ladcp'
       'pos303_ladcp'
       'pos471_ladcp'
       };
   
% load(ctd{k})
load(ladcp{k})

stations=[892 902; 
          764 772;
          0 0; % keine ladcp Daten fuer die DMS von POS471
          ];

%% East-West
% Variablen auf Schnitt reduzieren
ladcp_station=ladcp_station(find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
ladcp_lon=ladcp_lon((find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2))));
ladcp_lat=ladcp_lat((find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2))));
ladcp_depth=ladcp_depth(:,find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));

% absolute Geschwindigkeit berechnen
% velo=sqrt(ladcp_u_corr.^2.*ladcp_v_corr.^2);
% velo=ladcp_u_corr.*ladcp_v_corr;
velo=ladcp_u_corr;

% Distanz zwischen Stationen (
% Faengt bei Null an und wird in Kilometern kumulativ berechnet)
dist=cumsum([0 gsw_distance(ladcp_lon,ladcp_lat)]/1000);

%%
% auf gleichmaessiges Gitter interpolieren
% vertikal in dBar
Depth=1:1:max(max(ladcp_depth));

% vertikale Interpolation
veloI=(zeros(length(Depth),length(dist))); % VeloI erstellen um Rechenpower zu sparen

for ii = 1:length(find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
    % Werte finden die nicht NaN sind
    ind=find(~isnan(ladcp_depth(:,ii))==1);
    % auf neues Gitter interpolieren
    veloI(:,ii)=interp1(ladcp_depth(ind,ii),velo(ind,ii),Depth);
    ladcp_u_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_u_corr(ind,ii),Depth);
    ladcp_v_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_v_corr(ind,ii),Depth);

end

% Schnitte Plotten
if plot_velo==1
    figure(k)
    subplot(1,2,1)
    contourf(dist,Depth,veloI)
    set(gca,'YDir','reverse') 
    set(gca,'XDir','reverse') 
    
    % Titel- und Achsenbeschriftung
    title(strcat(Fahrt(k),', Faroe Bank Channel (West-East)'))
    xlabel('Distance [km]')
    ylabel('Depth [dBar]')
    
    % % Farbskala anpassen
    s_scale=-max(max(abs(veloI))):0.001:max(max(abs(veloI)));
    cm=colormap(jet(length(s_scale)));
    caxis([min(s_scale) max(s_scale)]);
    cb=colorbar('southoutside');
end

%% North-South
% Variablen auf Schnitt reduzieren
ladcp_station=ladcp_station(find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
ladcp_lon=ladcp_lon((find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2))));
ladcp_lat=ladcp_lat((find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2))));
ladcp_depth=ladcp_depth(:,find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));

% absolute Geschwindigkeit berechnen
% velo=sqrt(ladcp_u_corr.^2.*ladcp_v_corr.^2);
% velo=ladcp_u_corr.*ladcp_v_corr;
velo=ladcp_v_corr;

% Distanz zwischen Stationen (
% Faengt bei Null an und wird in Kilometern kumulativ berechnet)
dist=cumsum([0 gsw_distance(ladcp_lon,ladcp_lat)]/1000);

%%
% auf gleichmaessiges Gitter interpolieren
% vertikal in dBar
Depth=1:1:max(max(ladcp_depth));

% vertikale Interpolation
veloI=(zeros(length(Depth),length(dist))); % VeloI erstellen um Rechenpower zu sparen

for ii = 1:length(find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
    % Werte finden die nicht NaN sind
    ind=find(~isnan(ladcp_depth(:,ii))==1);
    % auf neues Gitter interpolieren
    veloI(:,ii)=interp1(ladcp_depth(ind,ii),velo(ind,ii),Depth);
    ladcp_u_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_u_corr(ind,ii),Depth);
    ladcp_v_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_v_corr(ind,ii),Depth);

end

% Schnitte Plotten
if plot_velo==1
    figure(k)
    subplot(1,2,2)
    contourf(dist,Depth,veloI)
    set(gca,'YDir','reverse') 
    set(gca,'XDir','reverse') 
    
    % Titel- und Achsenbeschriftung
    title(strcat(Fahrt(k),', Faroe Bank Channel (South-North)'))
    xlabel('Distance [km]')
    ylabel('Depth [dBar]')
    
    % % Farbskala anpassen
    s_scale=-max(max(abs(veloI))):0.001:max(max(abs(veloI)));
    cm=colormap(jet(length(s_scale)));
    caxis([min(s_scale) max(s_scale)]);
    cb=colorbar('southoutside');
end
if print_velo==1
    filename = strcat(Fahrt(k),'_FBC_velo.png');
    print(k,'-dpng',char(filename))
end
end
