load('../Assignment 1 - v1.0.1/Assignment 1/Data/source.mat')
load('../Assignment 1 - v1.0.1/Assignment 1/Data/target.mat')

% load('/home/yiangos/UvA/CV2/assignment/Assignment 1 - v1.0.1/Assignment 1/Data/data/0000000000.mat')
% load('/home/yiangos/UvA/CV2/assignment/Assignment 1 - v1.0.1/Assignment 1/Data/data/')

[adjusted pose] = ICP(source,target,'all');
pose
figure
scatter3(source(1,:),source(2,:),source(3,:),1,[1,0,0])
hold on
scatter3(target(1,:),target(2,:),target(3,:),1,[0,1,0])
hold on
scatter3(adjusted(1,:),adjusted(2,:),adjusted(3,:),1,[0,0,1])
