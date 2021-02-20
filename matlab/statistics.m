close all;
clear all;
clc;

noOfEnsemble = 7;

Births = zeros(59,noOfEnsemble);
Deaths = zeros(59,noOfEnsemble);
Splits = zeros(59,noOfEnsemble);
Merges = zeros(59,noOfEnsemble);

tic;
for ensembleNo = 1%:noOfEnsemble   
    dataFile = sprintf('ensemble%dEddies.nc',ensembleNo);
    prev = bwconncomp(ncread(dataFile, 'isEddy', [1,1,1,1], [inf,inf,1,1]));
    for timestamp = 2%:60
        startLoc = [1,1,1,timestamp];
        countLoc = [inf,inf,1,1];
        curr = bwconncomp(ncread(dataFile, 'isEddy', startLoc, countLoc));
        
        [~,prevCount] = size(prev.PixelIdxList);
        [~,currCount] = size(curr.PixelIdxList);
        
        overlap = uint8(zeros(prevCount,currCount));
        
        for i = 1:prevCount
            for j = 1:currCount
                [intersectionPixelCount,~] = size(intersect(prev.PixelIdxList{i},curr.PixelIdxList{j}));
                if intersectionPixelCount > 0
                    overlap(i,j) = 1;
                end
            end
        end
        
        noPrevOverlap = sum(overlap,2);
        noCurrOverlap = sum(overlap);
        
        % deaths
        Deaths(timestamp-1,ensembleNo) = sum( noPrevOverlap == 0 );
        % births
        Births(timestamp-1,ensembleNo) = sum( noCurrOverlap == 0 );
        
        prev = curr;
    end
end
toc;

figure();
for i = 1%:noOfEnsemble
    plot(2:60,Births(:,i),'-o');
    hold on;
end
title('Births');
xlabel('Timestamp');
ylabel('Number of Eddies');
legend('Ensemble 1','Ensemble 2','Ensemble 3','Ensemble 4','Ensemble 5',...
    'Ensemble 6','Ensemble 7');

figure();
for i = 1%:noOfEnsemble
    plot(2:60,Deaths(:,i),'-o');
    hold on;
end
title('Deaths');
xlabel('Timestamp');
ylabel('Number of Eddies');
legend('Ensemble 1','Ensemble 2','Ensemble 3','Ensemble 4','Ensemble 5',...
    'Ensemble 6','Ensemble 7');