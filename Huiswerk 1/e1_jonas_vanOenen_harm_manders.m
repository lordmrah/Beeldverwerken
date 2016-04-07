function e1_jonas_vanOenen_harm_manders()
    %% Exercise 1
    % Team: Jonas van Oenen, Harm Manders
    
    %% Question 2.1.1 + 2.1.2 + 2.1.3
     a = imread ( 'autumn.tif' );
     a = im2double ( rgb2gray ( a ) );
   
     reset ( gcf ); % this resets the (get) current figure
     hold on ; % overlay on current figure
     plot ( profile ( a , 100 , 100 , 120 , 120 , 200 , 'linear') , 'b' );
     plot ( profile ( a , 100 , 100 , 120 , 120 , 200 , 'nearest') , 'r' );
     hold off ;
   
    %% Question 3.1.1 + 3.1.2 + 3.1.3
     b = imread('cameraman.tif');
     b = im2double(b);
     
     degrees = 30; % in degrees
     angle = degtorad(degrees);
     bordImg = addBorder(b, angle);
%     
     tic
     linImg = rotateImage(bordImg, angle, 'linear');
     disp('linear:')
     toc
     imshow(linImg)
%     % Question 3.1.4
% 
     tic
     nearImg = rotateImage(bordImg, angle, 'nearest');
     disp('nearest:')
     toc
%     
     linImg = rotateImage(linImg, -angle, 'linear');
     nearImg = rotateImage(nearImg, -angle, 'nearest');
 
     linDist = calculateDist(linImg, bordImg);
     nearDist = calculateDist(nearImg, bordImg);
     
     disp('linear square error:')
     disp(linDist)
     disp('nearest square error:')
     disp(nearDist)

    
    %% Question 4.1
%     a = imread('cameraman.tif');
%     a = im2double(a);
%     l = size(a);
%      image = myAffine(a,128,-53.019,-53,128,309,128,l(1),l(2),'linear');
% %     testI = [1,2,3;4,5, 6;7,8,9];
% %     [m,n] = size(testI);
% %     image = myAffine(testI,1,1,m+1,1,1,n+1,m,n,'linear');
%      imshow(image)
%     
function newImage = myAffine ( image , x1 , y1 , x2 , y2 , x3 , y3 , M , N , method )
    A = [ 0 , 0 , 1 ; N , 0, 1 ; 0 , M , 1]';
    B = [ x1 , y1; x2 , y2 ; x3 , y3 ]';
    Rotation = B / A;
    
    X = repmat([1:M],1,N);
    Y = reshape(repmat([1:N],M,1),[1,N*M]);
    Z = ones(1,M*N);
    pixelVectors = [X;Y;Z];
    
    newVec = Rotation * pixelVectors; 
    newImage = pixelValue ( image , newVec(1,:) , newVec(2,:) , method ); % Get pixelvalue for new position
end

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
    
    %rotatedImage = [];
    rotatedImage = pixelValue(image, rotatedPixelVectors(1,:), rotatedPixelVectors(2,:),method);
    %for i = 1 : length(rotatedPixelVectors)
    %    pixelVal = pixelValue(image, rotatedPixelVectors(1,i), rotatedPixelVectors(2,i),method);
    %    rotatedImage = [rotatedImage, pixelVal];
    %end
    
    %rotatedImage = reshape(rotatedImage, imSizeY, imSizeX);
end

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

function distance = calculateDist(image, original)
    diff = (original - image).^2;
    distance = sum(diff(:));
    
end
    
function color = pixelValue( image , y, x, method )
    % pixel value at real coordinates
    
    [maxX,maxY] = size(image);
    inBoundX = not(abs(sign(sign(1 - x) + sign(maxX - x))));
    inBoundY = not(abs(sign(sign(1 - y) + sign(maxY - y))));
    x = ((x-1) .* inBoundX) + 1;
    y = ((y-1) .* inBoundY) + 1;
    

    % do the interpolation
    switch ( method )
        case 'nearest'
            % Do nearest neighbour
            colorVector = impixel(image, floor(x+0.5),floor(y+0.5));
            grayVector = colorVector(:,1);
            %color = reshape(grayVector, maxX, maxY);
            color = grayVector;
            return ;
        case 'linear'
            % Do bilinear interpolation
            k = floor(x);
            k1 = k+1;

            l = floor(y);
            l1 = l+1;

            a = x - k;
            b = y - l;
            
            
            temp = impixel(image,k,l);
            kl = reshape(temp(:,1),1, maxX*maxY);
            temp = impixel(image,k,l1);
            kl1 = reshape(temp(:,1),1, maxX*maxY);
            temp = impixel(image,k1,l1);
            k1l1 = reshape(temp(:,1),1, maxX*maxY);
            temp = impixel(image,k1,l);
            k1l = reshape(temp(:,1),1, maxX*maxY);
            colorVector = (1-a).*(1-b).*kl + (1-a).*b.*kl1 + a.*b.*k1l1 + a.*(1-b).*k1l;
            %color = reshape(colorVector, maxX, maxY);
            color = colorVector;
     end %end switch

end

function bool = inImage(sizeImage, x, y)
    if (sizeImage(1) >= x && sizeImage(2) >= y && x > 1 && y > 1)
        bool = true;
        return;
    else
        bool = false;
        return;
    end
end

function line = profile ( image , x0 , y0 , x1 , y1 , n , method )
    % profile of an image along straight line in n points
    x = linspace ( x0 , x1 , n ); 
    y = linspace ( y0 , y1 , n );
    line = pixelValue ( image , x , y , method );
end

end