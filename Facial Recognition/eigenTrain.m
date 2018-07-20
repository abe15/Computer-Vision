function [ W, mu ] = eigenTrain( trainset,k )
%This function performs PCA on the data in trainset
%
%Input:
%       trainset: Training data images
%       k: The number of eigenvectors to use


%trainset is subset 0 of training examples 


[N,d] = size(trainset);
%each row is a

%get the mean of each image
mu = mean(trainset,2);
%subtract by mu to make sure mean of data is 0
trainset =  bsxfun(@minus,trainset,mu);
%covariance matrix
sigma = (trainset'*trainset)./N;

%U contains all N eigenvectors on its colums
[U,D,V] = svd(sigma);

%extract the top k
W = U(:,1:k)';
%W = U';
end

