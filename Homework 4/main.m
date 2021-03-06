function main()

    %%%%%%%%%%%%%% NOTES %%%%%%%%%%%%%%%
    % Just press Run and enjoy the fun %
    % Harm Manders and Lucas de Vries  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
% Read all images in attachments
    bill = imread('attachments/billboard.png');
    box = imread('attachments/box.png');
    shape = imread('attachments/shapes.png');
    szel = imread('attachments/szeliski.png');
% Choose what image to use
    RGB = szel;
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
%     Use "dilation" or "normal" for the two methods of finding maxima
    lines = houghlines(I,h,.25, 'dilation');
%     lines = houghlines(I,h,.25, 'normal')

    [Y,X] = find(BW);
    points = [Y, X];
    subplot(3,2,5);
    imshow(RGB);
    hold on;
    for i=1:length(lines)
        linePoints = points_of_line(points,lines(i,:),5);
        lineCoords = line_through_points(linePoints);
        line(lineCoords(1,:),lineCoords(2,:));
    end
    title('Cant find good lines');
    figure
%     aditional Hugh transforms
    showhoughs();
    
    
end