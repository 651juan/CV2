function source = ICP(source, target)
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

end