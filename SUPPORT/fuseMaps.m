function m1 = fuseMaps(m1, m2, method)
    % it takes an array of maps and 
    % fuse them into a single map
    [dimx1, dimy1] = size(m1);
    [dimx2, dimy2] = size(m2);
    if (dimx1 ~= dimx2 || dimy1 ~= dimy2)
        e = MException('FuseMaps:DifferentDimensions', ...
        'Maps in input must have same dimensions, dimx1=%i dimx2=%i dimy1=%i dimy2=%i',...
        dimx1, dimx2, dimy1, dimy2);
        throw(e);
    end
    m1 = uint8(m1);
    m2 = uint8(m2);
    if method==0
        % simple OR
        m1 = or(m1, m2);
    elseif method==1
        m1 = and(m1, m2);
    end
    
end

