function [R,t] = getRAndT(source,target)

weights = ones(1,size(source,2));
W = diag(weights);
weightedS = weights .* source;
weightedT = weights .* target;

centS = weightedS/weights;
centT = weightedT/weights;

X = zeros(size(source));
Y = zeros(size(source));

for x = 1:size(source,2)
   X(:,x) = source(:,x) - centS;
   Y(:,x) = target(:,x) - centT; 
end

A = X * W * Y';
[U,S,V] = svd(A);

Z = eye(size(V));
last = det(V*U');
Z(end,end) = last;
R = V * Z * U';
t = centT - R*centS;
end
