load('/home/juan/Documents/Uva/CV2/Assignment 1 - v1.0.1/Assignment 1/Data/source.mat')
load('/home/juan/Documents/Uva/CV2/Assignment 1 - v1.0.1/Assignment 1/Data/target.mat')

adjusted = ICP(source,target);

figure
scatter3(source(1,:),source(2,:),source(3,:))
hold on
scatter3(target(1,:),target(2,:),target(3,:))
hold on
scatter3(adjusted(1,:),adjusted(2,:),adjusted(3,:))