k    = 3;
q    = 8;
a    = 10;
sd   = .5;
r    = 100;
data = zeros(k*r, 3);
clusters =rand(k,2) * 2*a;
for i = 1:k
    x  = rand(1,2) * 2*a;
    x1 = normrnd(x(1),sd,r,1);
    x2 = normrnd(x(2),sd,r,1);
    data((r*(i-1) + 1):(r*i),1) = x1;
    data((r*(i-1) + 1):(r*i),2) = x2;
end
X=data;
idx=zeros(200,1);
centroid=clusters;
figure(1);
plot(X(:,1),X(:,2),'g.','MarkerSize',12)
hold on
plot(centroid(:,1),centroid(:,2),'bx','MarkerSize',12)
ac=[0.5,0.5,0.5];
bc=[0,0,0];
cc=[0,0.5,0];
dc=[1,0,0];
ec=[0,0.75,0.75];
fc=[0,0,0.75];
gc=[0.75,0.75,0];
hc=[0.25,0.25,0.25];
ic=[0.2,0.3,0.4];
jc=[0,1,0];
color=[ac;bc;cc;dc;ec;fc;gc;hc;ic;jc];
distance=zeros(k,1);
for i = 1:10
    for n=1:size(X,1)
        cluster=-1;
        distValue=Inf;
        for clust=1:k
            currentDist=pdist([X(n,[1 2]);centroid(clust,[1 2])], 'euclidean')^2;
            if currentDist<distValue
                distValue=currentDist;
                cluster=clust;
            end
        end
        idx(n,1)=cluster;
    end
    for p=1:size(centroid,1)
        centroid(p,1)=mean(X(find(idx==p),1));
        centroid(p,2)=mean(X(find(idx==p),2));
    end
    figure(i+1);
    for j=1:k
        plot(X(find(idx==j),1),X(find(idx==j),2),'Marker','.','LineStyle','none','MarkerEdgeColor',color(j,:),'MarkerSize',12)
        hold on;
    end
    plot(centroid(:,1),centroid(:,2),'bx','MarkerSize',12)
end

figure(25); 

for i=1:k
    plot(X(find(idx==i),1),X(find(idx==i),2),'Marker','.','LineStyle','none','MarkerEdgeColor',color(i,:),'MarkerSize',12)
    hold on;
end
plot(centroid(:,1),centroid(:,2),'bx','MarkerSize',12)
counter=1;
sortedX=zeros(size(X));
for i=1:k
    index=find(idx==i);
    sortedX(counter:(counter+size(index,1)-1),:)=X(index,:);
    counter=counter+size(index,1);
end
simMat=zeros(size(X,1));
for i=1:size(X,1)   
    for j=1:size(X,1)
        simMat(i,j)=pdist([X(i,:);X(j,:)],'euclidean');
    end
end
figure(26);
imagesc(simMat);

