function newImage = myAffine ( image , B , M , N , method )
    A = [ 0 , 0 , 1 ; N , 0, 1 ; 0 , M , 1]';
    %B = [ x1 , y1; x2 , y2 ; x3 , y3 ];
    Rotation = B / A;
    
    X = repmat([1:M],1,N);
    Y = reshape(repmat([1:N],M,1),[1,N*M]);
    Z = ones(1,M*N);
    pixelVectors = [X;Y;Z];
    
    newVec = Rotation * pixelVectors; 
    newImage = pixelValue ( image , newVec(1,:) , newVec(2,:),M,N, method ); % Get pixelvalue for new position
end