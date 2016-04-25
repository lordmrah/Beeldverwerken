function main()
    %% Question 1
    img = imread('cameraman.jpg');
    
    % Subplot M and N
    SPM = 4;
    SPN = 3;
    
    % Original image
    subplot(SPM,SPN,[1,4]);
    imshow(img)
    title('Original')
    
    % Motion blur
    G = (1/6)*[1,1,1,1,1,1];
    image = filterImage(img, G);
    subplot(SPM,SPN,2);
    imshow(image);
    title('Q1.1 Motion blur')
    
    % Optical blur
    n = 7;
    G = fspecial('gaussian', [7 7], 3);
    image = filterImage(img, G);
    subplot(SPM,SPN,3);
    imshow(image);
    title('Q1.2 Optical blur')
    
    % Unsharp masking
    n = 3;
    G = (1/n^2)*ones(n);
    blurImage = filterImage(img, G);
    image2 = img+(img-blurImage);
    subplot(SPM,SPN,5);
    imshow(image2);
    title('Q1.3 Unsharp masking')
   
    % Question 2
    
    %Q2.1
    G = Gauss(3);
    image = filterImage(img, G);
    subplot(SPM,SPN,6)
    imshow(image);
    title('Q2.1 Gaussian')

    function filteredImage = filterImage(img, G)
        filteredImage = imfilter(img, G, 'conv', 'replicate');
    end

    function gaussGrid= Gauss(sigma)
       [X,Y] = meshgrid(-2*sigma:2*sigma, -2*sigma:2*sigma);
%        used 2*sigma due to 2 sigma containing 98% of the belcurve
       dist = sqrt(X.*X+Y.*Y);
       gaussGrid = 1/((sqrt(2*pi)*sigma)^2)*exp(-(dist.^2)/(2*sigma^2));
       factor = sum(sum(gaussGrid));
       gaussGrid = gaussGrid./factor;
       return
    end

    %Q2.2
    sum(sum(Gauss(3)))
    
    %2.3
    subplot(SPM,SPN,7);
    mesh(Gauss(3))
    title('Q2.3 mesh')
    %2.4
    % pixels
    %2.5
    data = benchmark(1,5,10);
    subplot(SPM,SPN,[8,9]);
    scatter(data(:,1),data(:,2),15,linspace(1,10,length(data(:,1))),'filled')
    function data = benchmark(minS,maxS,N)
        img = imread('cameraman.jpg');
        data = zeros((maxS-minS+1)*N,2);
        count = 0;
        for sigma=minS:maxS,
            
            for j=1:N,
                tic;
                imfilter(img, Gauss(sigma), 'conv','replicate');
                time = toc;
                data(count*N+j,:) = [sigma,time];
            end
            count = count + 1;
        end
    end
    %2.6
    % 
    %2.7
    img = imread('cameraman.jpg');
    b1 = imfilter(img, Gauss(6), 'conv','replicate');
    b1 = imfilter(b1, Gauss(8), 'conv','replicate');
    
    b2 = imfilter(img, Gauss(10), 'conv','replicate');

    subplot(SPM,SPN,10)
    imshow(b1)
    subplot(SPM,SPN,11)
    imshow(b2)

    %% Question 3
    
    % 3.2
    subplot(SPM,SPN,14)
    gradientFxy() 
    title('Gradient Fxy')
    
    subplot(SPM,SPN,15)
    gradientFx()
    title('Gradient Fx')
    
    
    subplot(SPM,SPN,16)
    gradientFy()
    title('Gradient Fy')
    
    function result = gradientFxy()
        x = -100:100;
        y = -100:100;
        [X , Y ] = meshgrid (x , y );
        A = 1; B = 2; V = 6* pi /201; W = 4* pi /201;
        F = A * sin ( V * X ) + B * cos ( W * Y );
        imshow (F , [] , 'xData' , x , 'yData', y );
    end

    function result = gradientFx()
        x = -100:100;
        y = -100:100;
        [X , Y ] = meshgrid (x , y );
        A = 1; B = 2; V = 6* pi /201; W = 4* pi /201;
        F = A * V * cos(V * X);
        imshow (F , [] , 'xData' , x , 'yData', y );
    end

    function result = gradientFy()
        x = -100:100;
        y = -100:100;
        [X , Y ] = meshgrid (x , y );
        A = 1; B = 2; V = 6* pi /201; W = 4* pi /201;
        F = -B * W * sin(W * Y);
        imshow (F , [] , 'xData' , x , 'yData', y );
    end

end