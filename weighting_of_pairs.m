function [weight_array]  = weighting_of_pairs(distance,method)

if strcmp(method,'max')

	weight_array = ones(1,length(distance));
	max_dist = max(distance);
	weight_array(1,:) = 1 - (distance ./ max_dist);

end