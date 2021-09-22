function classify(bins,Directory)
%UNTITLED2 Summary of this function goes here
%   coast,forest,insidecity
test = dir(fullfile(Directory,'*test*.jpg')); 
train = dir(fullfile(Directory,'*train*.jpg')); 
train_hist = zeros(numel(train),bins,3);
classes = ["coast","forest","insidecity"];
range = ceil(256/bins);
check = true;
for i = 1:numel(train)
    F = fullfile(Directory,train(i).name);
    I = imread(F);
    I = double(I);
    train_hist(i,:,:) = histogram(I,bins,range);
    %train_hist(i,:,:)
    if sum(sum(train_hist(i,:,:))) ~= numel(I)
        check = false;
    end   
end

%confirmation check
if check
    disp("All pixels have voted thrice");
else
    disp("Voter fraud occurred, recount");
end
%test images
accuracy = 0;
for i = 1:numel(test)
    F = fullfile(Directory,test(i).name);
    I = imread(F);
    I = double(I);
    class = classes(ceil(i/4));
    hist = histogram(I,bins,range);
    assignment = assign(train_hist,hist);
    disp("Test image " + i + " of " + class + " has been assigned to " + assignment);
    if class == assignment
        accuracy = accuracy + 1;
    end
end
disp(accuracy*100/numel(test) + "% Accuracy");
end

