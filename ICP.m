function source = ICP(source, target, type)

%if ndims == 2
%    type = 'all'
%end
switch(type)
    case 'all'
        %Nothing
    case 'uniform'
        source;
    case 'random'
        original_source = source
        indexes = randperm(length(source)-1,length(source)/4);
        source = source(:,indexes)
        target = target(:,indexes)
    case 'informative'
        
    otherwise
        %Nothing
end


R = eye(size(source,1));
t = 0;
RMSold = 0;
RMS = 1;
while RMS ~= RMSold
    fprintf('RMS %d and RMSold %d\n', RMS, RMSold);
    [match,RMSold] = getMatchesAndRMS(source,target);

    [R,t] = getRAndT(source,target);

    source = R*source + t;
    
    [match,RMS] = getMatchesAndRMS(source,target);
end
    source = R*original_source + t;
end