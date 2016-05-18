function  main()

[trainset, testset] = splitdata('omni');

[mean_over_data, X, X_test] = PCAproof ( trainset, testset);
[V, D, eigenvalues] = pca(X,trainset, 9, mean_over_data);
%[~, ~, eigenvalues] = pca(X,trainset, 50, mean_over_data);
end

