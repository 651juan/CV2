function [merged_frames] = merge_frames(method,number_of_points,step,merging_strategy)

Pcd_path = '../Assignment 1 - v1.0.1/Assignment 1/Data/data/';
% Pcd_name1 = '0000000000.pcd';
% Pcd_name2 = '0000000002.pcd';

%cd '/home/yiangos/UvA/CV2/assignment/Assignment 1 - v1.0.1/Assignment 1/Data/data/';
%dir *.pcd;
%cd '/home/yiangos/UvA/CV2/assignment/CV2';

listing = dir('../Assignment 1 - v1.0.1/Assignment 1/Data/data/');
files={};
normal_files = {};
xml_files = {};
for i = 3 : length(listing)
	if contains(listing(i).name,'.pcd') && contains(listing(i).name,'normal')
 		normal_files{end+1} = listing(i).name;
 	elseif contains(listing(i).name,'.pcd')
 		files{end+1} = listing(i).name;
 	elseif contains(listing(i).name,'.xml')
 		xml_files{end+1} = listing(i).name;
 	end
end

pcd_merged = zeros(3,0);

% s = xml2struct( '../Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000000_camera.xml');
% %Intristic = double(str2num(s.Children(2).Children(8).Children.Data))
% R = reshape(double(str2num(strrep(s.Children(4).Children(8).Children.Data,sprintf('\n'),''))),3,[]);
% t = reshape(double(str2num(s.Children(6).Children(8).Children.Data)),3,[]);

% cloud_point_source = readPcd(strcat(Pcd_path,Pcd_name1));
% cloud_point_source = remove_background(cloud_point_source,R,t);
% cloud_point_source = cloud_point_source(:,1:3);

R_cum = eye(3);
t_cum = zeros(3, 1);
change = 1;
for i = 1:step:100-step
	i
	
	% if i == 10
	% 	break
	% % end
	% s=xml2struct(strcat(Pcd_path,xml_files{i}));
	% R_cam = reshape(double(str2num(strrep(s.Children(4).Children(8).Children.Data,sprintf('\n'),''))),3,[]);
	% t_cam = reshape(double(str2num(s.Children(6).Children(8).Children.Data)),3,[]);

	% Load target cloud point
	% if change==1
	cloud_point_source = readPcd(strcat(Pcd_path,files{i}));
	cloud_point_source = remove_background(cloud_point_source);
	cloud_point_source = cloud_point_source(:,1:3);
	% end
	% change = 0;
	% s=xml2struct(strcat(Pcd_path,xml_files{i}));
	% R_cam = reshape(double(str2num(strrep(s.Children(4).Children(8).Children.Data,sprintf('\n'),''))),3,[]);
	% t_cam = reshape(double(str2num(s.Children(6).Children(8).Children.Data)),3,[]);
	% % Load target cloud point

	cloud_point_target = readPcd(strcat(Pcd_path,files{i+step}));
	cloud_point_target = remove_background(cloud_point_target);
	cloud_point_target = cloud_point_target(:,1:3);

	% size(cloud_point_source)
	% cloud_point_target = cloud_point_target(1:length(cloud_point_source))''
	if merging_strategy==1

		% if length(pcd_merged) == 0
		% 	pcd_merged = cloud_point_source';
		% end
		% Find camera pose
		[result, R, t,RMS] = ICP(transpose(cloud_point_source),transpose(cloud_point_target),1,1,method,number_of_points);

		% if RMS < 0.1
			%Accumulate R and t
	
		predicted =  R_cum * result  + t_cum; 

		t_cum = R_cum * t + t_cum;
    	R_cum = R_cum * R  ;

    	% merge new point cloud 
    	
    	pcd_merged = cat(2, pcd_merged, predicted);
    	% change=1;
		% end
		

	elseif merging_strategy==2

		if length(pcd_merged) == 0
			pcd_merged = cloud_point_source';
		end


		% Find camera pose

		[result, R, t,RMS] = ICP(pcd_merged,transpose(cloud_point_target),1,1,method,number_of_points);
		
		if RMS < 0.1
		predicted  =  R * pcd_merged  + t;
		%transform the merged pointclouds
		
		% if RMS < 0.05
    	pcd_merged = cat(2, pcd_merged, predicted);
		end
	end

    %Plot the pointclouds before and after
    % if mod(i-1,10)==0
    figure
    subplot(1,2,1);
    scatter3(result(1,:), result(2,:), result(3,:),1,[1,0,0]);
    hold on
    scatter3(cloud_point_target(:,1), cloud_point_target(:,2), cloud_point_target(:,3),1,[0,0,1]);
    hold off
    subplot(1,2,2);      
    scatter3(pcd_merged(1,:), pcd_merged(2,:), pcd_merged(3,:),1);
    if merging_strategy == 1
    hold on
    scatter3(result(1,:), result(2,:), result(3,:),1);
	end
    hold off
    drawnow;
	% end
 %    if RMS < 0.5
   
 %    cloud_point_source = cloud_point_target;
	% end

end
figure
scatter3(pcd_merged(1,:), pcd_merged(2,:), pcd_merged(3,:),1);

%previous target is the new source
	

%X = u*Z/f;  
%Y = v*Z/f,  
%[525.  0. 320. ; 0. 525. 240. ; 0. 0. 1] *
%camera;    
%cloud_point1 = readPcd(strcat(Pcd_path,Pcd_name1));
%size(cloud_point1)
%cloud_point2 = readPcd(strcat(Pcd_path,Pcd_name2));
%cloud_point_new=[]
%R = {};
%t = {};
%for row=1:size(cloud_point1,1)
%	sqrt((row(:,1)-camera(1)).^2+(row(:,2)-camera(2)).^2+(row(:,3)-camera(3)).^2)
%end
%cloud_point1=cloud_point1(sqrt((cloud_point1(:,1)-camera(1)).^2+(cloud_point1(:,2)-camera(2)).^2+(cloud_point1(:,3)-camera(3)).^2) < 2, :);
%cloud_point2=cloud_point2(sqrt((cloud_point1(:,1)-camera(1)).^2+(cloud_point1(:,2)-camera(2)).^2+(cloud_point1(:,3)-camera(3)).^2) < 2, :);
%size(cloud_point1)
%[source R t]  = ICP(cloud_point1(:,1:3)',cloud_point2(:,1:3)','uniform',30000);

%pose
%scatter3(cloud_point1(:,1),cloud_point1(:,2),cloud_point1(:,3),1);
%adjusted = ICP(source,target,'all');

%data.unpackRGBFloat


function [new_pointCloud] = remove_background(cloud_point)
	%find camera position in XYZ system
	%C = -(inv(R))*t;
	%remove all of the points that are in the background (2 meters away)
    % new_pointCloud = cloud_point(sqrt((cloud_point(:,1)-C(1)).^2+(cloud_point(:,2)-C(2)).^2+(cloud_point(:,3)-C(3)).^2) < 2, :);
    new_pointCloud = cloud_point(cloud_point(:,3) < 2, :);
end


end