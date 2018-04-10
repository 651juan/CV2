function [match,RMS] = getMatchesAndRMS(source,target)
noOfPoints = size(source,2);
dimensions = size(source,1);
match = zeros(1,noOfPoints);
minimumDist = zeros(1,noOfPoints);
for x = 1:noOfPoints
    dist = zeros(1,noOfPoints);
    for n = 1:dimensions
        dist = dist + (source(n,x) - target(n,:)).^2;
    end
    [value,index] = min(dist);
    match(x) = index;
    minimumDist = value;
end
RMS = sqrt((1/noOfPoints) * sum(minimumDist));
end

