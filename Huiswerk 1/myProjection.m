function projection = myProjection(image, R, m, n, method)
    
    X = repmat([1:m],1,n);
    Y = reshape(repmat([1:n],m,1),[1,n*m]);
    Z = ones(1,m*n);
    pixelVectors = [X;Y;Z];
    
    projVect = R*pixelVectors;
    projection = pixelValue(image, projVect(1,:), projVect(2,:), method);
    
end