function  [mean_over_data, X, X_test] = PCAproof ( trainset, testset)
% This function makes sure that PCA can be used, so it creates the matrix X
% with all training examples (minus the mean of the data) and X_test with
% all test examples (minus the mean of the data). 

% To calculate the mean of the data, we cheate an empty 16800x1 vector and
% add all training examples to this empty vector. Then we devide by the
% total number of training examples to get the mean: mean_over_data.
trainset_mean = zeros(16800,1);

for i = 1:size(trainset,1)
    trainset_mean = trainset_mean + trainset{1,i}.img;
end
mean_over_data = trainset_mean ./ size(trainset,2);

% Next we want alle the training examples, corrected by the mean of the
% data, to be in a matrix. Again, we make an empty matrix of size
% 16800x#trainingexamples. 
% Then, we add the corrected (train - mean) training examples to the matrix
% X. We call this X for convenience. 
X = zeros(16800,size(trainset,2));
for i = 1:size(trainset,2)
    X(:,i) = trainset{1,i}.img - mean_over_data;
end
% According the assignment the dimensions must be n x d, with n the nr of
% examples (300) and d the nr of data dimensions (16800). So we transpose
% the matrix. 
X = X';
size(X)
% Repeat this proces for the (corrected) test examples. Call the matrix
% X_test. After this, PCA can be used, and the data is in the right form. 
X_test = zeros(16800, size(testset,2));
for j = 1:size(testset,2)
    X_test(:,j) = testset{1,j}.img - mean_over_data;
end
% According the assignment the dimensions must be n x d, with n the nr of
% examples (250) and d the nr of data dimensions (16800). So we transpose
% the matrix. 
X_test = X_test';