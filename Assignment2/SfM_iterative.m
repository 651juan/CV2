function SfM_iterative(num_of_images)
    %PVM = chaining();
    PVM = importdata('PointViewMatrix.txt');
    PVM = importdata('oursPVM.txt');
    
    Final_S = {};
    pointCloud_points = {};
    for i = 1:2:(size(PVM,1)-9)
        [~,S,columns] = SfM(i,i+9,1,PVM);
        Final_S{end+1} = S;
        pointCloud_points{end+1} = columns
    end
    
    
    for i = 2:10
        if i == 2
            Final_View  = Final_S{i};
            Z = Final_S{i};
           [~,Z] = procrustes(Z,Final_S{i+1});
        else
            %if size(Z,2) < size(Final_S{i+1},2)    
            %    [~,Z] = procrustes(Z, Final_S{i+1}(:,1:size(Z,2)));
            %else
            %    [~,Z] = procrustes(Z, Final_S{i+1});
            %end
            [~,Z] = procrustes(Final_View(:,end-300:end), Final_S{i+1});
                
        end
        Final_View = [Final_View, Z];
        Final_View = Final_View(:,~(Final_View(3,:) < -1));
        Final_View = Final_View(:,~(Final_View(3,:) > 2));
        %figure;
        %scatter3(Final_View(1,:),Final_View(2,:),Final_View(3,:),5,'filled');
        %drawnow;
        
    end
    Final = Final_View(:,~(Final_View(3,:) < -1));
    scatter3(Final(1,:),Final(2,:),Final(3,:),5,'filled');

end