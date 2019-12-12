function [filesList] = findFiles(dirPath, ext)
%FINDFILES Find all files in directory of given extension

    filesList = {};
    if ~isfolder(dirPath)
        fprintf('Error: The following folder does not exist:\n%s', dirPath);
        return;
    end
    
    filePattern = fullfile(dirPath, strcat('*.', ext));
    jpegFiles = dir(filePattern);
    for k = 1:length(jpegFiles)
        baseFileName = jpegFiles(k).name;
        fullFileName = fullfile(dirPath, baseFileName);
        filesList = [filesList, fullFileName];
    end

end

