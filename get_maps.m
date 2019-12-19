close all; clearvars;
PATH_TO_FORGED_IMAGES = '../MDSDataset/test-dataset/test-dataset-forged/';
tifFiles = findFiles(PATH_TO_FORGED_IMAGES, 'tif');
jpgFiles = findFiles(PATH_TO_FORGED_IMAGES, 'jpg');
files = cat(2, tifFiles, jpgFiles);
files = sort(files);
[~, filesCount] = size(files);    
for i=1:filesCount
    get_map(files(i));
end