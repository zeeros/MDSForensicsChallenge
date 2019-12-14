function get_map(image_path)
    outputDir = './DEMO-RESULTS/';
    image_path = char(image_path);
    I_matrix = imread(image_path);
    parts = strsplit(image_path, '/');
    partsSizes = size(parts);
    fname = parts(partsSizes(2));
    parts = strsplit(fname{1}, '.');
    ext = parts(2);
    Iname = parts(1);
    Iname = Iname{1};
    I_struct = 0;
    if (strcmp(ext,'jpg'))
        I_struct = jpeg_read(image_path);
    end

    map_BLK = BLK(I_matrix);
    tampering_map = map_BLK;
    if isstruct(I_struct)
        map_ADQ2 = ADQ2(I_struct);
        tampering_map = fuseMaps(map_BLK, map_ADQ2, 0);
    end
    
    if sum(tampering_map(:)) < 1500*2000*0.01 || sum(tampering_map(:)) > 1500*2000*0.99
        tampering_map = imread("Algorithms/BLK/square.bmp");;
    end

    imwrite(uint8(tampering_map), strcat(outputDir, Iname, '.bmp'));
    
%     if measure < 0.4
%         subplot(231);
%         imshow(I_matrix);
%         title('Forged Image');
% 
%         subplot(232);
%         imshow(trueMap);
%         title('Expected Map');
% 
%         subplot(233);
%         imshow(tampering_map);
%         title('Output Map');
% 
%         subplot(234);
%         imshow(map_ADQ2);
%         title('ADQ2');
% 
%         subplot(235);
%         imshow(map_BLK);
%         title('BLK');
% 
%         subplot(236);
%         imshow(map_NOI5);
%         title('NOI5');
% 
%         pause;
%     end   
    

end
















