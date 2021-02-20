close all;
clear all;
clc;

ensembleNo = 1;
metricThreshold = 100;
normThreshold = 1000;

dataFile = sprintf('ensemble%dEddies.nc',ensembleNo);
surfaces = logical(zeros(500,500,60));

for timestep = 1:60
    bed = ncread(dataFile, 'isEddy', [1,1,1,timestep], [inf,inf,1,1]);
    bed = fliplr(single(bed));
    bed = bed';
    surfaces(:,:,timestep) = logical(bed);
    % imwrite(bed,sprintf('Ensemble%d/Ensemble%dTimestep%d.png',ensembleNo,ensembleNo,timestep));
end

ts1 = 2;
ts2 = 3;

featurePoints1  = detectSURFFeatures(surfaces(:,:,ts1),'MetricThreshold',metricThreshold);
featurePoints2 = detectSURFFeatures(surfaces(:,:,ts2),'MetricThreshold',metricThreshold);

[featuresIn   validPtsIn]  = extractFeatures(surfaces(:,:,ts1),  featurePoints1);
[featuresOut validPtsOut]  = extractFeatures(surfaces(:,:,ts2), featurePoints2);

index_pairs = matchFeatures(featuresIn, featuresOut);

matchedPoints1 = validPtsIn(index_pairs(:,1));
matchedPoints2 = validPtsOut(index_pairs(:,2));
[m,~] = size(matchedPoints2.Location);
for i = 1:m
    if(norm(matchedPoints1.Location(i,:)-matchedPoints2.Location(i,:)) > normThreshold)
        matchedPoints1.Location(i,1) = 0.1;
        matchedPoints2.Location(i,1) = 0.1;
        matchedPoints1.Location(i,2) = 0.1;
        matchedPoints2.Location(i,2) = 0.1;
    end
end

figure; ax = axes; 
showMatchedFeatures(surfaces(:,:,ts1), surfaces(:,:,ts2), matchedPoints1,matchedPoints2,'montage','Parent',ax);
legend(ax,'matchedPoints1','matchedPoints2');       
