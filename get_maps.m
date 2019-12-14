function get_maps(images_path)
    tifFiles = findFiles(images_path, 'tif');
    jpgFiles = findFiles(images_path, 'jpg');
    files = cat(2, jpgFiles, tifFiles);
    [~, filesCount] = size(files);
    measures = zeros(1,length(filesCount), 'int8');
    
    for i=1:filesCount
        measures(i) = get_map(files(i));
    end
    
    m = mean(measures);
    fprintf('mean(scores) -> %3.4f\n',m);
    
end