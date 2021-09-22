function GF = GaussianFilter(Image,sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sz = sigma*6 + 1;
g = zeros(sz,sz);
center = sigma*3 + 1;
for i = 1:sz
    for j = 1:sz
        g(i,j) = exp(-((i-center).^2+(j-center).^2)/(2*sigma.^2))/(2*pi*sigma.^2);
    end
end
GF = imfilter(Image,g,'replicate');
end

