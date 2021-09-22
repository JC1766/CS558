function pix_classify(k,Directory)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
test = dir(fullfile(Directory,'*test*.jpg')); 
train = dir(fullfile(Directory,'*train*.jpg')); 
for i = 1:numel(train)
    F = fullfile(Directory,train(i).name);
    if train(i).name == "sky_train.jpg"
        I = imread(F);
    else
        mask = imread(F);
    end
end
[ht,wd,~] = size(I);
sky_set = [];
nosky_set = [];
sky_idx = 1;
nosky_idx = 1;
for i = 1:ht
    for j = 1:wd
        if sum(mask(i,j,:)) == 255*3
            sky_set(sky_idx,:) = I(i,j,:);
            sky_idx = sky_idx + 1;
        else
            nosky_set(nosky_idx,:) = I(i,j,:);
            nosky_idx = nosky_idx + 1;
        end
    end
end
[~,sky_words] = kmeans(sky_set, k, 'EmptyAction', 'singleton');
[~,nosky_words] = kmeans(nosky_set, k, 'EmptyAction', 'singleton');
word_bank = zeros(k*2,3);
word_bank(1:k,:) = sky_words;
word_bank(k+1:2*k,:) = nosky_words;
% sky_words
% word_bank
for i = 1:numel(test)
    F = fullfile(Directory,test(i).name);
    img = imread(F);
    res = pix_assign(word_bank,img);
    figure(i)
    imshow(res)
    title("Test image " + i)
end
end

