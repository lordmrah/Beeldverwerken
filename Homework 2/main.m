function main()
    %% Question 1
    img = imread('cameraman.jpg');
    
    % Subplot M and N
    SPM = 6;
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
    
    %2.1
% used 2*sigma due to 2 sigma containing 98% of the belcurve
% So our kernelsize is size (1+2*sigma)x(1+2*sigma)
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
       dist = sqrt(X.*X+Y.*Y);
       gaussGrid = 1/((sqrt(2*pi)*sigma)^2)*exp(-(dist.^2)/(2*sigma^2));
       factor = sum(sum(gaussGrid));
       gaussGrid = gaussGrid./factor;
       return
    end

    %2.2
% We'd expect to be 1 as the awnser, in the Gauss() func. we normalised 
% the kernel to achieve this.
    kernelSum = sum(sum(Gauss(3)))
    
    %2.3
    subplot(SPM,SPN,7);
    mesh(Gauss(3))
    title('Q2.3 mesh')
    %2.4
% The visible scale parameter is pixels
    %2.5
    data = benchmark(1,20,10);
    %when you to till 1000 you'll see its O(n r^2)
    subplot(SPM,SPN,[8,9]);
    scatter(data(:,1),data(:,2),15,linspace(1,10,length(data(:,1))),'filled')
    function data = benchmark(minS,maxS,N)
        img = imread('cameraman.jpg');
        data = zeros((maxS-minS+1)*N,2);
        count = 0;
%         temp = maxS / 250;
        for sigma=minS:maxS,
%             sigma = sigma *250;
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
% The computational complexity of a Gaussian blur is O(n*sigma^2)
    %2.7
    img = imread('cameraman.jpg');
    b1 = imfilter(img, Gauss(6), 'conv','replicate');
    b1 = imfilter(b1, Gauss(8), 'conv','replicate');
    
    b2 = imfilter(img, Gauss(10), 'conv','replicate');

    subplot(SPM,SPN,10)
    imshow(b1)
    title('sig=6 and sig=8')
    subplot(SPM,SPN,11)
    imshow(b2)
    title('sig=10')
    
    %2.8
    function gaussGrid = Gauss1(sigma)
        X = meshgrid(-2*sigma:2*sigma);
        dist = sqrt(X.*X);
        gaussGrid = 1/((sqrt(2*pi)*sigma)^2)*exp(-(dist.^2)/(2*sigma^2));
        row = gaussGrid(1,:);
        factor = sum(row);
        gaussGrid = row./factor;
        return
    end
    Gauss1Sum = sum(Gauss1(3))
    %2.9
    data = benchmark1D(1,20,20);
    subplot(SPM,SPN,12);
    scatter(data(:,1),data(:,2),15,linspace(1,10,length(data(:,1))),'filled')
    function data = benchmark1D(minS,maxS,N)
        img = imread('cameraman.jpg');
        data = zeros((maxS-minS+1)*N,2);
        count = 0;
%         temp = maxS / 250;
        for sigma=minS:maxS,
            g1 = Gauss1(sigma);
            for j=1:N,
                tic;
                horFilter = imfilter(img, g1, 'conv','replicate');
                imfilter(horFilter, g1', 'conv','replicate');
                time = toc;
                data(count*N+j,:) = [sigma,time];
            end
            count = count + 1;
        end
    end
    
    subplot(SPM,SPN,12)

    %% Question 3
    % 3.1 see LaTeX
    % 3.2
    x = -100:100;
    y = -100:100;
    [X , Y ] = meshgrid (x , y );
    A = 1; B = 2; V = 6* pi /201; W = 4* pi /201;
    Fxy = A * sin ( V * X ) + B * cos ( W * Y );
    Fx = A * V * cos(V * X);
    Fy = -B * W * sin(W * Y);
    
    subplot(SPM,SPN,13)
    imshow (Fxy , [] , 'xData' , x , 'yData', y );
    title('Gradient Fxy')
    
    subplot(SPM,SPN,14)
    imshow (Fx , [] , 'xData' , x , 'yData', y );
    title('Gradient Fx')
    
    
    subplot(SPM,SPN,15)
    imshow (Fy , [] , 'xData' , x , 'yData', y );
    title('Gradient Fy')
    % 3.3
    xx = -100:10:100;
    yy = -100:10:100;
    [XX , YY ] = meshgrid (xx , yy );
    A = 1; B = 2; V = 6* pi /201; W = 4* pi /201;
    Fxy = A * sin ( V * X ) + B * cos ( W * Y );
    Fx = A * V * cos(V * XX);
    Fy = -B * W * sin(W * YY);
    subplot(SPM,SPN,16)
    imshow(Fxy, [] , 'xData' , x , 'yData', y );
    hold on;
    quiver(xx,yy,Fx,Fy,'r');
    hold off;
    title('gradient vector plot')
    % 3.4
    % 3.5
    Gxy = rotateImage ( Fxy , degtorad(10) , 'linear' );
    Gx = rotateImage ( Fx , degtorad(10) , 'linear' );
    Gy = rotateImage ( Fy , degtorad(10) , 'linear' );
    subplot(SPM,SPN,17)
    imshow(Gxy, [] , 'xData' , x , 'yData', y );
    hold on;
    quiver(xx,yy,Gx,Gy,'r');
    hold off;
    title('rot. grad. vect. plot')
    
end

