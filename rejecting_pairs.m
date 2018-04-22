function [source,target,index]  = rejecting_pairs(source,target, distance,method)

if method==1
	[dist,index] = sort(distance);

	perc = round(9*(length(index)/10));
	index = index(perc:end);

	source(:,index) = [];
	target(:,index) = [];
elseif method == 2 

	index = find(distance > 0.3)
	source(:,index) = [];
	target(:,index) = [];

elseif method == 3
 	std_ = std(distance);
 	index = find(distance > std_ * 2);
 	source(:,index) = [];
	target(:,index) = [];
end

end