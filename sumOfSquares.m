function total= sumOfSquares(id,centroid,param)
    total=0;
    for i=1:size(centroid,1)
        index=find(id==i);
        c=zeros(size(index));
        c(:,:)=centroid(i,1);
        total=total+sum((c(:,1)-param(index,1)).^2+(c(:,1)-param(index,1)).^2);
    end
end