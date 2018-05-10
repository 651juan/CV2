function [PVM] = chaining

	imagefiles = dir('/home/yiangos/UvA/CV2/assignment/CV2/Assignment2/Data/House/House/*.png');  
	PVM = []
	
	for i = 1:10

		image1_path = strcat(imagefiles(1).folder,'/',imagefiles(i).name);

		if i ~= length(imagefiles)
			image2_path = strcat(imagefiles(1).folder,'/',imagefiles(i+1).name);
		else
			image2_path = strcat(imagefiles(1).folder,'/',imagefiles(i).name);
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
			[~,indexes] = ismember([x_first; y_first]',last_image_point','rows');	
			last_row_index = size(PVM,1);
			PVM(last_row_index+1,:) = zeros(1,size(PVM,2));
			PVM(last_row_index+2,:) = zeros(1,size(PVM,2));

			for j = 1:length(indexes)
				if (indexes(j) ~= 0)
					PVM(last_row_index+1,j) = x_second(indexes(j));
					PVM(last_row_index+2,j) = y_second(indexes(j));
				else
					PVM(:,length(indexes)+1) = zeros(size(PVM,1),1);
					PVM(last_row_index,end-1) = x_first(j);
					PVM(last_row_index,end) = y_first(j);
					PVM(last_row_index+1,j) = x_second(indexes(j));
					PVM(last_row_index+1,j) = y_second(indexes(j));
				end

			end
			% [x_first; y_first];
			% last_image_point;
            PVM
		end
	end

end