function [predicted,R_new,t_new,RMS]  = ICP(source, target, varargin)

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
        indexes = randperm(length(source)-1,varargin{2});
        predicted = source(:,indexes);
        target = target(:,indexes);
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
while RMS ~= RMSold
    fprintf('RMS %d and RMSold %d\n', RMS, RMSold);

    [match,RMSold] = getMatchesAndRMS(predicted,target);

    [R{end+1},t{end+1}] = getRAndT(predicted,target);

    predicted = R{end} * predicted + t{end};
    
    [match,RMS] = getMatchesAndRMS(predicted,target);
    % sandom sampling 
    if strcmp(varargin{1},'random')
        indexes = randperm(length(source)-1,varargin{2});
        predicted = source(:,indexes);
        target = target(:,indexes);
        for x = 1:size(R)
            predicted = R{x} * predicted + t
        end 
    end
end
R_new = eye(3)
t_new=0
for x = 1:size(R)
   t_new = t_new +  R_new * t{x} 
   R_new = R_new * R{x}
end
source =  R_new*source + t_new;
end

