function testNOI5(i_path, output_image_path)
I = imread(i_path);
M = NOI5(I);
imwrite(M, output_image_path);
end