% % load('../Assignment 1 - v1.0.1/Assignment 1/Data/source.mat')
% % load('../Assignment 1 - v1.0.1/Assignment 1/Data/target.mat')
Pcd_path = '../Assignment 1 - v1.0.1/Assignment 1/Data/data/';
source = readPcd('../Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000020.pcd');
target = readPcd('../Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000025.pcd');


s=xml2struct('../Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000010_camera.xml');
R_cam = reshape(double(str2num(strrep(s.Children(4).Children(8).Children.Data,sprintf('\n'),''))),3,[]);
t_cam = reshape(double(str2num(s.Children(6).Children(8).Children.Data)),3,[]);

s=xml2struct('../Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000011_camera.xml');
R_cam2 = reshape(double(str2num(strrep(s.Children(4).Children(8).Children.Data,sprintf('\n'),''))),3,[]);
t_cam2 = reshape(double(str2num(s.Children(6).Children(8).Children.Data)),3,[]);
% size(source)
source = source(:,1:3);
target = target(:,1:3);


source = source(source(:,3) < 2, :)';
target = target(target(:,3) < 2, :)';


[adjusted, R,t] = ICP(source(1:3,:),target(1:3,:),1,0,'uniform',10000);

figure
% scatter3(source(1,:),source(2,:),source(3,:),1,[1,0,0])
% hold on
scatter3(target(1,:),target(2,:),target(3,:),1,[0,1,0])
hold on
scatter3(adjusted(1,:),adjusted(2,:),adjusted(3,:),1,[0,0,1])

% listing = dir('../Assignment 1 - v1.0.1/Assignment 1/Data/data/');
% files={};

% for i = 3 : length(listing)
% 	if contains(listing(i).name,'.pcd') && ~contains(listing(i).name,'normal')
 		
%  		files{end+1} = listing(i).name;
 	
%  	end
% end

% files

% for i = 1:4:length(files)
% 	cloud_point_source = readPcd(strcat(Pcd_path,files{i}));
% 	cloud_point_source = remove_background(cloud_point_source);
% 	cloud_point_source = cloud_point_source(:,1:3);
% 	figure
% 	scatter3(adjusted(1,:),adjusted(2,:),adjusted(3,:),1,[0,0,1])
	
% 	drawnow;
% end

% function [new_pointCloud] = remove_background(cloud_point)
% 	%find camera position in XYZ system
% 	%C = -(inv(R))*t;
% 	%remove all of the points that are in the background (2 meters away)
%     % new_pointCloud = cloud_point(sqrt((cloud_point(:,1)-C(1)).^2+(cloud_point(:,2)-C(2)).^2+(cloud_point(:,3)-C(3)).^2) < 2, :);
%     new_pointCloud = cloud_point(cloud_point(:,3) < 2, :);
% end
