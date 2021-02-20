clear all;
close all;
clc;
%% Parameters
dataFile = 'SciVisDataSet/ensembles/0001/COMBINED_2011013100.nc';
newFileName = 'ensemble1Eddies2.nc';
nbr = 15; % 9;
nu = 4; %5;
queueMaxElements = 125000;

%% New File Definition

% Open the file
ncid = netcdf.create(newFileName,'NC_WRITE');

% Define the dimensions
dimidt = netcdf.defDim(ncid,'time',60);
dimidlat = netcdf.defDim(ncid,'latitude',500);
dimidlon = netcdf.defDim(ncid,'longitude',500);
dimiddepth = netcdf.defDim(ncid,'depth',50);

% Define IDs for the dimension variables (pressure,time,latitude,...)
date_ID=netcdf.defVar(ncid,'time','double',[dimidt]);
latitude_ID=netcdf.defVar(ncid,'latitude','NC_FLOAT',[dimidlat]);
longitude_ID=netcdf.defVar(ncid,'longitude','NC_FLOAT',[dimidlon]);
depth_ID=netcdf.defVar(ncid,'depth','NC_FLOAT',[dimiddepth]);

% Define the main variable ()
isEddy_ID = netcdf.defVar(ncid,'isEddy','NC_BYTE',[dimidlon dimidlat dimiddepth dimidt]);

% We are done defining the NetCdf
netcdf.endDef(ncid);

%% Reading Data
longitude = ncread(dataFile, 'XC');
latitude = ncread(dataFile, 'YC');
depth = ncread(dataFile, 'Z_MIT40');
timeS = ncread(dataFile, 'T_AX');

%Then store the dimension variables in our new netCDF file
netcdf.putVar(ncid,date_ID,timeS);
netcdf.putVar(ncid,latitude_ID,latitude);
netcdf.putVar(ncid,longitude_ID,longitude);
netcdf.putVar(ncid,depth_ID,depth);

%% Per Timestamp Processing

for timestamp = 1:60
    % reading data from main file
    startLoc = [1,1,1,timestamp];
    countLoc = [inf,inf,inf,1];
    
    U = ncread(dataFile, 'U', startLoc, countLoc);
    V = ncread(dataFile, 'V', startLoc, countLoc);
    eta = ncread(dataFile, 'ETA', startLoc(2:end), countLoc(2:end));
    
    % processing data
    [gradUx, gradUy, ~] = gradient(U);
    [gradVx, gradVy, ~] = gradient(V);

    OW = (gradUy - gradVx).^2 + (gradVy + gradUx).^2 - (gradVy - gradUx).^2;
    
    sigma = std(OW(:,:,1),0,'all');
    
    %eddy centre detection
    OWcriticalPts = imregionalmin(OW(:,:,1));
    surfVmag = ((U(:,:,1)).^2 + (V(:,:,1)).^2);
    surfVcriticalPts = imregionalmin(surfVmag);
    etaCriticalPts = imregionalmin(eta) + imregionalmax(eta);

    fil = ones(nbr);
    
    OWcriticalPts = nbrOperation(OWcriticalPts,fil);
    surfVcriticalPts = nbrOperation(surfVcriticalPts,fil);
    etaCriticalPts = nbrOperation(etaCriticalPts,fil);
    OWpoints = OW(:,:,1) < -0.2*sigma;

    eddyCentres = ((OWcriticalPts .* surfVcriticalPts).* etaCriticalPts) .* OWpoints;
    [row2,col2] = find(eddyCentres);
    
    % Applying Geometric Constraints
    [m,n] = size(eddyCentres);
    count = size(row2);
    row = row2;
    col = col2;
    count2 = 0;
    for i = 1:count
        % Geometric Constraint 1
        signChange = 0;
        refVal = V(row2(i),col2(i),1);
        for x = max(row2(i)-nu,1):min(row2(i)+nu,m)
            if(V(x,col2(i),1)*refVal < 0)
                signChange = 1;
                break;
            end
        end
        if signChange < 0.5
            continue;
        end
        % Geometric Constraint 2
        signChange = 0;
        refVal = U(row2(i),col2(i),1);
        for y = max(col2(i)-nu,1):min(col2(i)+nu,n)
            if(U(row2(i),y,1)*refVal < 0)
                signChange = 1;
                break;
            end
        end
        if signChange < 0.5
            continue;
        end
        % Geometric Constraint 3
        signChange = 0;
        refVal = gradVy(row2(i),col2(i),1) - gradUx(row2(i),col2(i),1);
        for x = max(row2(i)-nu,1):min(row2(i)+nu,m)
            for y = max(col2(i)-nu,1):min(col2(i)+nu,n)
                if (gradVy(x,y,1) - gradUx(x,y,1))*refVal < 0
                    signChange = 1;
                    break;
                end
            end
        end
        if signChange > 0.5
            continue;
        end
        count2 = count2 + 1;
        row(count2) = row2(i);
        col(count2) = col2(i);
    end
    row = row(1:count2);
    col = col(1:count2);
    
    %BFS
    [m,n,p] = size(U);
    newData = zeros(m,n,p);
    stack = zeros(queueMaxElements,3);
    stackPtr = 0;
    count = size(row);
    for i = 1:count
        stackPtr = stackPtr + 1;
        stack(stackPtr,:) = [row(i),col(i),1];
        while(stackPtr > 0)
            x = stack(stackPtr,1);
            y = stack(stackPtr,2);
            z = stack(stackPtr,3);
            stackPtr = stackPtr - 1;
            for dx = max(x-1,1):min(x+1,m)
                for dy = max(y-1,1):min(y+1,n)
                    for dz = z:min(z+1,p)
                        if newData(dx,dy,dz) < 0.5 & OW(dx,dy,dz) < -0.2*sigma
                            newData(dx,dy,dz) = 1;
                            stackPtr = stackPtr + 1;
                            stack(stackPtr,:) = [dx,dy,dz];
                        end
                    end
                end
            end
        end
    end
    newData = uint8(newData);
    
    %Inserting Data Into Main Variable
    startLoc = [0,0,0,timestamp-1];
    countLoc = [m,n,p,1];
    netcdf.putVar(ncid,isEddy_ID,startLoc,countLoc,newData);
end

%% Closing things
% We're done, close the netcdf
netcdf.close(ncid);
load handel
sound(y,Fs)