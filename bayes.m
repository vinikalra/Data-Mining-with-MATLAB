% This example is used to implement the naive bayes method and
% use it to classify flower samples in the Iris dataset. 

%There are 4 major steps. 

% 
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

%% 2. Training and Predicting

% Each flower sample is described with four continuous variables: X=(x1, x2,
% x3, x4). There are three possible classes: 1, 2,3, representing 'Iris-setosa',     'Iris-versicolor' and    'Iris-virginica', respectively. 
%  
% Given a test sample, X, we will need to calculate the posterior probability P(class=1|X),P(class=2|X), and P(class=3|X), and find the class tht maximizes a probability. This method is also called MAP method. 
%  
% While it is intractable to get P(class=k|X), according to Bayes we can 
% find a class that maximizes P(X|class=k)p(class=k), instead; we further assume independences among the variables x1, x2, x3, and x4, then, P(X|class=k)=P(x1|class=k)P(x2|class=k)P(x3|class=k)P(x4|class=k). k=1,2,3. 
%  
%  
% Note that x1, x2, x3, and x4 are all continuous values, we introduce a Gaussian distribution to model each variable. 
%  
% In the following,  we will calculate the Gaussian distribution for each variable. 

%a. computes the mean&variance of each variable per class (3)
arrM=zeros(3,4); % 
arrV=zeros(3,4); % variance; 
indexOfClassOne=find(trY==1);
indexOfClassTwo=find(trY==2);
indexOfClassThree=find(trY==3);
for i=1:4
   arrM(1,i)=mean(trX(indexOfClassOne,i));
   arrV(1,i)=var(trX(indexOfClassOne,i));
   arrM(2,i)=mean(trX(indexOfClassTwo,i));
   arrV(2,i)=var(trX(indexOfClassTwo,i));
   arrM(3,i)=mean(trX(indexOfClassThree,i));
   arrV(3,i)=var(trX(indexOfClassThree,i));
end
display(arrM);
display(arrV);
%b. calculate the prior distributions P(class=k), k=1,2,3
 priorProb=zeros(1,3);
 total=size(indexOfClassOne,1)+size(indexOfClassTwo,1)+size(indexOfClassThree,1);
 priorProb(1)=size(indexOfClassOne,1)/total;
 priorProb(2)=size(indexOfClassTwo,1)/total;
priorProb(3)=size(indexOfClassThree,1)/total;
%c. with Mean& variance, calculate the product of P(x1|class=k), k=1,2,3

% Taking x1 for instance, we have P(x1|class=1)=1/(sqrt(2*pi)*sqrt(Sigma))*exp(-(x1-mu)/(2*Sigma)),
%where mu and Sigma are mean and variables, respectively. 
prediction=zeros(50,1);
for i=1:size(teX,1)
    x=teX(i,:);
    ProbX1C1=1/sqrt(2*pi*arrV(1,1))*exp(-((x(1)-arrM(1,1))^2)/(2*arrV(1,1)));
    ProbX1C2=1/sqrt(2*pi*arrV(2,1))*exp(-((x(1)-arrM(2,1))^2)/(2*arrV(2,1)));
    ProbX1C3=1/sqrt(2*pi*arrV(3,1))*exp(-((x(1)-arrM(3,1))^2)/(2*arrV(3,1)));
    
    ProbX2C1=1/sqrt(2*pi*arrV(1,2))*exp(-((x(2)-arrM(1,2))^2)/(2*arrV(1,2)));
    ProbX2C2=1/sqrt(2*pi*arrV(2,2))*exp(-((x(2)-arrM(2,2))^2)/(2*arrV(2,2)));
    ProbX2C3=1/sqrt(2*pi*arrV(3,2))*exp(-((x(2)-arrM(3,2))^2)/(2*arrV(3,2)));
    
    ProbX3C1=1/sqrt(2*pi*arrV(1,3))*exp(-((x(3)-arrM(1,3))^2)/(2*arrV(1,3)));
    ProbX3C2=1/sqrt(2*pi*arrV(2,3))*exp(-((x(3)-arrM(2,3))^2)/(2*arrV(2,3)));
    ProbX3C3=1/sqrt(2*pi*arrV(3,3))*exp(-((x(3)-arrM(3,3))^2)/(2*arrV(3,3)));
    
    ProbX4C1=1/sqrt(2*pi*arrV(1,4))*exp(-((x(4)-arrM(1,4))^2)/(2*arrV(1,4)));
    ProbX4C2=1/sqrt(2*pi*arrV(2,4))*exp(-((x(4)-arrM(2,4))^2)/(2*arrV(2,4)));
    ProbX4C3=1/sqrt(2*pi*arrV(3,4))*exp(-((x(4)-arrM(3,4))^2)/(2*arrV(3,4)));
    
    ProbXC1=ProbX1C1*ProbX2C1*ProbX3C1*ProbX4C1;
    ProbXC2=ProbX1C2*ProbX2C2*ProbX3C2*ProbX4C2;
    ProbXC3=ProbX1C3*ProbX2C3*ProbX3C3*ProbX4C3;
    
    ProbC1X=ProbXC1*priorProb(1);
    ProbC2X=ProbXC2*priorProb(2);
    ProbC3X=ProbXC3*priorProb(3);
    pred=0;
    if ProbC1X > ProbC2X
        if ProbC1X > ProbC3X
            pred=1;
        else
            pred=3;
        end
    elseif ProbC2X > ProbC3X
        pred=2;
    else
        pred=3;
    end
    prediction(i)=pred;
end
display(priorProb);
%d. Apply the MAP method to select the class that achieves the maximal
%posterior probability, e.g., \arg \max_i, P(X|class=k)P(class=k)

hatY=zeros(50,1); % predicted classes



%% 3.	Compute confusion matrix and various metrics
% including accuracy, and per-class recall/precision rates. 
% Implement the following functions
%testY, ground-truth lables;
%hatY, predicted labels; 
%output arguments: confuction matrix, accuracy, per-class recall rate,
%per-class prediction rate. 

display(confusionmat(prediction,teY));
prediction=num2cell(num2str(prediction));
prediction=prediction(find(~strcmp(prediction,' ')));
teY=num2cell(num2str(teY));
teY=teY(find(~strcmp(teY,' ')));

[CM, acc, arrR, arrP]=func_confusion_matrix(teY,prediction);
disp(CM);
disp(acc);
disp(arrP);
disp(arrR);



