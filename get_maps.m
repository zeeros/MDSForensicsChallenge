function get_maps(images_path)
    tifFiles = findFiles(images_path, 'tif');
    jpgFiles = findFiles(images_path, 'jpg');
    files = cat(2, tifFiles, jpgFiles);
    % for every tif apply only BLK
    for i=1:20
        get_map(files(i));
    end
    
end