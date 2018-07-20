function [ error_1 ,testlabels ]= eigenTest(trainset,trainlabels,testset,correctlabels,W,mu,k)

%trainset is subset0 training images
%trainlabels = labels of images in training images
%test set is subsets 1-4
%W eigenvector matrix with k columns
%k is number of eigenvectors to use

%subset(0)
[N,d] = size(trainset);
[M,d] = size(testset);


trainset_projection  = trainset*W';%70xk
testset_projection   = testset*W';%Mxk

%Find 1-NN in new k dimensionalspace with l2 norm
[error_1, testlabels ]= kNN(trainset_projection,trainlabels,testset_projection,correctlabels,1,2);

end

