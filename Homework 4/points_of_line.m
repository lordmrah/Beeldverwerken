% This function finds all points that lie within the distance (epsilon)
% from a certain line, and returns an array of those points. 

function pts = points_of_line(points, line, epsilon)
% points - an array containing all points
% line - the homogeneous representation of the line
% epsilon - the maximum distance
% returns:
% pts - an array of all points within epsilon of the line


% We want to make all point in homogeneous coordinates. Because we just add
% one, these points are allready normalized. 
    points(:,3) = 1;
    

    line = line/line(3);
    
% To create an array we need a counter to eventually add the points that
% lie within the distance epsilon to an array. 
    counter = 0;
% WHen using normalized homogeneous coordinates, the perpendicular distance
% from a point to a line is the same as taking the dot product. 
% So we check is the dot product between the (normalized)point and
% (normalized) line is smalle than epsilon. If this is the case, we add the
% point to the array pts. 
    pts = [];
    for i = 1:size(points,1)
        if abs(dot(points(i,:),line)) <= epsilon
            counter = counter + 1;
            pts(counter,:) = points(i,:);
        end

    end

end
