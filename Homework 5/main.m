function  main()

[trainset, testset] = splitdata('omni');

[mean_over_data, X, X_test] = PCAproof ( trainset, testset);
[V, D, E] = pca(X,trainset, 9, mean_over_data);

[V, D, E] = pca(X,trainset, 20, mean_over_data);
[V_test, D_test, E_test] = pca(X_test,testset, 20, mean_over_data);


correct = 0;
disp('Comressed data')
tic
for i=1:size(V,1)
    leastDiff = intmax;
    bestMatch = 0;
    for j=1:size(V,1)
        diff = sum((V(i,:)-V(j,:)).^2);
        if diff < leastDiff
            leastDiff = diff;
            bestMatch = j;
        end
    end
    if bestMatch == i
        correct = correct + 1;
    end
end 
toc
accuracy = correct/size(V,1)
disp('Raw data')
tic
% for i=1:size(V,1)
%     leastDiff = intmax;
%     bestMatch = 0;
%     for j=1:size(trainset,2)
%         diff = sum((trainset{i}.img-trainset{j}.img).^2);
%         if diff < leastDiff
%             leastDiff = diff;
%             bestMatch = j;
%         end
%     end
%     if bestMatch == i
%         correct = correct + 1;
%     end
% end
toc

teststructs = [testset{:}];
trainstructs = [trainset{:}];
testpositions =  vertcat ( teststructs.position );
trainpositions =  vertcat ( trainstructs.position );

disp('Test data')
tic
posEst = zeros(size(V_test,1),2);
for i=1:size(V_test,1)
    leastDiff = intmax;
    bestMatch = 0;
    for j=1:size(V,1)
        diff = sum((V_test(i,:)-V(j,:)).^2);
        if diff < leastDiff
            leastDiff = diff;
            bestMatch = j;
        end
    end
    posEst(i,:) = trainpositions(bestMatch,:);
    xDiff = (trainpositions(bestMatch,1)-testpositions(i,1));
    yDiff = (trainpositions(bestMatch,2)-testpositions(i,2));
    dist = sqrt(xDiff^2 + yDiff^2);
    if dist <= 150
        correct = correct + 1;
    end
        
end 
toc
size(posEst)
accuracy = correct / size(V_test,1)

subplot(1,2,1)
scatter(testpositions(:,1),testpositions(:,2))
title('realpos')
subplot(1,2,2)
scatter(posEst(:,1),posEst(:,2))
title('estpos')
   



end

