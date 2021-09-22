function res = pix_assign(word_bank,img)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[ht,wd,~] = size(img);
res = img;
for i = 1:ht
    for j = 1:wd
        closest = inf;
        idx = 0;
        rbg = double(img(i,j,:));
        for k = 1:length(word_bank)
            wrbg = double(word_bank(k,:));
            r = wrbg(1)-rbg(1);
            b = wrbg(2)-rbg(2);
            g = wrbg(3)-rbg(3);
            dist = norm([r,b,g]);
            if dist < closest
                closest = dist;
                idx = k;
            end
        end
        if idx <= 10
            res(i,j,:) = [0,0,255];
        end
    end
end
end

