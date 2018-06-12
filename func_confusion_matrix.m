function [conf_mat,accr,precision,recall,order]=func_confusion_matrix(label,prediction)
    pred_size=max(size(prediction,1),size(prediction,2));
    prediction=reshape(prediction,[1,pred_size]);
    label=reshape(label,[1,pred_size]);
    unique_labels=unique(label);
    order=unique_labels;
    num_of_label=size(unique_labels,2);
    conf_mat=zeros(num_of_label,num_of_label);
    for i=1:size(label,2)
        actual_index=find(ismember(unique_labels,label{i}));
        pred_index=find(ismember(unique_labels,prediction{i}));
        conf_mat(actual_index,pred_index)=conf_mat(actual_index,pred_index)+1;
    end
    accr=sum(diag(conf_mat))/sum(conf_mat(:));
    precision=zeros(num_of_label,1);
    recall=zeros(num_of_label,1);
    for i=1:num_of_label
        precision(i)=conf_mat(i,i)/sum(conf_mat(1:num_of_label,i));
        recall(i)=conf_mat(i,i)/sum(conf_mat(i,1:num_of_label));
    end
end
