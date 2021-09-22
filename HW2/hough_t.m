function [H,rho_bin,theta_bin] = hough_t(img,rho_bin,theta_bin)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[y,x] = find(img > 0);
feature_points = [x y];
total_points = length(feature_points);
max_rho = norm(size(img));
rho_bin = -max_rho:rho_bin:max_rho;
theta_bin = 0:theta_bin:pi;
H_ht = length(rho_bin);
H_wd = length(theta_bin);
H = zeros(H_ht,H_wd);

for i = 1:total_points
    x = feature_points(i,1);
    y = feature_points(i,2);
    for j = 1:H_wd
        theta = theta_bin(j);
        rho = x*cos(theta) + y*sin(theta);
        rho_idx = round(rho + H_ht/2);
        H(rho_idx,j) = H(rho_idx,j) + 1;
    end
end
end

