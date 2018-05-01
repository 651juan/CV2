%% Read images
imagefiles = dir('../../Assignment 2 - v1.0.1/Assignment 2/Data/House/House/*.png');  
image1_path = strcat(imagefiles(1).folder,'/',imagefiles(1).name);
image2_path = strcat(imagefiles(1).folder,'/',imagefiles(2).name);
image1 = imread(image1_path);
image2 = imread(image2_path);

%% RANSAC
%[best_fit first_image_points, second_image_points] = RANSAC(image1_path,image2_path,3,0);

%% Eight Point Algorithm
%F = eight_point(first_image_points, second_image_points, 1);

RANSAC_F(image1_path,image2_path);