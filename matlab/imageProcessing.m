close all;
clear all;
clc;

timestep = 60;

dataFile = sprintf('ensemble%dEddies.nc',1);
bed = ncread(dataFile, 'isEddy', [1,1,1,timestep], [inf,inf,1,1]);
bed = bed';

mymap = pcolor(1:500,1:500, bed);
mymap.EdgeAlpha = 0;
colorbar;

S = regionprops(bwconncomp(bed),'BoundingBox');

x = bed(230:270,228:269);
figure();
mymap = pcolor(1:42,1:41, x);

x = logical(x');
bed = logical(bed');
bedPoints = detectSURFFeatures(bed);
xPoints = detectSURFFeatures(x);
figure();
imshow(bed);
hold on;
plot(bedPoints.selectStrongest(34));

figure();
imshow(x);