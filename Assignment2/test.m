
magefiles = dir('/home/yiangos/UvA/CV2/assignment/CV2/Assignment2/Data/House/House/*.png');  
image1_path = strcat(imagefiles(1).folder,'/',imagefiles(1).name);
image2_path = strcat(imagefiles(1).folder,'/',imagefiles(2).name);
image1 = imread(image1_path);
image2 = imread(image2_path);

[f1,f2,matches,scores] = keypoint_matching(image1_path,image2_path);

index = randperm(size(matches,2),8);

first_image_points = f1(1:2,matches(1,index));
second_image_points = f2(1:2,matches(2,index));

first_image_points(3,:) = 1
second_image_points(3,:) = 1

F = eight_point(first_image_points, second_image_points, 1)
F_mat = det_F_normalized_8point(first_image_points, second_image_points)