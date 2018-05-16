function SfM_iterative(num_of_images)
    %PVM = chaining();
    PVM = importdata('PointViewMatrix.txt');
    PVM = importdata('oursPVM.txt');
    Final_S = {};
    for i = 1:2:(size(PVM,1)-7)
        [~,S] = SfM(i,i+7,1,PVM);
        Final_S{end+1} = S;
    end
    
    
    for i = 1:size(Final_S,2)-1
        if i ~= 1
            Final_View  = Final_S{i};
            Z = Final_S{i};
        end
        [~,Z] = procrustes(Z, Final_S{i+1});
        Final_View = [Final_View, Z];
    end
    scatter3(Final_View(1,:),Final_View(2,:),Final_View(3,:),5,'filled');

end