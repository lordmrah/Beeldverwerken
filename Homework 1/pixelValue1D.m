function color = pixelValue1D( image , x, y, method )
    % pixel value at real coordinates
    if inImage ( size ( image ) ,x , y )
        % do the interpolation
        switch ( method )
            case 'nearest'
                % Do nearest neighbour
                color = image(floor(x+0.5),floor(y+0.5)); 
                return ;
            case 'linear'
                % Do bilinear interpolation
                k = floor(x);
                k1 = k+1;
                
                l = floor(y);
                l1 = l+1;
                
                a = x - k;
                b = y - l;
                
                color = (1-a)*(1-b)*image(k,l) + (1-a)*b*image(k,l1) + a*b*image(k1,l1) + a*(1-b)*image(k1,l);
         end %end switch
    else
        % return a constant
        color = 0;
        return ;
    end
end