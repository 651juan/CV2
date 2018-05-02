%% Read images
imagefiles = dir('../../Assignment 2 - v1.0.1/Assignment 2/Data/House/House/*.png');  
image1_path = strcat(imagefiles(1).folder,'/',imagefiles(1).name);
image2_path = strcat(imagefiles(1).folder,'/',imagefiles(2).name);
image1 = imread(image1_path);
image2 = imread(image2_path);

%% RANSAC
[best_fit first_image_points, second_image_points] = RANSAC(image1_path,image2_path,3,0);
%[f1,f2,matches,scores] = keypoint_matching(image1_path,image2_path);

%first_image_points = f1(:,matches(1,1:8));
%second_image_points = f2(:,matches(2,1:8));

%% Eight Point Algorithm
 F = eight_point(first_image_points, second_image_points, 0);
 
 pointL = first_image_points(1:2,2);
 pointR = first_image_points(1:2,2);
 pointL(3) = 1;
 pointR(3) = 1;
disp(pointL'*F*pointR);
%RANSAC_F(image1_path,image2_path);