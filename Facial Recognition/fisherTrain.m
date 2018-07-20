function [W,mu] = fisherTrain(trainset,trainlabels,c)

%First apply PCA to trainset so that S_wis nonsingular

%Pca--------
[N,n]= size(trainset);
[W_pca,mu] = eigenTrain(trainset,N-c);

trainset_projection  = trainset*W_pca';%70x2500 2500xN-c
%----------------
Sb = zeros(N-c,N-c);
Sw = zeros(N-c,N-c);

overall_mean=  mean(trainset_projection);
mu=overall_mean;

%calculate between class matrix
for i=1:c
    
    %# of Members in class i
    N_i = sum((trainlabels == i));
    
    
    [rows,cols] = find((trainlabels== i));
    

    mean_i = mean(trainset_projection(rows,:));
    
    Sb = Sb + N_i*(mean_i - overall_mean)*(mean_i - overall_mean)';
end


%within class
for i = 1:c
    
    [rows,cols] = find((trainlabels== i));
        
    mean_i = mean(trainset_projection(rows,:));
    
     for x = rows'
        Sw = Sw + (trainset_projection(x,:) - mean_i)'*(trainset_projection(x,:) - mean_i);
        
    end
    
end


%generalized eigenvalues
[V,D] = eig(Sb,Sw);

W_fld = V(:,1:(c-1))';

%W = W_fld*W_pca;
W = W_fld * W_pca;

end

