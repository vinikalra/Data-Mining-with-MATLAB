% Outlier Detection

load('redwine.mat','X','Y'); % X, feature matrix; Y: ratings of wine samples;  
hist(Y, 0:10);
%% step 1: generating ground-truth for outliers; 

O=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
O(find(Y>=8 | Y<=3))=1; %labeled as outliers
adjMat=zeros(size(X,1));
total=size(X,1);
for i=1:total
    for j=(i+1):total
        dist=pdist([X(i,:);X(j,:)],'euclidean');
        adjMat(i,j)=dist;
        adjMat(j,i)=dist;
    end
end
%% step 2: Nearest Neighbor methods to determine outliners. 

%approach A: Data points for which there are fewer than p neighboring points within a distance D
 p=180;
 d=1.23;
 outliersApproachA=zeros(size(O,1),1);
 for i=1:size(adjMat,1)
     d=std(adjMat(i,:));
     tentativePoints=find(adjMat(i,:)<=d);
     if size(tentativePoints,2)<p
         outliersApproachA(i,1)=1;
     end
 end
%approach B: The top n data points whose distance to the k-th nearest neighbor is greatest
 k=2;
 [idx C]=kmeans(X,k);
 outliersApproachB=zeros(size(O,1),1);
 distMat=zeros(size(X,1),1);
 for i=1:size(X,1)
     distMat(i,1)=pdist([X(i,:);C(idx(i,1),:)],'euclidean');
 end
 [B,I]=sort(distMat,'descend');
 n=28;
for i=1:n
    outliersApproachB(I(i,1),1)=1;
end

%approach C: The top n data points whose average distance to the k nearest neighbors is greatest
k=2;
 [idxB CB]=kmeans(X,k);
 outliersApproachC=zeros(size(O,1),1);
 distMatB=zeros(size(X,1),1);
 for i=1:size(X,1)
     distanceWithNearestNeignbours=zeros(k,1);
     for j=1:k
         distanceWithNearestNeignbours(j,1)=pdist([X(i,:);CB(idxB(j,1),:)],'euclidean');
     end
     distMatB(i,1)=mean(distanceWithNearestNeignbours);
 end
 [BB,IB]=sort(distMatB,'descend');
 n=28;
for i=1:n
    outliersApproachC(IB(i,1),1)=1;
end


%% step 3: Evaluate and compare the detection results of the above three methods usng confusion matrix and analyze which method works the best on this particular dataset. 
fprintf('Approach A');
[cA,oA]=confusionmat(O,outliersApproachA);
display(cA);
fprintf('/n')
fprintf('Approach B');
[cB,oB]=confusionmat(O,outliersApproachB);
display(cB);
fprintf('Approach C');
[cC,oC]=confusionmat(O,outliersApproachC);
display(cC);
