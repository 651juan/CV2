%% Read images
imagefiles = dir('/home/yiangos/UvA/CV2/assignment/CV2/Assignment2/Data/House/House/*.png');  
image1_path = strcat(imagefiles(1).folder,'/',imagefiles(1).name);
image2_path = strcat(imagefiles(1).folder,'/',imagefiles(2).name);
image1 = imread(image1_path);
image2 = imread(image2_path);
% /home/yiangos/UvA/CV2/assignment/CV2/Assignment2/Data/House/House
%% RANSAC
%[best_fit first_image_points, second_image_points] = RANSAC(image1_path,image2_path,3,0);

%% Eight Point Algorithm
%F = eight_point(first_image_points, second_image_points, 1);

RANSAC_F(image1_path,image2_path);