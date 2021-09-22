function result = thresh(img,threshold)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[ht,wd] = size(img);
result = zeros(ht,wd);
for i = 1:ht
    for j = 1:wd
        if img(i,j) < threshold
            result(i,j) = 0;
        else 
            result(i,j) = img(i,j);
        end
    end
end
end

