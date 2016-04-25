function rotatedImage = rotateImage ( image , angle , method )
    
    % Create the necessary rotation matrix
    rotationMatrix = [cos(angle),sin(angle);-sin(angle),cos(angle)];
    
    % Obtain indices needed for interpolation
    [imSizeX, imSizeY] = size(image);
    center = [(imSizeX+1)/2;(imSizeY+1)/2];
    
    RBM = [rotationMatrix, center-rotationMatrix*center;0,0,1];
    
    X = repmat([1:imSizeY],1,imSizeX);
    Y = reshape(repmat([1:imSizeX],imSizeY,1),[1,imSizeX*imSizeY]);
    Z = ones(1,imSizeY*imSizeX);
    pixelVectors = [X;Y;Z];
    
    rotatedPixelVectors = RBM*pixelVectors;
    rotatedImage = pixelValue(image, rotatedPixelVectors(1,:), rotatedPixelVectors(2,:),imSizeX, imSizeY,method);
end