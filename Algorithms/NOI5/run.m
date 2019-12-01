function run(i_path, output_image_path)
I = double(rgb2gray(imread(i_path)));
B = 64; %64*64 blocks
[M N] = size(I);
% ensure the image size can be divided by 64
I = I(1:floor(M/B)*B,1:floor(N/B)*B);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Results for 64*64 block
for i = 1 : M/B
    for j = 1 : N/B
        Ib = I((i-1)*B+1:i*B,(j-1)*B+1:j*B);
        [label64(i,j), Noise_64(i,j)] =  PCANoiseLevelEstimator(Ib,5);
    end
end
[~, re]  = KMeans(Noise_64(:),2);
result4 = (reshape(re(:,2),size(Noise_64)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Results for 32*32 block
B = 32;
for i = 1 : M/B
    for j = 1 : N/B
        Ib = I((i-1)*B+1:i*B,(j-1)*B+1:j*B);
        [label32(i,j), Noise_32(i,j)] =  PCANoiseLevelEstimator(Ib,5);
    end
end
MEDNoise_32= medfilt2(Noise_32,[5 5],'symmetric');
Noise_32(label32==1)= MEDNoise_32(label32==1);
[~, re]=KMeans(Noise_32(:),2);
result2=(reshape(re(:,2),size(Noise_32)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Weighted result of 64*64 and 32*32
for i = 1 : M/64
    for j = 1 : N/64
        Noise_mix((2*i-1):(2*i),(2*j-1):(2*j)) = Noise_64(i,j);
        initialdetected((2*i-1):(2*i),(2*j-1):(2*j)) = result4(i,j);
    end
end
Noise_mix = 0.8*Noise_mix+0.2*Noise_32(1:2*i,1:2*j);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Only B=32 result is used along the suspicious boundary
Noise_mix2 = Noise_mix;
DL = initialdetected(2:end-1,1:end-2) - initialdetected(2:end-1,2:end-1);
DR = initialdetected(2:end-1,2:end-1) - initialdetected(2:end-1,3:end);
DU = initialdetected(1:end-2,2:end-1) - initialdetected(2:end-1,2:end-1);
DD = initialdetected(2:end-1,2:end-1) - initialdetected(3:end,2:end-1);
Edge = zeros(size(initialdetected));
Edge(2:end-1,2:end-1)= abs(DL)+abs(DR)+abs(DU)+abs(DD);
g = (Edge>0);
Noise_mix2(g) = Noise_32(g);

[~, re]=KMeans(Noise_mix2(:),2);
result4=(reshape(re(:,2),size(Noise_mix2)));
bwpp = bwlabel(result4-1);
area = regionprops(bwpp,'area');
for num =1: length(area)
    if area(num,1).Area < 4
        result4(bwpp==num)=1;
    end
end
mask = bwlabel(result4-1);
mask = bwareaopen(mask, 50);
%Remove small objects from binary image
%Resize to image size
mask = imresize(mask,[M N]);
%To B/W
%mask = imbinarize(mask);
mask = imbinarize(uint16(mask));
imwrite(mask, output_image_path);
end