function get_maps(images_path)
    tifFiles = findFiles(images_path, 'tif');
    jpgFiles = findFiles(images_path, 'jpg');
    files = cat(2, jpgFiles, tifFiles);
    [r, filesCount] = size(files);

    for i=1:5
        get_map(files(i));
    end
    
end