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
    realMapsDir = '../MDSDataset/dev-dataset-maps/';
    M = imread(strcat(realMapsDir, Iname, '.bmp'));

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
    tampering_map = fuseMaps(map_BLK, map_ADQ2, 0);
    tampering_map = fuseMaps(tampering_map, map_NOI5, 0);
    %write output in DEMO-RESULTS as a bitmap
    %imwrite(tampering_map, strcat(outputDir, Iname, '.bmp'));
    
    subplot(231);
    imshow(I_matrix);
    title('Forged Image');
    
    subplot(232);
    imshow(M);
    title('Expected Map');
    
    subplot(233);
    imshow(uint8(tampering_map));
    title('Output Map Map');
    
    subplot(234);
    imshow(map_ADQ2);
    title('ADQ2');
    
    subplot(235);
    imshow(map_BLK);
    title('BLK');
    
    subplot(236);
    imshow(map_NOI5);
    title('NOI5');
end
















