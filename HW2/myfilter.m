function result = myfilter(img,ft)
%UNTITLED Summary of this function goes here
%   filter with no padding
[ht,wd] = size(img);
result = zeros(ht,wd);
x = size(ft, 1) - 1;
for i = 1:(ht - x)
    for j = 1:(wd - x)
        tmp = img(i:i+x, j:j+x).*ft;
        result(i, j) = sum(tmp(:));
    end
end
end

