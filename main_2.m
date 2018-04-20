% load('../Assignment 1 - v1.0.1/Assignment 1/Data/source.mat')
% load('../Assignment 1 - v1.0.1/Assignment 1/Data/target.mat')

source = readPcd('../Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000008.pcd');
target = readPcd('../Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000007.pcd');

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


[adjusted, R,t] = ICP(source(1:3,:),target(1:3,:),'uniform',20000);

figure
% scatter3(source(1,:),source(2,:),source(3,:),1,[1,0,0])
% hold on
scatter3(target(1,:),target(2,:),target(3,:),1,[0,1,0])
hold on
scatter3(adjusted(1,:),adjusted(2,:),adjusted(3,:),1,[0,0,1])

listing = dir('../Assignment 1 - v1.0.1/Assignment 1/Data/data/');
files={};

for i = 3 : length(listing)
	if contains(listing(i).name,'.pcd') && contains(listing(i).name,'normal')
 		normal_files{end+1} = listing(i).name;
 	elseif contains(listing(i).name,'.pcd')
 		files{end+1} = listing(i).name;
 	elseif contains(listing(i).name,'.xml')
 		xml_files{end+1} = listing(i).name;
 	end
end

for i = 1:length(files)
	cloud_point_source = readPcd(strcat(Pcd_path,files{i}));
	cloud_point_source = remove_background(cloud_point_source);
	cloud_point_source = cloud_point_source(:,1:3);
	figure
	scatter3(adjusted(1,:),adjusted(2,:),adjusted(3,:),1,[0,0,1])
	drawnow;
end
