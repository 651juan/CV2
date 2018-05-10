function [framesa,framesb,matches,scores] = keypoint_matching(image1,image2)

if nargin == 2 
    showNumberOfPoints = 50;
end

image1 = single(imread(image1));
image2 = single(imread(image2));

[framesa, da] = vl_sift(single(image1)) ;
[framesb, db] = vl_sift(single(image2)) ;
[matches, scores] = vl_ubcmatch(da, db,0.5) ;
background_index = [];


% for i = 1:size(matches,2)
% 	index1 = matches(:,i);
%  	x_first_set=floor(framesa(1:2,index1(1)));
%  	x_second_set=floor(framesb(1:2,index1(2)));

%  	if image1(fix(x_first_set(2)),fix(x_first_set(1))) < 30 | image2(fix(x_second_set(2)),fix(x_second_set(1))) < 30
%  		background_index = [background_index  i];
%  	end
% end

% matches(:,background_index) = [];
% scores(background_index) = [];

% matches
[~, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;

% matches = matches(:,1:showNumberOfPoints);
% scores = scores(1:showNumberOfPoints);

end

    