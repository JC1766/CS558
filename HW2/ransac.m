function [best_line, best_inliers] = ransac(img,s,t,p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[y,x] = find(img > 0);
feature_points = [x y];
total_points = length(feature_points);
N = Inf;
count = 0;
best_count = 0;
best_inliers = [];
best_line = [];
while N > count
    index1 = 0;
    index2 = 0;
    while (index1==index2)
        index1 = randi(total_points);
        index2 = randi(total_points);
    end
    p1 = feature_points(index1,:);
    p2 = feature_points(index2,:);

    a = p1(2)-p2(2);
    b = p2(1)-p1(1);
    d = p1(2)*p2(1)-p1(1)*p2(2);
    distance = zeros(total_points,1);
    for i = 1:total_points
        x = feature_points(i,1);
        y = feature_points(i,2);
        distance(i) = (abs(a*x+b*y-d))/(sqrt(a^2+b^2));
    end
    inliers = find(distance <= t);
    if (length(inliers) > best_count)
        best_count = length(inliers);
        best_inliers = feature_points(inliers,:);
        best_line = [a b d];
    end
    e = 1 - length(inliers)/total_points;
    N = log(1-p)/log(1-power((1-e),s));
    count = count + 1;
end
end


