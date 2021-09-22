function [RGB_map,seg] = kmeans(img,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
seg = img;
%randomly choose 10 points
[ht,wd,ch] = size(img);
x = randi(ht,1,k);
y = randi(wd,1,k);
RGB_map = zeros(k,ch);
new_RGB = zeros(k,ch);
map = zeros(ht,wd,k);
for i = 1:k
    RGB_map(i,:) = img(x(i),y(i),:);
end
converging = true;
while converging
    %calculate distance
    for i = 1:k
        for h = 1:ht
            for w = 1:wd
                map(h,w,i) = sqrt((img(h,w,1)-RGB_map(i,1)).^2+(img(h,w,2)-RGB_map(i,2)).^2+(img(h,w,3)-RGB_map(i,3)).^2);
            end
        end
    end
    [~,I] = min(map,[],3);
    %new center
    for i = 1:k
        count = 0;
        for h = 1:ht
            for w = 1:wd
                if I(h,w) == i
                    new_RGB(i,1)  = new_RGB(i,1) + img(h,w,1);
                    new_RGB(i,2)  = new_RGB(i,2) + img(h,w,2);
                    new_RGB(i,3)  = new_RGB(i,3) + img(h,w,3);
                    count = count + 1;
                end
            end
        end
        new_RGB(i,:) = new_RGB(i,:)/count;
    end
    difference = abs(RGB_map-new_RGB);
    %check if converged
    if sum(difference) < 0.05
        converging = false;
        %produce segmented image
        for i = 1:k
            for h = 1:ht
                for w = 1:wd
                    if I(h,w) == i
                        seg(h,w,:) = RGB_map(i,:);
                    end
                end
            end
        end
    else
        RGB_map = new_RGB;
    end
end

end

