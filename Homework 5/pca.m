function [V, D, eigenvalues] = pca (X,trainset, d, mean_over_data)
covariance = 1/(size(trainset,2))*X*X';
[V,D] = eigs( X*X', d );
E = X'*V*inv(D);
for i = 1:size(E,2)
    E(:,i) = E(:,i)./norm( E(:,i) );
end


for i = 1:d
    eigenvalues(i) = D(i,i);
end
figure
plot(eigenvalues)
eigenvalues

% Plot first 9 eigenvectors as images
if d == 9
    
    for i = 1:d
        
        subplot( 3, 3, i )
        imshow( reshape( E(:,i), 112, [] ), [] )
    end
end


% % -------------------------------------------------
% 
% %-----------------------------------------------------------------
% %- Code to print an original image and estimate by d eigenvectors
% %-----------------------------------------------------------------
% X = X';
% figure
% subplot(2,1,1);
% imshow( reshape( X(:,1) + mean_over_data, 112, 150 ) )
% subplot( 2, 1, 2 );
% imshow( reshape( E(:,1) + mean_over_data, 112, 150 ) )
% %-----------------------------------------------------------------
end