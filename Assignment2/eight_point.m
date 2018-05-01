function [F] = eight_point(first_image_points, second_image_points,norm)

if (norm == 1)
   first_image_points = normalise_points(first_image_points);
   second_image_points = normalise_points(second_image_points);
end

A = zeros(size(first_image_points,2), 9);

for i = 1:size(first_image_points,2)
    A(i,:) = [first_image_points(1,i)*second_image_points(1,i), first_image_points(1,i)*second_image_points(2,i), first_image_points(1,i), first_image_points(2,i)*second_image_points(1,i), first_image_points(2,i)*second_image_points(2,i), first_image_points(2,i), second_image_points(1,i), second_image_points(2,i), 1];    
end

[~,~,V] = svd(A);
F = V(:,9);
F = reshape(F,3,3);

[Uf,Df,Vf] = svd(F);
Df(3,3) = 0;
F = Uf * Df * Vf';

end

