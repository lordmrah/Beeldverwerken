function color = pixelValue( image , x, y, method )
    % pixel value at real coordinates
    if inImage ( size ( image ) ,x , y )
        % do the interpolation
        switch ( method )
            case 'nearest'
                % Do nearest neighbour
                color = image(floor(x)+0.5,floor(y)+0.5);               
                return ;
            case 'linear'
                % Do bilinear interpolation
         end %end switch
    else
        % return a constant
        return ;
    end
end