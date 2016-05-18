function [trainset, testset] = splitdata(data)
% Function splitdata takes a dataset and splits this dataset in to a
% training set of 300 images and leaves the rest for the testset. 
load(data);

for i = 1:size(images,2)
   images{i}.img = reshape(images{i}.img, [],1);
   images{i}.img = images{i}.img./sum(images{i}.img);
   
end

% sumVal = sum(images{299}.img.^2)

trainset = images(1:300);
testset = images(301:550);

end