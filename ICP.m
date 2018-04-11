function source = ICP(source, target, varargin)

if nargin == 2
    type = 'all';
end
predicted = source;
switch(varargin{1})
    case 'all'
        %Nothing
    case 'uniform'
        reducedby = length(source)/varargin{2}
        predicted = source(:,1:reducedby:end);
        target = target(:,1:reducedby:end);
    case 'random'
        indexes = randperm(length(source)-1,varargin{2});
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