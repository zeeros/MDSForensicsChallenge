function get_map(image_path)
    % reading the image 
    im = imread(image_path);

    % resize, if needed
%     im = imresize(im, [1500 2000]);
%     imwrite(im, image_path);

    %BLK
    square = imread("Algorithms/BLK/square.bmp");
    if contains(image_path, ".jpg")
        map_BLK = BLK(image_path, square);
    end
    
    %NOI5
    map_NOI5 = NOI5(im);

    %ADQ2
    
    % ?
    
%     if contains(image_path, ".jpg") 
%         [filepath, name, ext] = fileparts(image_path);
%         im = jpeg_read(name);
%     
%         c1 = 1;
%         c2 = 15;
%         M = zeros(1500, 2000);
%         m = getJmap(im, 1, c1, c2);
%     
%         [width, height] = size(M);
%         map_ADQ2 = adaptMap(m, M);
%     end
    
    
    %combining the algorithms. To be developed based on results
    tampering_map1 = map_BLK;
    tampering_map2 = map_NOI5;
%     tampering_map3 = map_ADQ2;
    
    %extract filename from input path
    [filepath, name, ext] = fileparts(image_path);
    
    %write image in DEMO-RESULTS
    imwrite( tampering_map1, strcat("DEMO-RESULTS/", name, "BLK", ext) );
    imwrite( tampering_map2, strcat("DEMO-RESULTS/", name, "NOI5", ext) );
%     imwrite( tampering_map3, strcat("DEMO-RESULTS/", name, "ADQ2", ext) );
end