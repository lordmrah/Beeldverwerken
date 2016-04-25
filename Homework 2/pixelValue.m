function color = pixelValue( image , y, x, m, n, method )
    % pixel value at real coordinates
    
    [maxY,maxX] = size(image);
    inBoundX = not(abs(sign(sign(1 - x) + sign(maxX - x))));
    inBoundY = not(abs(sign(sign(1 - y) + sign(maxY - y))));
    x = ((x-1) .* inBoundX) + 1;
    y = ((y-1) .* inBoundY) + 1;
    
    pixelMask = inBoundX & inBoundY;
    

    % do the interpolation
    switch ( method )
        case 'nearest'
            % Do nearest neighbour
            colorVector = impixel(image, floor(x+0.5),floor(y+0.5));
            grayVector = colorVector(:,1);
            color = reshape(grayVector, m, n);
            return ;
        case 'linear'
            % Do bilinear interpolation
            k = floor(x);
            k1 = k+1;

            l = floor(y);
            l1 = l+1;

            a = x - k;
            b = y - l;
            
            
            temp = impixel(image,k,l);
            kl = reshape(temp(:,1),1, m*n);
            temp = impixel(image,k,l1);
            kl1 = reshape(temp(:,1),1, m*n);
            temp = impixel(image,k1,l1);
            k1l1 = reshape(temp(:,1),1, m*n);
            temp = impixel(image,k1,l);
            k1l = reshape(temp(:,1),1, m*n);
            colorVector = (1-a).*(1-b).*kl + (1-a).*b.*kl1 + a.*b.*k1l1 + a.*(1-b).*k1l;
            colorVector = colorVector .* pixelMask;
            color = reshape(colorVector, m, n);
            
            
     end %end switch

end