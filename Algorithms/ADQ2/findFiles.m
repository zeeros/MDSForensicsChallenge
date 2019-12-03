function [filesList] = findFiles(dirPath, ext)
%FINDFILES Find all files in directory of given extension

    filesList = {};
    if ~isfolder(dirPath)
        errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
        uiwait(warndlg(errorMessage));
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

