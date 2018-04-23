function [weight_array]  = weighting_of_pairs(distance,method,normal_source,normal_target)

if strcmp(method,'max')

	weight_array = ones(1,length(distance));
	max_dist = max(distance);
	weight_array(1,:) = 1 - (distance ./ max_dist);
elseif strcmp(method,'comp')

	weight_array=[];
	for i = 1:	size(normal_source,2)
	res = normal_source(i) * normal_target(i)';
	weight_array = [weight_array res];
	end
	weight_array(isnan(weight_array))=0;

end