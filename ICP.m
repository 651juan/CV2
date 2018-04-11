function source = ICP(source, target, type)

if nargin == 2
    type = 'all';
end
predicted = source;
switch(type)
    case 'all'
        %Nothing
    case 'uniform'
        source;
    case 'random'
        indexes = randperm(length(source)-1,length(source)/4);
        predicted = source(:,indexes)
        target = target(:,indexes)
    case 'informative'
        
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

    predicted = R{end}*predicted + t{end};
    
    [match,RMS] = getMatchesAndRMS(predicted,target);
end
for x = 1:size(R)
   source =  R{x}*source + t{x};
end

end