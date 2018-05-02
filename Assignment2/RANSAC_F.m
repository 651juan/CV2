function [F] = RANSAC_F(image1,image2)
    for iter = 1:100
        [f1,f2,matches,scores] = keypoint_matching(image1,image2);

        first_image_points = f1(:,matches(1,1:8));
        second_image_points = f2(:,matches(2,1:8));
        
        candidate_F = eight_point(first_image_points, second_image_points,1);
        
        d = sampson_distance(first_image_points, second_image_points, candidate_F);
        
        inliers = abs(d) < 1.25;
    end
end
