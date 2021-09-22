%Jerry Chen
%I pledge my honor that I have abided by the Stevens Honor System.

%run k-means on image
I = imread('white-tower.png');
I = im2double(I);
k = 10;
[RGB_map,Seg] = kmeans(I,k);
figure(1)
montage({I,Seg})
title("Original Image Vs. Segmented Image")

%slic segmentation
Im = imread('wt_slic.png');
Im = double(Im);
max_it = 3;
[I_map,slic_seg] = slic(Im,max_it);
figure(2)
imshow(uint8(slic_seg));
title("SLIC")
