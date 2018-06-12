%Training
train = 25;
random_val = randperm(50);
trainingSetosa = iris(random_val(1:train),:);
trainingVersicolor = iris((random_val(1:train))+50,:);
trainingVirginica = iris((random_val(1:train))+100,:);
training = vertcat(trainingSetosa,trainingVersicolor,trainingVirginica);

%Testing
testingSetosa = iris(random_val(1:train),:);
testingVersicolor = iris((random_val(1:train))+50,:);
testingVirginica = iris((random_val(1:train))+100,:);
testing = vertcat(testingSetosa,testingVersicolor,testingVirginica);

petalWidth = {'VarName4'};
trainPW = training(:,petalWidth);
pWTrain =  table2array(trainPW);

petalLength = {'VarName3'};
trainPL = training(:,petalLength);
pLTrain =  table2array(trainPL);

sepalLength = {'VarName1'};
trainSL = training(:,sepalLength);
sLTrain =  table2array(trainSL);


sepalWidth = {'VarName2'};
trainSW = training(:,sepalWidth);
SWTrain =  table2array(trainSW);

flowerCategory = {'Irissetosa'};
trainFC = training(:,flowerCategory);
fCTrain =  table2array(trainFC);

%MaxNumSplits
f1 = fitctree([pWTrain,pLTrain,sLTrain,SWTrain],fCTrain,'MaxNumSplits',4);
view(f1,'Mode','graph');

%MaxNumCategories
f2 = fitctree([pWTrain,pLTrain,sLTrain,SWTrain],fCTrain,'MaxNumCategories',4);
view(f2,'Mode','graph');

%CrossVal On
f3 = fitctree([pWTrain,pLTrain,sLTrain,SWTrain],fCTrain,'CrossVal','on');
%view(f3,'Mode','graph');

%MergeLeaves
f4 = fitctree([pWTrain,pLTrain,sLTrain,SWTrain],fCTrain,'MergeLeaves','on');
view(f4,'Mode','graph');

%MinParentSize
f5 = fitctree([pWTrain,pLTrain,sLTrain,SWTrain],fCTrain,'MinParentSize',6);
view(f5,'Mode','graph');

%MinLeafSize
f6 = fitctree([pWTrain,pLTrain,sLTrain,SWTrain],fCTrain,'MinLeafSize',5);
view(f6,'Mode','graph');

%NumVariablesToSample
f7 = fitctree([pWTrain,pLTrain,sLTrain,SWTrain],fCTrain,'NumVariablesToSample',3);
view(f7,'Mode','graph');


%2.3
petalWidthTest = {'VarName4'};
testPW = testing(:,petalWidthTest);
PWTest =  table2array(testPW);

petalLengthTest = {'VarName3'};
testPL = testing(:,petalLengthTest);
PLTest =  table2array(testPL);

sepalLengthTest = {'VarName1'};
testSL = testing(:,sepalLengthTest);
SLTest =  table2array(testSL);


sepalWidthTest = {'VarName2'};
testSW = testing(:,sepalWidthTest);
SWTest =  table2array(testSW);

flowerCategoryTest = {'Irissetosa'};
testFC = testing(:,flowerCategoryTest);
FCTest =  table2array(testFC);

predict_labels = predict(f1, [PWTest,PLTest,SLTest,SWTest]);

C = confusionmat(FCTest,predict_labels);

%Precision Rate
disp('Precision Rate');
 PR_setosa = C(1,1)./sum(C(:,1));
 disp(PR_setosa);
 PR_versicolor = C(2,2)./sum(C(:,2));
 disp(PR_versicolor);
 PR_virginica = C(3,3)./sum(C(:,3));
 disp(PR_virginica);
 
 %Recall Rate
 disp('Recall Rate');
 RT_setosa = C(1,1)./sum(C(1,:));
 disp(RT_setosa);
 RT_versicolor = C(2,2)./sum(C(2,:));
 disp(RT_versicolor);
 RT_virginica = C(3,3)./sum(C(3,:));
 disp(RT_virginica);
 
 %F-Mesure
 disp('F-Mesure');
 F_Mesure_setosa = (PR_setosa + RT_setosa) / (PR_setosa * RT_setosa);
 disp(F_Mesure_setosa);
 F_Mesure_versicolor = (PR_versicolor + RT_versicolor) / (PR_versicolor * RT_versicolor);
 disp(F_Mesure_versicolor);
 F_Mesure_virginica = (PR_virginica + RT_virginica) / (PR_virginica * RT_virginica);
  disp(F_Mesure_virginica);
 
 final_Table = [PR_setosa,PR_versicolor,PR_virginica;RT_setosa,RT_versicolor,RT_virginica;F_Mesure_setosa,F_Mesure_versicolor,F_Mesure_virginica]
 disp(final_Table)
% disptable(final_Table,'Setosa|Versicolor|Virginica','Precision Rate|Recall Rate|F-Mesure')