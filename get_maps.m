function get_maps(images_path)
    files = path(images_path);
    for i = 1:size(files)
        images_name(i) = files(1).name;
        get_map( strcat( images_path, images_name(i) ) );
    end
end