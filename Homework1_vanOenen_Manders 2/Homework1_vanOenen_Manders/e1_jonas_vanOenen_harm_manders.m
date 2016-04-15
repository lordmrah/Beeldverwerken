function e1_jonas_vanOenen_harm_manders()
    %% Exercise 1
    % Team: Jonas van Oenen, Harm Manders
    
    %% Question 2
      a = imread ( 'autumn.tif' );
      a = im2double ( rgb2gray ( a ) );
    
      subplot(2,3,1)
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
     subplot(2,3,2)
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

    
    %% Question 4
     a = imread('cameraman.tif');
     a = im2double(a);
     a(1, 1) = 0;
     a(1,1)
     l = size(a);
     %image = myAffine(a,128,-53.019,-53,128,309,128,l(1),l(2),'linear');
     uv = [-53,128;128,-53;128,309]';
     image = myAffine(a,uv,l(1),l(2),'linear');
     subplot(2,3,3)
     imshow(image)
     title('Question 4')
     
     
     %% Question 5
     img = imread('attachments/flyers.png');
     img = im2double(rgb2gray(img));
     m = 100;
     n = 75;
 
     uv = [1,1;n,1;n,m;1,m];
     xy = [571,188;822,173;593,587;354,556];
     P = createProjectionmatrix(xy, uv);
     projImg = myProjection(img, P, m,n,'linear');
     subplot(2,3,4);
     imshow(projImg)
     title('Question 5');
        
     
     img = imread('attachments/flyers.png');
     img = im2double(rgb2gray(img));
     m1 = 100;
     n1 = 100;
     uv1 = [1,1;n1,1;n1,m1;1,m1];
     xy1 = [153,584;105,377;304,213;392,395];
     P1 = createProjectionmatrix(xy1,uv1);
     projImg1 = myProjection(img, P1, m1, n1,'linear');
     subplot(2,3,5);
     imshow(projImg1);
     title('Question 5')
     
     %%Question 7
     XYZ = [];
     load('attachments/calibrationpoints.mat');
     M = estimateProjectionmatrix(xy, XYZ)
     
     %%Question 8
     img = imread('attachments/calibrationpoints.jpg');
     subplot(2,3,6)
     imshow(img)
     Cube = createCube(10,[1,1,1])
     subPlotFaces(Cube);
     
     
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