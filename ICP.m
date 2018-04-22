function [source,R_new,t_new,RMS]  = ICP(source, target,rejecting,weighting_tech, varargin)

if nargin == 2
    type = 'all';
end
predicted = source;
switch(varargin{1})
    case 'all'
        %Nothing
    case 'uniform'
        reducedby = length(source)/varargin{2};
        predicted = source(:,1:reducedby:end);
        reducedby = length(target)/varargin{2};
        target = target(:,1:reducedby:end);
    case 'random'
        % indexes = randperm(length(source)-1,varargin{2});
        % predicted = source(:,indexes);
        % indexes = randperm(length(target)-1,varargin{2});
        % target = target(:,indexes);
        original_target = target 
    case 'informative'
        %% using normal space sampling.
        target = get_normal_space_sample(source,varargin{3},varargin{2});
    otherwise
        %Nothing
end


R = {};
t = {};
RMSold = 0;
RMS = 1;
max_iter=0;
weight_vector=0;
while RMS ~= RMSold
    max_iter=max_iter+1;
    fprintf('RMS %d and RMSold %d\n', RMS, RMSold);

    if strcmp(varargin{1},'random')

        indexes = randperm(length(source)-1,varargin{2});
        predicted = source(:,indexes);
        indexes = randperm(length(original_target)-1,varargin{2});
        target = original_target(:,indexes);

        for x = 1:size(R)
            predicted = R{x} * predicted + t{x};
        end 

    end

    [match,dist,RMSold] = getMatchesAndRMS(predicted,target);
    target = target(:, match);



    % Rejecting pair mathods
    if rejecting ~= 0
        [predicted_RT,target_RT,index]  = rejecting_pairs(predicted,target, dist,rejecting);
        dist(index)=[];
    else
        predicted_RT = predicted;
        target_RT = target;
    end


    % Weighting pair methods
    if weighting_tech == 1
        weight_vector = weighting_of_pairs(dist,'max');
    end

    [R{end+1},t{end+1}] = getRAndT(predicted_RT,target_RT,weight_vector);

    predicted = R{end} * predicted + t{end};
    %predicted_RT = R{end} * predicted_RT + t{end};

    [match,dist,RMS] = getMatchesAndRMS(predicted,target);
    % sandom sampling 
    
    if max_iter==100
        break
    end
end
R_new = eye(3)
t_new=0
for x = 1:size(R)
   t_new = t_new + R_new * t{x} 
   R_new = R{x} * R_new 
end

source =  R_new * source + t_new;

end

