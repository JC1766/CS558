function [I_map,seg] = slic(img,max_it)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[ht,wd,~] = size(img);
seg = img;
%Divide into 50*50 blocks
b_num = (ht*wd)/2500;
%[x,y,R,G,B]
c_map = zeros(b_num,5);
converging = true;
it = 1;
for i = 1:ht/50
    x = 25+50*(i-1);
    for j = 1:wd/50
        y = 25+50*(j-1);
        idx = 15*(i-1)+j;
        c_map(idx,1) = x;
        c_map(idx,2) = y;
        c_map(idx,3:5) = img(x,y,:);
    end
end



while converging
    %compute gradient
    for j = 1:b_num
        window = zeros(3,3);
        
        for x = -1:1
            for y = -1:1
                window(x+2,y+2) = rgb_grad(c_map(j,1)+x,c_map(j,2)+y,img);
            end
        end
        [minw,idx] = min(window);
        [~,miny] = min(minw);
        minx = idx(miny);
        c_map(j,1:2) = c_map(j,1:2) + [minx-2,miny-2];
        c_map(j,3:5) = img(c_map(j,1),c_map(j,2),:);
    end
    d_map = zeros(ht,wd,b_num);
    for i = 1:b_num
        for h = 1:ht
            for w = 1:wd
                d = c_map(i,:);
                d_vect = [(h-d(1))/2,(w-d(2))/2,(img(h,w,1)-d(3)),(img(h,w,2)-d(4)),(img(h,w,3)-d(5))];
                d_map(h,w,i) = norm(d_vect);
            end
        end
    end
    [~,I_map] = min(d_map,[],3);
    newc_map = zeros(b_num,5);
    cluster_rgb = zeros(b_num,3);
    for i = 1:b_num
        count = 0;
        for h = 1:ht
            for w = 1:wd
                if I_map(h,w) == i
                    rgb = img(h,w,:);
                    newc_map(i,1)  = newc_map(i,1) + h;
                    newc_map(i,2)  = newc_map(i,2) + w;
                    cluster_rgb(i,1) = cluster_rgb(i,1) + rgb(1);
                    cluster_rgb(i,2) = cluster_rgb(i,2) + rgb(2);
                    cluster_rgb(i,3) = cluster_rgb(i,3) + rgb(3);
                    count = count + 1;
                end
            end
        end
        newc_map(i,1:2) = floor(newc_map(i,1:2)/count);
        colors = img(newc_map(i,1),newc_map(i,2),:);
        newc_map(i,3:5) = colors;
        cluster_rgb(i,:) = cluster_rgb(i,:)/count;
    end


    eq = isequal(c_map,newc_map);
    
    if ~eq && it < max_it
        c_map = newc_map;
        it = it + 1;
    else
        converging = false;
        for i = 1:b_num
            for h = 1:ht
                for w = 1:wd
                    if I_map(h,w) == i
                        if border(I_map,h,w)
                            seg(h,w,:) = [0,0,0];
                        else
                            seg(h,w,:) = cluster_rgb(i,:);
                        end
                    end
                end
            end
        end
    end
end



end

