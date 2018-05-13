function  SfM(size_consecutive_images,plot,PVM) 

% 	PVM = chaining();


	% Xs = PVM(1:2:end,:);
  	% Ys = PVM(2:2:end,:); 
 	% D = [Xs; Ys]; 

	D=PVM(1:size_consecutive_images,:);
	size(D)
	D(:,any(D'==0,2)) = [];
	size(D)
	mean_D = mean(D,2);
	D = D - mean_D;
	size(D)

	[U,S,V] = svd(D);
	U = U(:,1:3);
	S = S(1:3,1:3);
 	V = V';
	V = V(1:3,:);

	M = U * sqrt(S);
	S = sqrt(S) * V;

	
	
	% A = []
	% B = []
	% for i=1:2:size(M,1)
	% 	x_i = M(i,:);
	% 	y_i = M(i+1,:);
	% 	Motion_matrix = [x_i.*x_i ; y_i.*y_i; x_i.*y_i];
	% 	A = [A ; Motion_matrix];
	% 	B = [B ; (inv(Motion_matrix)')];
	% end
	% x = Motion_matrix \ (inv(Motion_matrix)')

	% [C,p] = chol(x)
	
	% M = M * C;
 %    S  = C' \ S ;

 	scatter3(S(1,:),S(2,:),S(3,:),'filled');
%     scatter3(M(:,1)',M(:,2)',M(:,3)');

% if eliminate_affine_ambiguity
%         
end
	