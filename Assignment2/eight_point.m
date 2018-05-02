function [F] = eight_point(first_image_points, second_image_points,norm)

    if (norm == 1)
       [T1, first_image_points] = get_normalise_matrix(first_image_points);
       [T2, second_image_points] = get_normalise_matrix(second_image_points);
    end

    A = zeros(size(first_image_points,2), 9);

    for i = 1:size(first_image_points,2)
        x1 = first_image_points(1,i);
        xd1 = second_image_points(1,i);
        y1 = first_image_points(2,i);
        yd1 = second_image_points(2,i);
        
        A(i,:) = [x1*xd1, x1*yd1, x1, y1*xd1, y1*yd1, y1, xd1, yd1, 1];    
    end

    [~,~,V] = svd(A);
    
    F = V(:,9);
    F = reshape(F,3,3);

    [Uf,Df,Vf] = svd(F);
    
    Df(3,3) = 0;
    
    F = Uf * Df * Vf';
    
    if (norm == 1)
        F = T1'*F*T2;
    end

end

