
function borderedImage = addBorder(image, angle)
    % Create the necessary rotation matrix
    rotationMatrix = [cos(angle),sin(angle);-sin(angle),cos(angle)];
    
    % Obtain indices needed for interpolation
    [imSizeX, imSizeY] = size(image);
    center = [(imSizeX+1)/2;(imSizeY+1)/2];
    
    RBM = [rotationMatrix, center-rotationMatrix*center;0,0,1];
    
    cornerMatrix = [1,1,imSizeX,imSizeX;1,imSizeY,1,imSizeY;1,1,1,1];
    rotCornM = RBM*cornerMatrix;
    Mcell = mat2cell(rotCornM,ones(3,1),4);
    Xmax = max(Mcell{1});
    Xmin = min(Mcell{1});
    Ymax = max(Mcell{2});
    Ymin = min(Mcell{2});
    maxDiff = 0;
    if 1 - Xmin > maxDiff
        maxDiff = 1 - Xmin;
    end
    if 1 - Ymin > maxDiff
        maxDiff = 1 - Ymin;
    end
    if Xmax - imSizeX > maxDiff
        maxDiff = Xmax - imSizeX;
    end
    if Ymax - imSizeY > maxDiff
        maxDiff = Xmax - imSizeY;
    end
    maxDiff = ceil(maxDiff);
    
    corBor = zeros(maxDiff,maxDiff);
    verBor = zeros(imSizeX,maxDiff);
    horBor = zeros(maxDiff,imSizeY);
    
    borderedImage = [corBor, horBor, corBor;
                    verBor, image, verBor;
                    corBor, horBor, corBor];
    
end