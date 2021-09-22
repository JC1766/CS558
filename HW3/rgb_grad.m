function grad = rgb_grad(x,y,img)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

r_g = norm(img(x+1,y,1)-img(x-1,y,1),img(x,y+1,1)-img(x,y-1,1));
g_g = norm(img(x+1,y,2)-img(x-1,y,2),img(x,y+1,2)-img(x,y-1,2));
b_g = norm(img(x+1,y,3)-img(x-1,y,3),img(x,y+1,3)-img(x,y-1,3));
grad = norm([r_g,g_g,b_g]);
end

