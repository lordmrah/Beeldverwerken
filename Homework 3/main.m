function main()
% read images and transform them to gray
    im1 = imread('nachtwacht1.jpg');
    im2 = imread('nachtwacht2.jpg');

    im1 = single(rgb2gray(im1));
    im2 = single(rgb2gray(im2));
% Get features from images    
    [f1,d1] = vl_sift(im1);
    [f2,d2] = vl_sift(im2);
% Match features to each other with threshold=2    
    [matches, scores] = vl_ubcmatch(d1,d2,2);
% Create matrix with all coord of im1 and im2 that correspond to each other
% with their scores, then sort them in descending order.
    F = [f1(1,matches(1,:));f1(2,matches(1,:));f2(1,matches(1,:));f2(2,matches(1,:));scores];
    
    [Y,I] = sort(F(5,:));
    S = F(:,I);
    D = fliplr(S);
    
% Max amount of points to display
    MaxP = length(F);

% Plot both images with the matched features.
    subplot(2,2,1);
    imshow(uint8(im1));
    hold on;

    for i=1:length(D),
       text(D(1,i)+2,D(2,i)+2,sprintf('%02d',i),'Color','r'); 
    end
    scatter(D(1,1:MaxP),D(2,1:MaxP),'r');

    subplot(2,2,2);
    imshow(uint8(im2))
    hold on;
    for i=1:length(D),
       text(D(3,i)+2,D(4,i)+2,sprintf('%02d',i),'Color','g'); 
    end
    scatter(D(3,1:MaxP),D(4,1:MaxP),'g');
%%%% MOSAICING WITH SIFT MATCHES %%%%%%
% Create matrices with coordinates of best matched features
    projCoord1 = [D(1,1:4);D(2,1:4)];
    projCoord2 = [D(3,1:4);D(4,1:4)];
    
    f1 = imread('nachtwacht1.jpg');
    f2 = imread('nachtwacht2.jpg');
    
    T = maketform('projective',createProjectionMatrix(projCoord1', projCoord2'))
    [x y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

    xdata = [min(1,x(1)) max(size(f2,2),x(2))];
    ydata = [min(1,y(1)) max(size(f2,1),y(2))];
    f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
    f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
    subplot(2,2,[3,4]);
    imshow(max(f12,f22));
    
    
end