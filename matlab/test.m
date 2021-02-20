% close all;
% clear all;
% clc;
% 
% dataFile = 'ensemble1Eddies.nc';
% 
% for timestamp = 45
%     startLoc = [1,1,1,timestamp];
%     countLoc = [inf,inf,inf,1];
% 
%     newData = ncread(dataFile, 'isEddy', startLoc, countLoc);
%     figure();
%     p = patch(isosurface(1:500,1:500,50:-1:1,newData,0.9));
%     isonormals(1:500,1:500,50:-1:1,newData,p);
%     p.FaceColor = 'red';
%     p.EdgeColor = 'none';
%     daspect([1 1 1]);
%     view(3);
%     axis tight;
%     camlight;
%     lighting gouraud;
% end


close all;
clear all;
clc;

noOfEnsemble = 7;

edd = zeros(60,1);

for ensembleNo = 1:noOfEnsemble   
    y = zeros(60,1);
    dataFile = sprintf('ensemble%dEddies.nc',ensembleNo);
    prev = ncread(dataFile, 'isEddy', [1,1,1,1], [inf,inf,1,1]);
    for timestamp = 2:60
        startLoc = [1,1,1,timestamp];
        countLoc = [inf,inf,1,1];

        newData = ncread(dataFile, 'isEddy', startLoc, countLoc);
        temp = newData.*prev;
        prev = newData;
        CC = bwconncomp(temp);
        y(timestamp) = CC.NumObjects;
        if( mod(y(timestamp),2) == 1)
            printf("ensemble %d, timestamp %d",ensembleNo,timestamp);
        end
    end
    yi = smooth(y);
    plot(1:60,yi,'-o');
    hold on;
    edd = edd  + y;
end

edd = edd/noOfEnsemble;
plot(1:60,smooth(edd),'-o','Color','k','LineWidth',2);

xlabel('Timestamp');
ylabel('Number of Eddies');
legend('Ensemble 1','Ensemble 2','Ensemble 3','Ensemble 4','Ensemble 5',...
    'Ensemble 6','Ensemble 7','Average');