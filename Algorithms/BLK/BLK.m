function m = BLK(im, SquareIm) 

ImageWidth = 2000;
ImageHeight = 1500;
%threashold for final image
T = ImageWidth*ImageHeight*0.99;
%convert to 3-channel uint8 image
im = CleanUpImage(im);
%this is the main BLK function
%note that the output image is much smaller than 1500*2000
m = GetBlockGrid(im);
%threashold to make binary img
m = (m > min(mean(m)/2));

[SmallImageWidth, SmallImageHeight] = size(m);
%since same times BLK gives the correct output as an complement
%use this threashold to compute complement
%usually when the white part is a lot, means that the complement is the
%right output
TwhiteSmallImg = SmallImageWidth*SmallImageHeight*0.80;

%if the white units are more than 80% then make a complement
if nnz(m) > TwhiteSmallImg
    %complement
    m = imcomplement(m);
end    
%clean small pieces
m = mapCleanup(m, 64);
%fill holes
m = imfill(m, 'holes');
%median filter for borders
m = medfilt2(m,[5 5]);
%check for same size
m = adaptMap(m, ImageWidth, ImageWidth, 0.5);

% check for 99% white units or black units
% nnz() gives the number of nonzero matrix elements
if nnz(m) > T || ~nnz(m) > T
    %create image with a standard square in the middle
    m = SquareIm;
end
end

