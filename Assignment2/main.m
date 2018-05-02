%% Read images
imagefiles = dir('/home/yiangos/UvA/CV2/assignment/CV2/Assignment2/Data/House/House/*.png');  
image1_path = strcat(imagefiles(1).folder,'/',imagefiles(1).name);
image2_path = strcat(imagefiles(1).folder,'/',imagefiles(2).name);
image1 = imread(image1_path);
image2 = imread(image2_path);
% /home/yiangos/UvA/CV2/assignment/CV2/Assignment2/Data/House/House
%% RANSAC
[best_fit first_image_points, second_image_points] = RANSAC(image1_path,image2_path,3,1);

%% Eight Point Algorithm
A = zeros(size(first_image_points,2), 9);

for i = 1:size(first_image_points,2)
    A(i,:) = [first_image_points(1,i)*second_image_points(1,i), first_image_points(1,i)*second_image_points(2,i), first_image_points(1,i), first_image_points(2,i)*second_image_points(1,i), first_image_points(2,i)*second_image_points(2,i), first_image_points(2,i), second_image_points(1,i), second_image_points(2,i), 1];    
end


