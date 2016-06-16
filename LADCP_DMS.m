%% Notizen zum Vector Diagramm
% Keine LADCP Daten von POS294 zu DMS
% ctd_station Nummer stimm überein mit  ladcp_station, allerdings nur in Nummer, nicht in der Array Groesse

%%Im folgenden ein erster Versuch zum Plotten der ladcp Daten in der Dänemarkstrasse:

%%% Denmark Strait - die Velocity Schnitte
%##########################################################################
clear all
close all

for k=2:3
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

stations=[[-99 -99 -99 -99]; % keine LADCP Daten fuer die DMS von POS294
          [652 -99 -99 674]; % Poseidon Cruise 303
          [718 -99 -99 729]; % Poseidon Cruise 471
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
    title(strcat(Fahrt(k),', Denmark Strait (West-East)'))
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
    title(strcat(Fahrt(k),', Denmark Strait (South-North)'))
    xlabel('Distance [km]')
    ylabel('Depth [dBar]')
    
    colormap(meep)
    colorbar('southoutside');
    caxis([-v_max v_max])
end

end

% %% Notizen zum Vector Diagramm
% % Keine LADCP Daten von POS294 zu DMS
% % ctd_station Nummer stimm überein mit  ladcp_station, allerdings nur in Nummer, nicht in der Array Groesse
% 
% %%Im folgenden ein erster Versuch zum Plotten der ladcp Daten in der Dänemarkstrasse:
% 
% %%%Denmark Strait - die Velocity Schnitte
% %##########################################################################
% clear all
% close all
% 
% for k=2:3
% clearvars -except k
% plot_velo=1;
% print_velo=1;  
% 
% Fahrt={'POS294'
%        'POS303'
%        'POS471'
%        };
% 
% % Daten laden
% % ctd={'POS294_ctd'
% %      'POS303_ctd'
% %      'pos471_ctd'
% %      };
%  
% ladcp={'pos294_ladcp'
%        'pos303_ladcp'
%        'pos471_ladcp'
%        };
%    
% % load(ctd{k})
% load(ladcp{k})
% 
% stations=[0     0; % keine ladcp Daten fuer die DMS von POS294
%           652 674;
%           718 729;
%           ];
% 
% %% East-West
% % Variablen auf Schnitt reduzieren
% ladcp_station=ladcp_station(find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
% ladcp_lon=ladcp_lon((find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2))));
% ladcp_lat=ladcp_lat((find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2))));
% ladcp_depth=ladcp_depth(:,find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
% 
% % absolute Geschwindigkeit berechnen
% % velo=sqrt(ladcp_u_corr.^2.*ladcp_v_corr.^2);
% % velo=ladcp_u_corr.*ladcp_v_corr;
% velo=ladcp_u_corr;
% 
% % Distanz zwischen Stationen (
% % Faengt bei Null an und wird in Kilometern kumulativ berechnet)
% dist=cumsum([0 gsw_distance(ladcp_lon,ladcp_lat)]/1000);
% 
% 
% % auf gleichmaessiges Gitter interpolieren
% % vertikal in dBar
% Depth=1:1:max(max(ladcp_depth));
% 
% % vertikale Interpolation
% veloI=(zeros(length(Depth),length(dist))); % VeloI erstellen um Rechenpower zu sparen
% 
% for ii = 1:length(find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
%     % Werte finden die nicht NaN sind
%     ind=find(~isnan(ladcp_depth(:,ii))==1);
%     % auf neues Gitter interpolieren
%     veloI(:,ii)=interp1(ladcp_depth(ind,ii),velo(ind,ii),Depth);
%     ladcp_u_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_u_corr(ind,ii),Depth);
%     ladcp_v_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_v_corr(ind,ii),Depth);
% 
% end
% 
% % Schnitte Plotten
% if plot_velo==1
%     figure(k)
%     subplot(1,2,1)
%     contourf(dist,Depth,veloI)
%     set(gca,'YDir','reverse') 
%     set(gca,'XDir','reverse') 
%     
%     % Titel- und Achsenbeschriftung
%     title(strcat(Fahrt(k),' Denmark Strait (West-East)'))
%     xlabel('Distance [km]')
%     ylabel('Depth [dBar]')
%     
%     % % Farbskala anpassen
%     s_scale=-max(max(abs(veloI))):0.001:max(max(abs(veloI)));
%     cm=colormap(jet(length(s_scale)));
%     caxis([min(s_scale) max(s_scale)]);
%     cb=colorbar('southoutside');
% end
% % if print_velo==1
% %     filename = strcat(Fahrt(k),'_DMS_velo_EW.png');
% %     print(k,'-dpng',char(filename))
% % end
% 
% %% North-South
% % absolute Geschwindigkeit berechnen
% % velo=sqrt(ladcp_u_corr.^2.*ladcp_v_corr.^2);
% % velo=ladcp_u_corr.*ladcp_v_corr;
% velo=ladcp_v_corr;
% 
% % Distanz zwischen Stationen (
% % Faengt bei Null an und wird in Kilometern kumulativ berechnet)
% dist=cumsum([0 gsw_distance(ladcp_lon,ladcp_lat)]/1000);
% 
% 
% % auf gleichmaessiges Gitter interpolieren
% % vertikal in dBar
% Depth=1:1:max(max(ladcp_depth));
% 
% % vertikale Interpolation
% veloI=(zeros(length(Depth),length(dist))); % VeloI erstellen um Rechenpower zu sparen
% 
% for ii = 1:length(find(ladcp_station==stations(k,1)):find(ladcp_station==stations(k,2)));
%     % Werte finden die nicht NaN sind
%     ind=find(~isnan(ladcp_depth(:,ii))==1);
%     % auf neues Gitter interpolieren
%     veloI(:,ii)=interp1(ladcp_depth(ind,ii),velo(ind,ii),Depth);
%     ladcp_u_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_u_corr(ind,ii),Depth);
%     ladcp_v_corrI(:,ii)=interp1(ladcp_depth(ind,ii),ladcp_v_corr(ind,ii),Depth);
% 
% end
% 
% % Schnitte Plotten
% if plot_velo==1
%     figure(k)
%     subplot(1,2,2)
%     contourf(dist,Depth,veloI)
%     set(gca,'YDir','reverse') 
%     set(gca,'XDir','reverse') 
%     
%     % Titel- und Achsenbeschriftung
%     title(strcat(Fahrt(k),' Denmark Strait (South-North)'))
%     xlabel('Distance [km]')
%     ylabel('Depth [dBar]')
%     
%     % % Farbskala anpassen
%     s_scale=-max(max(abs(veloI))):0.001:max(max(abs(veloI)));
%     cm=colormap(jet(length(s_scale)));
%     caxis([min(s_scale) max(s_scale)]);
%     cb=colorbar('southoutside');
% end
% if print_velo==1
%     filename = strcat(Fahrt(k),'_DMS_velo.png');
%     print(k,'-dpng',char(filename))
% end
% 
% 
% 
% 
% end
