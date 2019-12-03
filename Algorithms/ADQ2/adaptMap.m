function [adaptedMap] = adaptMap(map, width, height)
    %   ADAPTMAP Brings map to forged image size
    %   The algorithm implemented by getJMap() outputs a tampering map
    %   which is a matrix such that the estimated probability of being tampered
    %   for each 8x8 image block is contained in each cell of the map.
    %   This function is encharged of readapting the map to original image 
    %   and converting it to a bitmap.

    blocks = cell(uint32(width/8),uint32(height/8));
    [dimx, dimy] = size(map);
    
    for i=1:dimx
        for j=1:dimy
            estimation = map(i,j);
            if (estimation >= 0.9)
                block = ones(8,8);
            else
                block = zeros(8,8);
            end
            blocks{i,j} = block;
        end
    end
    
    adaptedMap = cell2mat(blocks);
    [newDimx, newDimy] = size(adaptedMap);
    
    if (newDimx > width)
        adaptedMap = adaptedMap(1:width, :);
    end
    
    if (newDimy > height)
        adaptedMap = adaptedMap(:, 1:height);
    end
    
end

