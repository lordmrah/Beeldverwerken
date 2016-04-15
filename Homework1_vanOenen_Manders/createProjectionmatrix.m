function projMatrix = createProjectionmatrix(xy , uv)
    x = xy(:,1);
    y = xy(:,2);
    u = uv(:,1);
    v = uv(:,2);
    o = ones(size(x));
    z = zeros(size(x));
    
    AoddRows = [u,v,o,z,z,z,-x.*u,-x.*v,-x];
    AevenRows = [z,z,z,u,v,o,-y.*u,-y.*v,-y];
    
    A = [AevenRows;AoddRows];
    
    projMatrix = null(A);
    projMatrix = projMatrix*1/projMatrix(9);
    projMatrix = reshape(projMatrix, 3,3)';
end