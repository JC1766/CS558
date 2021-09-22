function hist = histogram(img,bins,range)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[ht,wd,~] = size(img);
hist = zeros(bins,3);
for j = 1:ht
    for k = 1:wd
        rgb = img(j,k,:);
        rgb = rgb+1;
        r = ceil(rgb(1)/range);
        g = ceil(rgb(2)/range);
        b = ceil(rgb(3)/range);
        hist(r,1) = hist(r,1) + 1;
        hist(g,2) = hist(g,2) + 1;
        hist(b,3) = hist(b,3) + 1;
    end
end
end

