function M = estimateProjectionmatrix(xy , uvw)
    x = xy(:,1);
    y = xy(:,2);
    u = uvw(:,1);
    v = uvw(:,2);
    w = uvw(:,3);
    o = ones(size(x));
    z = zeros(size(x));
    
    AoddRows = [u,v,w,o,z,z,z,z,-x.*u,-x.*v,-x.*w,-x];
    AevenRows = [z,z,z,z,u,v,w,o,-y.*u,-y.*v,-y.*w,-y];
    
    A = [AevenRows;AoddRows];
    [U,D,V] = svd(A);
    m = V(:,end);
    m = m./m(end);
    M = reshape(m,3,4);
end