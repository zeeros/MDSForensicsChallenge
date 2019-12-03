clear all; close all;


% Open the example ground truth tampering map
map_gt=double(imread('ground_truth_map.BMP'));
subplot(1,2,1); imshow(map_gt);

% % Simulate an estimated tampering map
% rand('seed',50)
% map_est = rem(map_gt+round(rand(size(map_gt))-0.4),2);
% map_est = logical(map_est);
% imwrite(map_est,'estimated_map.BMP','bmp');

%Open the example estimated tampering map
map_est = double(imread('estimated_map.BMP'));
subplot(1,2,2); imshow(map_est);

% Compute F-measure

[F] = f_measure(map_gt,map_est);




