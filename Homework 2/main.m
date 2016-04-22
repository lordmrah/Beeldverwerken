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
    n = 7;
    G = fspecial('gaussian', [7 7], 3)
%     G = (1/9)*[1,1,1;1,1,1;1,1,1];
    image = filterImage(img, G);
    subplot(3,2,4);
    imshow(image);
    
    % Unsharp masking
    subplot(3,2,5)
    imshow(img)
    n = 10;
    G = (1/n^2)*ones(n);
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

    function gaussGrid= Gauss(sigma)
       [X,Y] = meshgrid(-sigma:sigma, -sigma:sigma);
       
       dist = sqrt(X.*X+Y.*Y);
       gaussGrid = 1/((sqrt(2*pi)*sigma)^2)*exp(-(dist.^2)/(2*sigma^2));
       factor = sum(sum(gaussGrid));
       gaussGrid = gaussGrid./factor;
       return
    end
    Gauss(3)
    mesh(Gauss(3))
    
    









end