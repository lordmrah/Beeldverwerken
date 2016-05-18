function l = line_through_points(points)
% returns:
% l - homogeneous representation of the least -square -fit
% This function fits a line through all points found by points_of_line.

    points = points(:,1:2);
    
    centroid = mean(points);
    for i = 1:size(points,1)
       point_i = points(i,:);
       points_i_1(:,i) = point_i - centroid;
    end
    CovMatrix = (points_i_1*points_i_1')/size(points,1);
    [V, D] = eig(CovMatrix);

    U = V(:,1);
    Unormalized = U/sqrt(sum(U.^2));

    point_x_min = points(1,1:2);
    point_x_max = points(end,1:2);

    beginP = centroid' - Unormalized * sqrt(sum(point_x_min.^2));
    endP = centroid' - Unormalized * sqrt(sum(point_x_max.^2));

    X = [beginP(2,1),endP(2,1)];
    Y = [beginP(1,1),endP(1,1)];
    
    l = [X;Y];
end