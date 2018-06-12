load('iris.mat');

pWidth = {'VarName4'};
petalW = iris(:,pWidth);
pWidthArray =  table2array(petalW);


pLength = {'VarName3'};
petalL = iris(:,pLength);
pLArray =  table2array(petalL);


sLength = {'VarName1'};
sepalL = iris(:,sLength);
sLArray =  table2array(sepalL);


sWidth = {'VarName2'};
sepalW = iris(:,sWidth);
sWArray =  table2array(sepalW);


flowerCategory = {'Irissetosa'};
fCategory = iris(:,flowerCategory);
fCArray =  table2array(fCategory);

setosa = strmatch('Iris-setosa',fCArray);
versicolor = strmatch('Iris-versicolor',fCArray);
virginica = strmatch('Iris-virginica',fCArray);

min_pw_setosa = min(pWidthArray(setosa));
min_pw_versicolor = min(pWidthArray(versicolor));
min_pw_virginica = min(pWidthArray(virginica));
max_pw_setosa = max(pWidthArray(setosa));
max_pw_versicolor = max(pWidthArray(versicolor));
max_pw_virginica = max(pWidthArray(virginica));

setosa_bin_size = (max_pw_setosa - min_pw_setosa + .1)/10;
setosa_array = 1:1:10;
setosa_array = min_pw_setosa + setosa_array .* setosa_bin_size;
setosa_freq = zeros(1,10);

for i = pWidthArray(setosa)'
    setosa_freq(floor((i-min_pw_setosa)/setosa_bin_size)+1) = setosa_freq(floor((i-min_pw_setosa)/setosa_bin_size)+1)+1;
end


binsH= 10;
figure(1);
title('1D Histogram of Petal Width')


%1.1 = histogram(Array_PW(setosa),binsH);
bar(setosa_array,setosa_freq);%Manually created histogram.
hold on;
h2 = histogram(pWidthArray(versicolor),binsH);
hold on;
h3 = histogram(pWidthArray(virginica),binsH);
legend('Setosa','Versicolor','Virginica');
xlabel('Petal Width')
ylabel('Count')
hold off;

%1.2
figure(2);
title('2D Histogram')
ylabel('Petal Width')
xlabel('Petal Length')
zlabel('Count')
x = histogram2(pLArray(setosa),pWidthArray(setosa),binsH);
hold on;
y = histogram2(pLArray(versicolor),pWidthArray(versicolor),binsH);
hold on;
z = histogram2(pLArray(virginica),pWidthArray(virginica),binsH);

%1.3
figure(3);
subplot(1,3,1);
b1 = boxplot([sLArray(setosa),sWArray(setosa),pLArray(setosa), pWidthArray(setosa)],'Labels' ,{'Sepal length','Sepal Width','Petal length','Petal Width'});
ylabel('Value (Cm)');
subplot(1,3,2);
b2 = boxplot([sLArray(versicolor),sWArray(versicolor),pLArray(versicolor),pWidthArray(versicolor) ],'Labels' ,{'Sepal length','Sepal Width','Petal length','Petal Width'});
ylabel('Value(Cm)');
subplot(1,3,3);
ylabel('Value(Cm)');
b3 = boxplot([sLArray(virginica),sWArray(virginica),pLArray(virginica),pWidthArray(virginica) ],'Labels' ,{'Sepal length','Sepal Width','Petal length','Petal Width'});
ylabel('Value(Cm)');

%1.4
x = [sLArray,sWArray, pLArray, pWidthArray];
figure(4);
scatter_plot = gplotmatrix(x,[],fCArray,'bgr','x+o',[],'on','none',{'Sepal Length', 'Sepal Width', 'Petal Length', 'Petal Width'},{'Sepal Length', 'Sepal Width', 'Petal Length', 'Petal Width'});

%1.5

%Euclidean distance 

setosa_sl = sLArray(setosa);
setosa_sw = sWArray(setosa);
setosa_pl = pLArray(setosa);
setosa_pw = pWidthArray(setosa);

versicolor_sl = sLArray(versicolor);
versicolor_sw = sWArray(versicolor);
versicolor_pl = pLArray(versicolor);
versicolor_pw = pWidthArray(versicolor);

virginica_sl = sLArray(virginica);
virginica_sw = sWArray(virginica);
virginica_pl = pLArray(virginica);
virginica_pw = pWidthArray(virginica);


setosa_sl_array = [setosa_sl(2:end);setosa_sl(1)];
setosa_sw_array = [setosa_sw(2:end);setosa_sw(1)];
setosa_pl_array = [setosa_pl(2:end);setosa_pl(1)];
setosa_pw_array = [setosa_pw(2:end);setosa_pw(1)];

versicolor_sl_array = [versicolor_sl(2:end);versicolor_sl(1)];
versicolor_sw_array = [versicolor_sw(2:end);versicolor_sw(1)];
versicolor_pl_array = [versicolor_pl(2:end);versicolor_pl(1)];
versicolor_pw_array = [versicolor_pw(2:end);versicolor_pw(1)];

virginica_sl_array = [virginica_sl(2:end);virginica_sl(1)];
virginica_sw_array = [virginica_sw(2:end);virginica_sw(1)];
virginica_pl_array = [virginica_pl(2:end);virginica_pl(1)];
virginica_pw_array = [virginica_pw(2:end);virginica_pw(1)];

EuclideanDistance_setosa_sl = sqrt((setosa_sl - setosa_sl_array).*(setosa_sl - setosa_sl_array));
EuclideanDistance_setosa_sw = sqrt((setosa_sw - setosa_sw_array).*(setosa_sw - setosa_sw_array));
EuclideanDistance_setosa_pl = sqrt((setosa_pl - setosa_pl_array).*(setosa_pl - setosa_pl_array));
EuclideanDistance_setosa_pw = sqrt((setosa_pw - setosa_pw_array).*(setosa_pw - setosa_pw_array));

EuclideanDistance_versicolor_sl = sqrt((versicolor_sl - versicolor_sl_array).*(versicolor_sl - versicolor_sl_array));
EuclideanDistance_versicolor_sw = sqrt((versicolor_sw - versicolor_sw_array).*(versicolor_sw - versicolor_sw_array));
EuclideanDistance_versicolor_pl = sqrt((versicolor_pl - versicolor_pl_array).*(versicolor_pl - versicolor_pl_array));
EuclideanDistance_versicolor_pw = sqrt((versicolor_pw - versicolor_pw_array).*(versicolor_pw - versicolor_pw_array));

EuclideanDistance_virginica_sl = sqrt((virginica_sl - virginica_sl_array).*(virginica_sl - virginica_sl_array));
EuclideanDistance_virginica_sw = sqrt((virginica_sw - virginica_sw_array).*(virginica_sw - virginica_sw_array));
EuclideanDistance_virginica_pl = sqrt((virginica_pl - virginica_pl_array).*(virginica_pl - virginica_pl_array));
EuclideanDistance_virginica_pw = sqrt((virginica_pw - virginica_pw_array).*(virginica_pw - virginica_pw_array));

figure(5);
xlabel(' Sepal Length         Sepal Width         Petal Length         Petal Width');
ylabel('     Virginica          Versicolor           Setosa      ');
title('Visualization of similarity matrix');
SM = [EuclideanDistance_setosa_sl, EuclideanDistance_setosa_sw, EuclideanDistance_setosa_pl, EuclideanDistance_setosa_pw; EuclideanDistance_versicolor_sl, EuclideanDistance_versicolor_sw, EuclideanDistance_versicolor_pl, EuclideanDistance_versicolor_pw; EuclideanDistance_virginica_sl, EuclideanDistance_virginica_sw, EuclideanDistance_virginica_pl, EuclideanDistance_virginica_pw];
imagesc(SM);
colorbar;
