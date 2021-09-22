%Jerry Chen
%I pledge my honor that I have abided by the Stevens Honor System.

I = imread('road.png');
I = im2double(I);
%Apply gaussian filter
sigma = 2;
GF = GaussianFilter(I,sigma);
%Apply sobel filters
ysobel = [1 0 -1; 2 0 -2; 1 0 -1];
xsobel = ysobel';
threshold = 0.1;
xx = conv2(xsobel,xsobel);
xy = conv2(xsobel,ysobel);
yy = conv2(ysobel,ysobel);
Gxx = myfilter(GF, xx);
Gxx = thresh(Gxx,threshold);
Gxy = myfilter(GF, xy);
Gxy = thresh(Gxy,threshold);
Gyy = myfilter(GF, yy);
Gyy = thresh(Gyy,threshold);
%Hessian determinant thresholding
D = (Gxx.*Gyy)-((Gxy).^2);
D = thresh(D,threshold);
%Non-maximum suppression in 3*3 neighborhoods
S = suppression(D);
montage({GF,Gxx,Gxy,Gyy,D,S})

%ransac for 4 lines
Temp = S;
t = 1;
p = 0.95;
f = figure; imshow(I), hold on;
for n = 1:4
    [line,inliers] = ransac(Temp,2,t,p);
    %find extreme inliers and plot the line
    [~, miny] = min(inliers(:, 1));
    [~, maxy] = max(inliers(:, 1));
    figure(f), hold on;
    plot(inliers([miny maxy],1), inliers([miny maxy],2), "LineWidth", 1), hold on;
    %plot inliers as 3*3 squares
    for i=1:length(inliers)
        t_idx = inliers(i,1);
        r_idx = inliers(i,2);
        [x2, y2] = meshgrid(t_idx-1:t_idx+1, r_idx-1:r_idx+1);
        hold on;
        scatter(x2(:), y2(:), 'square', 'y');
        %remove inliers after fit
        Temp(r_idx,t_idx) = 0;
    end
    hold off;
end

%hough transform for 4 lines
Temp = S;
rho_bin = 1;
theta_bin = 0.01;
[H,rho,theta] = hough_t(Temp,rho_bin,theta_bin);
f2 = figure; imagesc(H), colormap gray, hold on;
f3 = figure; imshow(I); hold on;
for i = 1:4
    %Find point with most votes and plot
    [m,idx] = max(H);
    [~,t_idx] = max(m);
    r_idx = idx(t_idx);
    figure(f2); scatter(t_idx,r_idx,'r');
    %Convert back to cartesian and plot
    r = rho(r_idx);
    t = theta(t_idx);
    x = 1:size(I,2);
    y = (r - x*cos(t))/sin(t);
    figure(f3); plot(x,y,'LineWidth',1);
    %Remove point after fit
    H(r_idx,t_idx) = 0;
end