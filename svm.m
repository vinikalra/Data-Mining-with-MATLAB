% This example is used to apply the Support Vector machine (SVM)
% method to predict if a flower is 'setosa', i.e. label 1 in the matrix X(:,5). 

% 
CM=zeros(3,3); %confusion matrix; 
acc=0; % accuracy
arrR=zeros(1,3); % per-class recall rate; 
arrP=zeros(1,3); % per-class precision rate; 

%% Load data and split the samples into two subsets
%one for training, the other for testing. 
load('iris_matrix.mat','X');

D=randperm(150);
%training
trX=X(D(1:100), 1:4); %training samples
trY=X(D(1:100), 5); % training labels;
trY(find(trY~=1))=-1; % change any other class to be -1;    

teX=X(D(101:end), 1:4); %teting samples; 
teY=X(D(101:end),5); %testing labels;
teY(find(teY~=1))=-1;% change any other class to be -1;    

%% Training & Testing	

hatY=zeros(50,1); % predicted classes

%Call fitcsvm() to train a linear SVM  or kernel SVM
%linear
Mdl = fitclinear(trX,trY);

%non-linear
SVMModel = fitcsvm(trX,trY,'Standardize',true,'KernelFunction','RBF','KernelScale','auto');

%Call predict() to test every test sample

linear_predict=predict(Mdl,teX);
non_linear_predict=predict(SVMModel,teX);

linear_predict(find(linear_predict==-1))=0; 
non_linear_predict(find(non_linear_predict==-1))=0; 
teY(find(teY==-1))=0; 
hatYLinear=num2cell(num2str(linear_predict)); 
hatYLinear=hatYLinear(find(~strcmp(hatYLinear,' '))); 
teY=num2cell(num2str(teY)); 
teY=teY(find(~strcmp(teY,' '))); 
hatYNonLinear=num2cell(num2str(non_linear_predict)); 
hatYNonLinear=hatYNonLinear(find(~strcmp(hatYNonLinear,' '))); 
%% 3.	Compute confusion matrix and various metrics
% including accuracy, and per-class recall/precision rates. 

fprintf('For Linear model \n') 
[confmat accuracy precision recall order]=func_confusion_matrix(teY,hatYLinear); 
display(order); 
display(confmat); 
display(accuracy); 
display(precision); 
display(recall); 
fprintf('For Non Linear model \n') 
[confmat accuracy precision recall order]=func_confusion_matrix(teY,hatYNonLinear); 
display(order); 
display(confmat); 
display(accuracy); 
display(precision); 
display(recall);

