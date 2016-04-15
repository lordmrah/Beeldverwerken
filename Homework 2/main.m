function main()
   
    %% Question 1
    img = imread('cameraman.jpg');
    
    % Motion blur
    subplot(3,2,1)
    imshow(img)
    G = (1/6)*[1,1,1,1,1,1];
    image = filterImage(img, G);
    subplot(3,2,2);
    imshow(image);
    
    % Optical blur
    subplot(3,2,3)
    imshow(img)
    n = 3;
    G = (1/n^2)*ones(n)
%     G = (1/9)*[1,1,1;1,1,1;1,1,1];
    image = filterImage(img, G);
    subplot(3,2,4);
    imshow(image);
    
    % Unsharp masking
    subplot(3,2,5)
    imshow(img)
    n = 10;
    G = (1/n^2)*ones(n)
%     G = (1/6)*[1,1,1,1,1,1];
    blurImage = filterImage(img, G);
    image2 = img+(img-blurImage);
    subplot(3,2,6);
    imshow(image2);
    
    subplot(3,2,5)
    imshow(img)
    
    
    
    function filteredImage = filterImage(img, G)
        filteredImage = imfilter(img, G, 'conv', 'replicate');
    end

end