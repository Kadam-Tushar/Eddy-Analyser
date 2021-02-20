close all;
clear all;
clc;

noOfEnsemble = 7;

edd = zeros(60,1);

for ensembleNo = 1:noOfEnsemble   
    y = zeros(60,1);
    dataFile = sprintf('ensemble%dEddies.nc',ensembleNo);
    for timestamp = 1:60
        startLoc = [1,1,1,timestamp];
        countLoc = [inf,inf,1,1];

        newData = ncread(dataFile, 'isEddy', startLoc, countLoc);
        CC = bwconncomp(newData);
        y(timestamp) = CC.NumObjects;
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
