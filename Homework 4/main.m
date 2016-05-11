function main()
% Read all images in attachments
    bill = imread('attachments/billboard.png');
    box = imread('attachments/box.png');
    shape = imread('attachments/shapes.png');
    szel = imread('attachments/szeliski.png');
% Choose what image to use
    RGB = shape;
    ThreshMin = 0.1;
    ThreshMax = 0.5;
    nTheta = 1000;
    nRho = 500;
    
    
    
    I = rgb2gray(RGB);
    BW = edge(I,'Canny',[ThreshMin,ThreshMax]);
    h = hough(I,[ThreshMin,ThreshMax],nRho,nTheta);
    
%     size(accumMatrix)
%     imshow(h,'XData',ThetaRange,'YData',RhoRange,'InitialMagnification','fit')
    normH = h - min(h(:));
    normH = normH ./ max(normH(:));
    
%     colormap(hot)
    
%     axis on, axis normal, hold on;
    
    subplot(2,2,1);
    imshow(RGB);
    subplot(2,2,2);
    imshow(BW)
    subplot(2,2,[3,4]);
    imshow(normH)
%     colormap(hot)
    xlabel('\theta'), ylabel('\rho');
    
    %%%% THEORY QUESTIONS %%%%%
    % 1.
    % 2: When \rho is negative \theta is 180 - the \theta that correlates
    % with -1*\rho.
    % The two differences between the two intersections is that the
    % "direction" of the lines are different.
    
end