function [framesa,framesb,matches,scores] = keypoint_matching(image1,image2,showNumberOfPoints)

if nargin == 2 
    showNumberOfPoints = 50;
end

[framesa, da] = vl_sift(single(image1)) ;
[framesb, db] = vl_sift(single(image2)) ;
[matches, scores] = vl_ubcmatch(da, db) ;

[~, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;

matches = matches(:,1:showNumberOfPoints);
scores = scores(1:showNumberOfPoints);

end

    