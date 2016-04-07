function e1_jonas_vanOenen_harm_manders()
    %% Exercise 1
    % Team: Jonas van Oenen, Harm Manders
    
    %% Question 2.1.1 + 2.1.2 + 2.1.3
      a = imread ( 'autumn.tif' );
      a = im2double ( rgb2gray ( a ) );
    
      subplot(2,2,1)
      hold on;
      plot ( profile ( a , 100 , 100 , 120 , 120 , 200 , 'linear') , 'b' );
      plot ( profile ( a , 100 , 100 , 120 , 120 , 200 , 'nearest') , 'r' );
      hold off;
      title('Question 2')
   
    %% Question 3.1.1 + 3.1.2 + 3.1.3
     a = imread('cameraman.tif');
     a = im2double(a);
     degrees = 30; % in degrees
     angle = degtorad(degrees);
     bordImg = addBorder(a, angle);
     
     %% Question 3.1.4
     tic
     linImg = rotateImage(bordImg, angle, 'linear');
     disp('linear:')
     toc
     subplot(2,2,2)
     imshow(linImg)
     title('Question 3');
     
     tic
     nearImg = rotateImage(bordImg, angle, 'nearest');
     disp('nearest:')
     toc
     
     linImg = rotateImage(linImg, -angle, 'linear');
     nearImg = rotateImage(nearImg, -angle, 'nearest');
 
     linDist = calculateDist(linImg, bordImg);
     nearDist = calculateDist(nearImg, bordImg);
     
     disp('linear square error:')
     disp(linDist)
     disp('nearest square error:')
     disp(nearDist)

    
    %% Question 4.1
     a = imread('cameraman.tif');
     a = im2double(a);
     a(1, 1) = 0;
     a(1,1)
     l = size(a);
     %image = myAffine(a,128,-53.019,-53,128,309,128,l(1),l(2),'linear');
     uv = [-53,128;128,-53;128,309]';
     image = myAffine(a,uv,l(1),l(2),'linear');
     subplot(2,2,3)
     imshow(image)
     title('Question 4')
     
     
     %% Question 5.1
     a = imread('attachments/flyers.png');
     a = im2double(a);
     xy = [0,0;0,400;400,400;400,0];
     uv = [350,556;571,188;821,169;594,586];
     P = createProjectionmatrix(xy, uv)
     %[m,n] = size(a);
     projImg = myProjection(a, P, 10,10,'linear');
     subplot(2,2,4);
     imshow(projImg)
     title('Q5');
     
%% Helper functions for main testing
function distance = calculateDist(image, original)
    diff = (original - image).^2;
    distance = sum(diff(:));

end    

function line = profile ( image , x0 , y0 , x1 , y1 , n , method )
    % profile of an image along straight line in n points
    x = linspace ( x0 , x1 , n ); 
    y = linspace ( y0 , y1 , n );
    for i = 1: length ( x )
        line ( i ) = pixelValue1D ( image , x ( i ) , y ( i ) , method );
    end
end

end