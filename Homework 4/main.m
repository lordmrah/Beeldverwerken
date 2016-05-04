function main()
% Read all images in attachments
    bill = imread('attachments/billboard.png');
    box = imread('attachments/box.png');
    shape = imread('attachments/shapes.png');
    szel = imread('attachments/szeliski.png');
% Choose what image to use
    RGB = shape;
    
    I = rgb2gray(RGB);
    BW = edge(I,'canny');
    
%     [H,T,R] = hough(BW, 'RhoResolution', 0.5, 'ThetaResolution', 0.5);
    
    RhoRes = 0.5;
    ThetaRes = 0.5;
    ThetaRange = [0,180];
    [N,M] = size(I);
    D = sqrt(M^2+N^2);
    RhoRange = [-D,D];
    RhoVal = RhoRange / RhoRes;
    ThetaVal = ThetaRange / ThetaRes;
    accumMatrix = zeros(round(diff(RhoVal)),round(diff(ThetaVal))+1);
    size(accumMatrix)
% Find non-zero pixels in binary edge image
    [Y,X] = find(BW);
    for k = 1:length(X),
        x = X(k);
        y = Y(k);
        for theta=ThetaRange(1):ThetaRes:ThetaRange(2),
            rad = deg2rad(theta);
            r = x*sin(rad) - y*cos(rad);
            rI = round((r+RhoRange(2))/RhoRes);
            tI = (theta + 1)/ThetaRes;
%             val  = accumMatrix(rI,tI);
            accumMatrix(rI,tI) =  1;
        end
    end
    size(accumMatrix)
    imshow(accumMatrix,'XData',ThetaRange,'YData',RhoRange,'InitialMagnification','fit')
    colormap(hot)
    xlabel('\theta'), ylabel('\rho');
%     axis on, axis normal, hold on;
    
    subplot(2,2,1);
    imshow(RGB);
    subplot(2,2,2);
    imshow(BW)
    subplot(2,2,[3,4]);
%     imshow(imadjust(mat2gray(accumMatrix)),'XData',T,'YData',R, 'InitialMagnification','fit');
%     xlabel('\theta'), ylabel('\rho');
%     axis on, axis normal, hold on;
%     colormap(hot);
    
    %%%% THEORY QUESTIONS %%%%%
    % 1.
    % 2: When \rho is negative \theta is 180 - the \theta that correlates
    % with -1*\rho.
    % The two differences between the two intersections is that the
    % "direction" of the lines are different.
    
end