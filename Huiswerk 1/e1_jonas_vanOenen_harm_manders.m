function e1_jonas_vanOenen_harm_manders()
    %% Exercise 1
    % Team: Jonas van Oenen, Harm Manders
    
    %% Question 2.1.1 + 2.1.2 + 2.1.3
    a = imread ( 'autumn.tif' );
    a = im2double ( rgb2gray ( a ) );
    
%     reset ( gcf ); % this resets the (get) current figure
%     hold on ; % overlay on current figure
%     plot ( profile ( a , 100 , 100 , 120 , 120 , 200 , 'linear') , 'b' );
%     plot ( profile ( a , 100 , 100 , 120 , 120 , 200 , 'nearest') , 'r' );
%     hold off ;
    
    %% Question 3.1.1
    a = imread('cameraman.tif');
    rotateImage(a, 30, 'linear')
    
    
    %% Question 4.1
    plotParallelogram(0,0,0,0,1,1)
    
    
% plot a parallelogram overlayed on the current axis
% coordinates given are image coordinates
function plotParallelogram ( x1 , y1 , x2 , y2 , x3 , y3 )
    hold on ;
    plot ([ x1 , x2 , x3 , x3 - x2 + x1 , x1 ] , [ y1 , y2 , y3 , y1 - y2 + y3 , y1 ] ,'y' , 'LineWidth' , 2);
    text ( x1 , y1 , '1' , 'Color' , [0 , 1 , 0] , 'FontSize' , 18);
    text ( x2 , y2 , '2' , 'Color' , [0 , 1 , 0] , 'FontSize' , 18);
    text ( x3 , y3 , '3' , 'Color' , [0 , 1 , 0] , 'FontSize' , 18);
end

function r = myAffine ( image , x1 , y1 , x2 , y2 , x3 , y3 , M , N , method )
    r = zeros (N , M ); % allocate new image of correct size
    
    % calculate X ( insert code for this )
    A = [ x1 , x2 , x3 ; y1 , y2 , y3 ; 1 , 1 , 1];
    B = [ xx1 , xx2 , xx3 ; yy1 , yy2 , yy3 ];
    X = B / A ;

    for xa = 1: M
        for ya = 1: N
            
        newVec = X * [xa; ya; 1]; % Position vector times rotation
        x = newVec(0); % new X coordinate
        y = newVec(1); % new Y coordinate
        r ( ya , xa ) = pixelValue ( image , x , y , method ); % Get pixelvalue for new position
        end
    end
end

function rotatedImage = rotateImage ( image , angle , method )
    % Create the necessary rotation matrix
    rotationMatrix = [cos(angle),sin(angle);-sin(angle),cos(angle)];
    
    % Obtain indices needed for interpolation
    [imSizeX, imSizeY] = size(image);
    center = [(imSizeX+1)/2;(imSizeY+1)/2];
    
    RBM = [rotationMatrix, center-rotationMatrix*center;0,0,1];
    
    newMatrix = zeros(imSizeX, imSizeY);
    
    
    % Obtain colors for the whole rotatedImage matrix
    
    % using the specified interpolation method
end
    
function color = pixelValue( image , x, y, method )
    % pixel value at real coordinates
    if inImage ( size ( image ) ,x , y )
        % do the interpolation
        switch ( method )
            case 'nearest'
                % Do nearest neighbour
                color = image(floor(x+0.5),floor(y+0.5)); 
                return ;
            case 'linear'
                % Do bilinear interpolation
                k = floor(x);
                k1 = k+1;
                
                l = floor(y);
                l1 = l+1;
                
                a = x - k;
                b = y - l;
                
                color = (1-a)*(1-b)*image(k,l) + (1-a)*b*image(k,l1) + a*b*image(k1,l1) + a*(1-b)*image(k1,l);
         end %end switch
    else
        % return a constant
        color = 0;
        return ;
    end
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
    x = linspace ( x0 , x1 , n ); y = linspace ( y0 , y1 , n );
    for i = 1: length ( x )
        line ( i ) = pixelValue ( image , x ( i ) , y ( i ) , method );
    end
end

end