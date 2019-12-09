function [jpgImg] = TifToJpg(tifImg)
%converts a tif img to jpg img
in_name = 'xyz.tif';    %the name of your input image
out_name = 'xyz_converted.jpg';   %the name of the desired output
IM = imread(in_name);   %read in the image
imwrite(IM, out_name);  %write it out

IM = imread(tifImg);   %read in the image
imwrite(IM, out_name);  %write it out
end

