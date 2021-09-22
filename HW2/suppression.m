function result = suppression(img)
%UNTITLED2 Summary of this function goes here
%   non-maximum suppression in 3*3 neighborhoods
[ht,wd] = size(img);
result = zeros(ht,wd);
for i = 2:(ht - 1)
    for j = 2:(wd - 1)
        nb = img(i-1:i+1, j-1:j+1);
        if img(i,j) == max(nb(:))
            result(i,j) = img(i,j);
        end
    end
end
end

