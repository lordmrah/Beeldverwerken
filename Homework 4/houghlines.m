function houghlines(im, h, thresh)
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
%
%
rows = size( im, 1 );
columns = size( im, 2 );
rhomax = sqrt ( rows ^2 + columns ^2);
drho = size(h,1);
dtheta = size(h,2);

% To make a binary matrix and finding the isolated regions of an image
% using the threshold (thresh)

g = zeros(drho,dtheta);
g(h>=thresh) = 1;
[bwl,nregions] = bwlabel(g);

for n = 1:nregions
    mask = bwl == n;
    region = mask .* h;
    [maxvalue1, Y] = max(region);
    [maxvalue2, X] = max(maxvalue1);
    
