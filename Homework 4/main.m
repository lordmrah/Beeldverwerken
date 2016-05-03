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
    
%     [H,T,R] = hough(BW, 'RhoResolution', 1, 'ThetaResolution', 01);
    
    
    subplot(2,2,1);
    imshow(RGB);
    subplot(2,2,2);
    imshow(BW)
    subplot(2,2,[3,4]);
    imshow(imadjust(mat2gray(H)),'XData',T,'YData',R, 'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    colormap(hot);
end