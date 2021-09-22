function class = assign(train_hist,test_hist)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   coast,forest,insidecity
[n,bins,~] = size(train_hist);
nearest = inf;
idx = 0;
for i = 1:n
    dist = 0;
    for j = 1:bins
        for k = 1:3
            dist = dist + ((test_hist(j,k) - train_hist(i,j,k))^2);
        end
    end
    dist = sqrt(dist);
    if dist < nearest
        nearest = dist;
        idx = i;
    end
end
if idx <= 4
    class = "coast";
elseif idx > 4 && idx <=8
    class = "forest";
else
    class = "insidecity";
end
end

