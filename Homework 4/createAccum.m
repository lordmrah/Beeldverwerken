function accumMatrix = createAccum(RhoRes, ThetaRes, I)
    RhoRange = [0,pi];
    [N,M] = size(I);
    D = sqrt(M^2+N^2);
    ThetaRange = [-D,D];
    RhoVal = RhoRange / RhoRes;
    ThetaVal = ThetaRange / ThetaRes;
    accumMatrix = zeros(round(diff(RhoVal)),round(diff(ThetaVal)));