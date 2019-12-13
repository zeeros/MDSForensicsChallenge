function [filesList] = findFiles(dirPath, ext)
%FINDFILES Find all files in directory of given extension

    filesList = {};
    if ~isfolder(dirPath)
        e = MException('FindFiles:NotADirectory', ...
        'The provided path is not a directory: %s',...
        dirPath);
        throw(e);
    end
    
    filePattern = fullfile(dirPath, strcat('*.', ext));
   
    files = dir(filePattern);
    for k = 1:length(files)
        baseFileName = files(k).name;
        fullFileName = fullfile(dirPath, baseFileName);
        filesList = [filesList, fullFileName];
    end

end

