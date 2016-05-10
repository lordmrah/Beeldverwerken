function [x1, y1, x2, y2] = thetarho2endpoints(theta, rho, rows, cols)
% For almost vertical lines we fix the y coordinates first. 
if theta >= 1.50 && theta <= 1.64
    y1 = 0;
    y2 = rows;
    % Solve for x
    x1 = rho/sin(theta);
    x2 = (rho+y2*cos(theta))/sin(theta);
% If not (almost) vertical, first divine x
else
    x1 = 0;
    x2 = cols;
    % And then solve for y
    y1 = -rho/cos(theta);
    y2 = (cols*sin(theta)-rho)/cos(theta);
end
end
