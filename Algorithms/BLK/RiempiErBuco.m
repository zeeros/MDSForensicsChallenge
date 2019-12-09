function [map, removed_mass, removed_ccs] = RiempiErBuco(map, cc_thresh)

    ccs = bwconncomp(map);

    % Remove components smaller than N blocks
    removed_ccs = 0;
    removed_mass = 0;
    for l = 1:ccs.NumObjects
        stm = numel(ccs.PixelIdxList{l});
        if stm < cc_thresh
            removed_mass = removed_mass + stm;            
            removed_ccs = removed_ccs + 1;
            map(ccs.PixelIdxList{l}) = 0;
        end
    end
    removed_ccs = removed_ccs / ccs.NumObjects;
    removed_mass = removed_mass / sum(map(:));
end