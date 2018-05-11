function [PVM] = chaining

	imagefiles = dir('/home/yiangos/UvA/CV2/assignment/CV2/Assignment2/Data/House/House/*.png');  
	PVM = [];
	
	for i = 1:length(imagefiles)

		image1_path = strcat(imagefiles(1).folder,'/',imagefiles(i).name);

		if i ~= length(imagefiles)
			image2_path = strcat(imagefiles(1).folder,'/',imagefiles(i+1).name);
		else
			image2_path = strcat(imagefiles(1).folder,'/',imagefiles(1).name);
		end

		% image1 = imread(image1_path);
		% image2 = imread(image2_path);

		[best_fit, first_image_points, second_image_points] = RANSAC(image2_path,image2_path,3,0);

		x_first = first_image_points(1,:);
		y_first = first_image_points(2,:);

		x_second = second_image_points(1,:);
		y_second = second_image_points(2,:);



		if isempty(PVM)
			PVM = [x_first; y_first; x_second ; y_second];
		else
			last_image_point = PVM(end-1:end,:);
			% [~,indexes] = ismembertol([x_first; y_first]',last_image_point','ByRows',true);

			[~,indexes] = ismembertol(round([x_first; y_first])',round(last_image_point)',0.01,'ByRows',true);	
			% indexes			
			PVM(end+1:end+2,:) = zeros(2,size(PVM,2));

			for j = 1:length(indexes)
				% last_column_index = size(PVM,2);
				if (indexes(j) ~= 0)
					PVM(end-1:end,indexes(j)) = [x_second(j) ; y_second(j)];
					% y_second(indexes(j))
			% 	% If new point appears
				else
					PVM(:,end+1) = zeros(size(PVM,1),1);
					PVM(end-3,end) = x_first(j);
					PVM(end-2,end) = y_first(j);
					PVM(end-1:end,end) = [x_second(j) ; y_second(j)];
				end
			end
			% PVM
			% end
			% [x_first; y_first];
			% last_image_point;
		end
	end
	PVM
end