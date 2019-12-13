function [ im_out ] = CleanUpImage( im )
% This function converts images to 3-channel uint8 images.

if numel(size(im))>3
    im=im(:,:,:,1,1,1,1);
end

if size(im,3)<3
    im(:,:,2)=im(:,:,1);
    im(:,:,3)=im(:,:,1);
end


if size(im,3)>3
    im=im(:,:,1:3);
end

if isa(im,'uint16')
    im=uint8(floor(double(im)/256));
end

im_out=im;

end

