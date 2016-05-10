function l = line_through_points(points)
% returns:
% l - homogeneous representation of the least -square -fit
% This function fits a line through all points found by points_of_line.

% We want to get the non-homogeneous coordinates
points = points(:,1:2);
% We want to calculate point_i_1 = point_i - centroid, with centroid
% the average of all datapoints.
centroid = mean(points);
% Create new points
for i = 1:size(points,1)
   point_i = points(i,:);
   points_i_1(:,i) = point_i - centroid;
end
% The covariance matrix is made by taking the matrix multiplication of
% points_i_1 with its own transpose, divided by nr of rows of points

CovMatrix = (points_i_1*points_i_1')/size(points,1);
% Calculate eigenvalues and eigenvectors
[V, D] = eig(CovMatrix);
% The eigenvector corresponding to the largest eigenvalue is the first
% column of V.
U = V(:,1);
% The optimal line passes through the centroid and has direction U. 

% We would like homogeneous coordinates, so we have to normalize U.
Unormalization = sqrt(sum(U.^2));

Unormalized = U/Unormalization;

% We need the coordinate pairs with the largest and smallest x coordinates

point_x_min = points(1,1:2);
point_x_max = points(end,1:2);

% To find the begin and endpoints of the line:

beginP = centroid' - Unormalized * sqrt(sum(point_x_min.^2));
endP = centroid' - Unormalized * sqrt(sum(point_x_max.^2));
% collect x and y's
X = [beginP(2,1);endP(2,1)]
Y = [beginP(1,1);endP(1,1)]

% Homogeneous:
for i = 1:size(X)
    X(i, 3) = 1;
    Y(i, 3) = 1;
end
% Now the line is defined by the cross product of X x Y

l = cross(X,Y);