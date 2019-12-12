function get_map(image_path)
    outputDir = '/DEMO-RESULTS/';
    % reading the image 
    I_matrix = imread(image_path);
    
    % read the image using jpeg_read in order to use ADQ2
    I_struct = 0;
    parts = strsplit(image_path, '/');
    partsSizes = size(parts);
    fname = parts(partsSizes(2));
    parts = strsplit(fname{1}, '.');
    ext = parts(2);
    Iname = parts(1);
    Iname = Iname{1};
    if (strcmp(ext,'jpg'))
        I_struct = jpeg_read(image_path);
    end

    % resize, if needed
    % im = imresize(im, [1500 2000]);
    % imwrite(im, image_path);

    %BLK
    square = imread("Algorithms/BLK/square.bmp");
    
    map_NOI5 = NOI5(I_matrix);
    map_BLK = BLK(I_matrix, square);
    if (isstruct(I_struct))
        map_ADQ2 = ADQ2(I_struct);
    end
    
    %combining the algorithms. To be developed based on results
    tampering_map1 = map_BLK;
    tampering_map2 = map_NOI5;
    tampering_map3 = map_ADQ2;
    
    %write output in DEMO-RESULTS as a bitmap
    imwrite(tampering_map1, strcat(outputDir, Iname, "BLK", '.bmp'));
    imwrite(tampering_map2, strcat(outputDir, Iname, "NOI5", '.bmp'));
	imwrite(tampering_map3, strcat(outputDir, Iname, "ADQ2", '.bmp'));
end