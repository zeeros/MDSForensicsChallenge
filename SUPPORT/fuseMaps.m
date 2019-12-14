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
    
    nhood = ones(100,100);
    
    % Fills holes smaller than 100x100
    m1 = imclose(m1,nhood);
    m2 = imclose(m2,nhood);
    % Eliminates pieces smaller than 100x100
    m1 = imopen(m1,nhood);
    m2 = imopen(m2,nhood);
    
    %imagesc(m1);
    
    %discard highly improbable maps, i.e. sparse
    
    coeff1 = nnz(m1)/numel(m1);
    coeff2 = nnz(m2)/numel(m2);
    if (coeff1 < 0.05  ||  coeff1 > 0.8) && (coeff2 > 0.05  &&  coeff2 < 0.8)
        % m1 just stays the same
    elseif (coeff2 < 0.05  ||  coeff2 > 0.8) && (coeff1 > 0.05  &&  coeff1 < 0.8)
        m1 = m2;
    end
    
    %now, they're either both plausible or none of them.
        
    if method==0
        % simple OR
        m1 = or(m1, m2);
    elseif method==1
        m1 = and(m1, m2);
    end
    
end

