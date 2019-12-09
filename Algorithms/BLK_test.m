clearvars; close all; clc; 

forgedPath = '../../MDSDataset/dev-dataset-forged';
mapsPath = '../../MDSDataset/dev-dataset-maps/';
outputPath = 'BLK/OUTPUT/';
%get all jpg files
jpgFiles = findFiles(forgedPath, 'jpg');
%get all tif files
tifFiles = findFiles(forgedPath, 'tif');
%join tif and jpg
Files = [jpgFiles, tifFiles];
[~, filesCount] = size(Files);

%final Avg
fAvg = 0;
zeros = 0;
blackCount = 0;
whiteCount = 0;
B = imread('blackmask.bmp'); 
Twhite = 2000*1500*0.9;

% polygon
%Polygon = [  750   750    1250   1250 ; 1000    500    500    1000]';
Polygon = [  500   500    1500   1500 ; 1250    250    250    1250]';
ImageWidth = 2000;
ImageHeight = 1500;

%compute imgs
for i=1:filesCount
    filename = char(Files(i));
    [filepath,name,ext] = fileparts(filename);
    mapname = strcat(strcat(mapsPath, name), '.bmp');
    M = imread(mapname);
    M = squeeze(M(:,:,1));
    m = analyze(filename);
    %threashold
    m = (m > min(mean(m)/2));
    %clean
    m = mapCleanup(m, 64);
    %fill holes
    m = imfill(m, 'holes');
    [width, height] = size(M);
    %check for same size
    m = adaptMap(m, M);
    %median filter for borders
    m = medfilt2(m,[5 5]);
    
    % check for black image or 90% are white units
    if isnan(f_measure(uint8(B),uint8(m)))
        blackCount = blackCount + 1;
        %create image with a standard square in the middle
        m = poly2mask(Polygon(:,1),Polygon(:,2),ImageHeight,ImageWidth);
    end   
    % check for 90% white units
    % nnz() gives the number of nonzero matrix elements
    if nnz(m) > Twhite
        whiteCount = whiteCount + 1;
        %create image with a standard square in the middle
        m = poly2mask(Polygon(:,1),Polygon(:,2),ImageHeight,ImageWidth);
    end   
    %write bmp img
    imwrite(m, strcat(outputPath, strcat(name, '.bmp')));
    %compute fmeasure for positive and negative masks
    fScorePositive = f_measure(uint8(M),uint8(m));
    fScoreNegative = f_measureNegative(uint8(M),uint8(m));
    %take the highest score
    if fScorePositive >= fScoreNegative
        fScore = fScorePositive;
    else
        fScore = fScoreNegative;
    end    
        
    fprintf('F-measure (%s) = %5.2f \n',name, fScore);
    if fScore == 0.0
        zeros = zeros + 1.0;
    end
    fAvg = fAvg + fScore;
end   

%results
fAvg = fAvg / (filesCount);
fprintf('Avg(F-measure) = %5.2f \n',fAvg);
fprintf('Zeros/Total = %5.2f / %5.2f \n',zeros,filesCount);
fprintf('Black output = %5.2f \n',blackCount);
fprintf('White output = %5.2f \n',whiteCount);