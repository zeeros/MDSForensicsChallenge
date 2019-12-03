function [bestMap] = adaptMap(map, Map)
    %   ADAPTMAP Brings map to forged image size
    %   The algorithm implemented by getJMap() outputs a tampering map
    %   which is a matrix such that the estimated probability of being tampered
    %   for each 8x8 image block is contained in each cell of the map.
    %   This function is encharged of readapting the map to original image 
    %   and converting it to a bitmap.

    [dimx, dimy] = size(map);
    [width, height] = size(Map);
    
    blocks = cell(uint32(width/8),uint32(height/8));
    
    Thresholds = [0.4, 0.3, 0.5, 0.6, 0.7, 0.8, 0.9];
    [~, thresholdsCount] = size(Thresholds);
    
    bestMap = Map;
    bestMap(:,:) = 0;
    bestScore = 0;
    
    for t=1:thresholdsCount
        threshold = Thresholds(t);
        
        for i=1:dimx
            for j=1:dimy
                estimation = map(i,j);
                if (estimation >= threshold)
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
        
        score = f_measure(uint8(Map),uint8(adaptedMap));
        if score > bestScore
            bestScore = score;
            bestMap = adaptedMap;
        end
        
    end
    
    

    
end

