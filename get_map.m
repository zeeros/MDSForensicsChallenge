function measure = get_map(image_path)
    outputDir = './DEMO-RESULTS/test/';
    trueMapsDir = '../MDSDataset/dev-dataset-maps/';
    
    % reading the image 
    image_path = char(image_path);
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
    trueMapFName = strcat(trueMapsDir, Iname, '.bmp');
    trueMap = imread(trueMapFName);
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
    tampering_map = map_BLK;
    if (isstruct(I_struct))
        map_ADQ2 = ADQ2(I_struct);
        tampering_map = fuseMaps(tampering_map, map_ADQ2, 0);
        measure = f_measure(trueMap,tampering_map);
        fprintf('%s -> %3.4f\n',Iname,measure);
        
%         if measure < 0.4
%             subplot(231);
%             imshow(I_matrix);
%             title('Forged Image');
% 
%             subplot(232);
%             imshow(trueMap);
%             title('Expected Map');
% 
%             subplot(233);
%             imshow(tampering_map);
%             title('Output Map');
% 
%             subplot(234);
%             imshow(map_ADQ2);
%             title('ADQ2');
% 
%             subplot(235);
%             imshow(map_BLK);
%             title('BLK');
% 
%             subplot(236);
%             imshow(map_NOI5);
%             title('NOI5');
%             
%             pause;
%         end
    end
    
    %write output in DEMO-RESULTS as a bitmap
    imwrite(uint8(tampering_map), strcat(outputDir, Iname, '.bmp'));
    
    

end
















