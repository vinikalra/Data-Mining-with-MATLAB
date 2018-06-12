% This example is used to implement the K Nearest Neighbor (KNN) method and
% use it to classify flower samples in the Iris dataset. 

%There are 3 major steps. 

% 
K= 22;  %number of nearest neighbors used for voting. 
CM=zeros(3,3); %confusion matrix; 
acc=0; % accuracy
arrR=zeros(1,3); % per-class recall rate; 
arrP=zeros(1,3); % per-class precision rate; 

%% Step 1.	Load data and split the samples into two subsets
%one for training, the other for testing. 
load('iris_matrix.mat','X');

D=randperm(150);
%training
trX=X(D(1:100), 1:4); %training samples
trY=X(D(1:100), 5); % training labels;
teX=X(D(101:end), 1:4); %teting samples; 
teY=X(D(101:end),5); %testing labels;

%% 2.	for each testing sample, calculate its distances to every training sample; 
hatY=zeros(50,1); % predicted classes

% a.	find the top K nearest samples; 
for i=1:size(teX,1)
    X=teX(i,:);
    Y=teY(i);
    dist=zeros(1,size(trX,1));
    for j=1:size(trX,1)
        dist(j)=cal_euclidean(X,trX(j,:));
    end
    [sortedDist,sortedIndex]=sort(dist);
    count=zeros(3,1);
    for index=1:K
        if trY(sortedIndex(index))==1
            count(1)=count(1)+1;
        elseif trY(sortedIndex(index))==2
            count(2)=count(2)+1;
        else
            count(3)=count(3)+1;
        end
    end
    if count(1)>=count(2)
        if count(1)>=count(3)
            hatY(i)=1;
        else
            hatY(i)=3;
        end
    else
        if count(2)>=count(3)
            hatY(i)=2;
        else
            hatY(i)=3;
        end
    end
end
% b.	vote to predict the class of the testing sample
hatY=num2cell(num2str(hatY));
hatY=hatY(find(~strcmp(hatY,' ')));
teY=num2cell(num2str(teY));
teY=teY(find(~strcmp(teY,' ')));

%% 3.	Compute confusion matrix and various metrics
% including accuracy, and per-class recall/precision rates. 
% please implement the following functions
%testY, ground-truth lables;
%hatY, predicted labels; 
%output arguments: confuction matrix, accuracy, per-class recall rate,
%per-class prediction rate. 
[CM, acc, arrR, arrP]=func_confusion_matrix(teY, hatY);
%display(order);
display(CM);
display(acc);
display(arrR);
display(arrP);

