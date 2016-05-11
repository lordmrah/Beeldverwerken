function h = hough(im, Thresh, nRho, nTheta)
    BW = edge(im,'canny',Thresh);
    
%     [H,T,R] = hough(BW, 'RhoResolution', 0.5, 'ThetaResolution', 0.5);
   
    
    [N,M] = size(im);
    D = sqrt(M^2+N^2);
    dRho = (2*D)/(nRho-1);
    
    dTheta = pi/nTheta;
    thetas = [0:dTheta:(pi-dTheta)]
    
    h = zeros(nRho,nTheta);
    
    
% Find non-zero pixels in binary edge image
    [Y,X] = find(BW);
    for k = 1:length(X),
        x = X(k);
        y = Y(k);
        for i=1:length(thetas),
            theta = thetas(i);
            rho = x*sin(theta) - y*cos(theta);
            rhoIndex = round(rho/dRho + nRho/2);
            thetaIndex = round(theta/dTheta + 1);
%             val  = accumMatrix(rI,tI);
            h(rhoIndex,thetaIndex) = h(rhoIndex, thetaIndex) + 1;
        end
    end
end