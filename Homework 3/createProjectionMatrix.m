function projMatrix = createProjectionMatrix(xy, uv)
% code from excercise
x = xy(:,1);
y = xy(:,2);
u = uv(:,1);
v = uv(:,2);
o = ones(size(x));
z = zeros(size(x));
Aoddrows = [x, y, o , z, z, z, -u.*x, -u.*y, -u];
Aevenrows = [z, z, z, x, y, o, -v.*x, -v.*y, -v];
A = [Aoddrows; Aevenrows];
% svd returns the singulair values of a matrix in descending order,
% and we just want the smallest one to be m. 
[U, D, V] = svd(A)
m = V(:,end)
% We want the projmatrix to be 3x3, reshape:
projMatrix = reshape(m, 3, 3);
end