%Jerry Chen
%I pledge my honor that I have abided by the Stevens Honor System.

imname = input('Select image ');
I = imread(imname);
I = im2double(I);

%gaussian filter
GF1 = GaussianFilter(I,2);
% sigma = input('Set sigma ');
% sz = sigma*6 + 1;
% g = zeros(sz,sz);
% center = sigma*3 + 1;
% for i = 1:sz
%     for j = 1:sz
%         g(i,j) = exp(-((i-center).^2+(j-center).^2)/(2*sigma.^2))/(2*pi*sigma.^2);
%     end
% end
% GF1 = imfilter(I,g,'replicate');
%GF2 = imgaussfilt(I,sigma);
%montage({I,GF1})
%title("Original Image Vs. Gaussian Image (σ = " + sigma + ")")

%hsobelf = fspecial('sobel');
%[Gmag,Gdir] = imgradient(Gx,Gy);
sobelmatrix = [1 0 -1; 2 0 -2; 1 0 -1];
Gx = imfilter(GF1, sobelmatrix', 'replicate');
Gy = imfilter(GF1, sobelmatrix, 'replicate');
Mag = sqrt(Gx.^2 + Gy.^2);
Norm = Mag;
Dir = atand(Gy./Gx);
%threshold gradient for 0.2
for i = 1:size(Mag,1)
    for j = 1:size(Mag,2)
        if Mag(i,j) < 0.15
            Mag(i,j) = 0;
        end
    end
end
%montage({Norm,Mag})
%title("Normal Gradient Vs. Thresholded Gradient (σ = " + sigma + ")")

%non-maximum suppression
Thresh = Mag;
ht = size(Mag,1);
wd = size(Mag,2);
for i = 1:ht
    for j = 1:wd
        if Mag(i,j) ~=0
            degrees = Dir(i,j);
            neighbor1 = 0;
            neighbor2 = 0;
            if (degrees >= 67.5 || degrees < -67.5)
                %vertical
                if j < wd
                    neighbor1 = Mag(i,j+1);
                end
                if j > 1
                    neighbor2 = Mag(i,j-1);
                end
                if (Mag(i,j) >= neighbor1)
                    if neighbor1 ~= 0
                        Mag(i,j+1) = 0;
                    end
                end
                if (Mag(i,j) >= neighbor2)
                    if neighbor2 ~= 0
                        Mag(i,j-1) = 0;
                    end
                end
                if (Mag(i,j) < neighbor1 || Mag(i,j) < neighbor2)
                    Mag(i,j) = 0;
                end
            end
            if (degrees >= 22.5 && degrees < 67.5)
                %45diagonal
                if (i < ht && j < wd)
                    neighbor1 = Mag(i+1,j+1);
                end
                if (i > 1 && j > 1)
                    neighbor2 = Mag(i-1,j-1);
                end
                if (Mag(i,j) >= neighbor1)
                    if neighbor1 ~= 0
                        Mag(i+1,j+1) = 0;
                    end
                end
                if (Mag(i,j) >= neighbor2)
                    if neighbor2 ~= 0
                        Mag(i-1,j-1) = 0;
                    end
                end
                if (Mag(i,j) < neighbor1 || Mag(i,j) < neighbor2)
                    Mag(i,j) = 0;
                end
            end
            if (degrees >= -22.5 && degrees < 22.5)
                %horizontal
                if i < ht
                    neighbor1 = Mag(i+1,j);
                end
                if i > 1
                    neighbor2 = Mag(i-1,j);
                end
                if (Mag(i,j) >= neighbor1)
                    if neighbor1 ~= 0
                        Mag(i+1,j) = 0;
                    end
                end
                if (Mag(i,j) >= neighbor2)
                    if neighbor2 ~= 0
                        Mag(i-1,j) = 0;
                    end
                end
                if (Mag(i,j) < neighbor1 || Mag(i,j) < neighbor2)
                    Mag(i,j) = 0;
                end
            end
            if (degrees >= -67.5 && degrees < -22.5)
                %-45diagonal
                if (i > 1 && j < wd)
                    neighbor1 = Mag(i-1,j+1);
                end
                if (i < ht && j >1)
                    neighbor2 = Mag(i+1,j-1);
                end
                if (Mag(i,j) >= neighbor1)
                    if neighbor1 ~= 0
                        Mag(i-1,j+1) = 0;
                    end
                end
                if (Mag(i,j) >= neighbor2)
                    if neighbor2 ~= 0
                        Mag(i+1,j-1) = 0;
                    end
                end
                if (Mag(i,j) < neighbor1 || Mag(i,j) < neighbor2)
                    Mag(i,j) = 0;
                end
            end
        end
    end
end

% montage({Thresh,Mag})
% title("Thresholded Gradient Vs. Suppressed (σ = " + sigma + ")")
montage({I,GF1,Gx,Gy,Norm,Thresh,Mag})


