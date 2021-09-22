function bool = border(i_map,x,y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
bool = false;
x_range = x+1;
y_range = y+1;
[ht,wd] = size(i_map);
if x_range > ht
    x_range = ht;
end
if y_range > wd
    y_range = wd;
end


pixel1 = i_map(x_range,y);
if pixel1 ~= i_map(x,y)
    bool = true;
end
pixel2 = i_map(x,y_range);
if pixel2 ~= i_map(x,y)
    bool = true;
end
end

