clearvars; close all; clc; 

forgedPath = '../../MDSDataset/dev-dataset-forged/';
mapsPath = '../../MDSDataset/dev-dataset-maps/';
outputPath = 'ADQ2/OUTPUT/';

jpgFiles = findFiles(forgedPath, 'jpg');
[r, filesCount] = size(jpgFiles);

fAvg = 0;

c1 = 1;
c2 = 15;
zeros = 0;

for i=1:filesCount
    filename = char(jpgFiles(i));

    [filepath,name,ext] = fileparts(filename);
    I = jpeg_read(filename);
    mapname = strcat(strcat(mapsPath, name), '.bmp');
    M = imread(mapname);
    m = getJmap(I, 1, c1, c2);
    
    [width, height] = size(M);
    m = adaptMap(m, M);
    
    imwrite(m, strcat(outputPath, strcat(name, '.bmp')));
    
    fScore = f_measure(uint8(M),uint8(m));
    fprintf('F-measure (%s) = %5.2f \n',name, fScore);
    if fScore == 0.0 
        zeros = zeros + 1.0;
    end
    fAvg = fAvg + fScore;
    
%     subplot(131);
%     imshow(imread(filename));
%     title('Forged Image');
%     
%     subplot(132);
%     imshow(M);
%     title('Expected Map');
%     
%     subplot(133);
%     imshow(m);
%     title('Estimated Map');
    
end

fAvg = fAvg / filesCount;
fprintf('Avg(F-measure) = %5.2f \n',fAvg);
fprintf('Zeros/Total = %5.2f / %5.2f \n',zeros,filesCount);


