function projMatrix = createProjectionmatrix(xy , uv)
    x = xy(:,1);
    y = xy(:,2);
    u = uv(:,1);
    v = uv(:,2);
    o = ones(size(x));
    z = zeros(size(x));
    
    AoddRows = [u,v,o,z,z,z,-x.*u,-x.*v,-x];
    AevenRows = [z,z,z,u,v,o,-y.*u,-y.*v,-y];
    
    A = [AoddRows; AevenRows];
    %M = [m1;m2;m3;m4;m5;m6;m7;m8;m9];
    projMatrix = null(A);
    projMatrix = reshape(projMatrix, 3,3)';
end