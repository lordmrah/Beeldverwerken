function color = pixelValue( image , y, x, method )
    % pixel value at real coordinates
    
    [maxX,maxY] = size(image);
    inBoundX = not(abs(sign(sign(1 - x) + sign(maxX - x))));
    inBoundY = not(abs(sign(sign(1 - y) + sign(maxY - y))));
    x = ((x-1) .* inBoundX) + 1;
    y = ((y-1) .* inBoundY) + 1;
    

    % do the interpolation
    switch ( method )
        case 'nearest'
            % Do nearest neighbour
            colorVector = impixel(image, floor(x+0.5),floor(y+0.5));
            grayVector = colorVector(:,1);
            color = reshape(grayVector, maxX, maxY);
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
            kl = reshape(temp(:,1),1, maxX*maxY);
            temp = impixel(image,k,l1);
            kl1 = reshape(temp(:,1),1, maxX*maxY);
            temp = impixel(image,k1,l1);
            k1l1 = reshape(temp(:,1),1, maxX*maxY);
            temp = impixel(image,k1,l);
            k1l = reshape(temp(:,1),1, maxX*maxY);
            colorVector = (1-a).*(1-b).*kl + (1-a).*b.*kl1 + a.*b.*k1l1 + a.*(1-b).*k1l;
            color = reshape(colorVector, maxX, maxY);
     end %end switch

end