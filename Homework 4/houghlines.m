function lines = houghlines(im, h, thresh, method)
    % HOUGHLINES %
    % Function takes an image and its Hough transform, finds the
    % significant lines and draws them over the image
    %
    % Usage: houghlines(im, h, thresh)
    %
    %   arguments:
    %   im - The original image
    %   h - Its Hough Transform
    %   thresh - The threshold level to use in the Hough Transform
    %   to decide whether an edge is significant

    [rows, columns] = size(im);
    rhomax = sqrt ( rows ^2 + columns ^2);
    nrho = size(h,1);
    ntheta = size(h,2);
    drho = 2*rhomax/(nrho-1);
    dtheta = pi/ntheta;

    % To make a binary matrix and finding the isolated regions of an image
    % using the threshold (thresh)
    switch(method)
        case 'normal'
            g = im2bw(h,thresh);
            [bwl,nregions] = bwlabel(g);
            for n = 1:nregions
                 mask = bwl == n;
                 region = mask .* h;
                 [maxvalue1, rownr] = max(region);
                 [maxvalue2, theta_i] = max(maxvalue1);
                 rho_i = rownr(theta_i);
                 theta = (theta_i-1)*dtheta;
                 rho = (rho_i - nrho/2) * drho;
                 [x1, y1, x2, y2] = thetarho2endpoints(theta, rho, rows, columns);
                 line([x1 x2], [y1 y2])
                 lines(n,:) = cross([x1 ; y1 ; 1],[x2 ; y2 ; 1])';
             end
        case 'dilation'
            dilation = strel('disk', 8);
            hough_dilated = imdilate(h, dilation);
            
            localmaxima = hough_dilated == h & h > thresh;
            [rho_i, theta_i] = find(localmaxima);
            rho = (rho_i - nrho/2) .* drho;
            theta = (theta_i-1).*dtheta;
            for i = 1:length(theta)
                 [x1, y1, x2, y2] = thetarho2endpoints(theta(i), rho(i), rows, columns);
                 line([x1 x2], [y1 y2])
                 lines(i,:) = cross([x1 ; y1 ; 1],[x2 ; y2 ; 1])';
            end
    end

         
end    
