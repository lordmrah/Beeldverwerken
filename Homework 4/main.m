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
    
    
    
    
%     axis on, axis normal, hold on;
    
    subplot(3,2,1);
    imshow(RGB);
    subplot(3,2,2);
    imshow(BW)
    subplot(3,2,3);
    imshow(h)
    colormap(hot)
    xlabel('\theta'), ylabel('\rho');
    subplot(3,2,4);
    imshow(RGB)
    lines = houghlines(I,h,.3, 'dilation')
    %%%% THEORY QUESTIONS %%%%%
    % 1.
    % 2: When \rho is negative \theta is 180 - the \theta that correlates
    % with -1*\rho.
    % The two differences between the two intersections is that the
    % "direction" of the lines are different.
    
    [X,Y] = find(BW);
    XY = [X, Y];
    L = size(XY)
    for i=1:length(lines)
        lines(i,:)
        linePoints = points_of_line(XY,lines(i,:),1);
        size(linePoints)
    end
    
    
    
    
end