function [error_1, testlabels ]= kNN(trainset,trainlabels,testset,correctlabels,k,whichNorm)
%This function takes in a train set of images with their labels and
%assigns each test image a label retrieved by the k-nearest neighbor algorithm. Then the function
%calculates the error of the labeling by comparing the labels with the true labels.

%Input : 
%           trainset: train set of images
%           trainlabel: labels for the images in trainset
%           testset: test set of images
%           correctlabels: labels for the images in testset
%           k: number of neighbors in the kNN algorithm.
%           whichNorm: When 1, this function uses the L1 norm. When 2, this
%           function uses the L2 Norm.
%
%Output:
%           error_1:number of mislabeled test images
%           testlabels: labels assigned by kNN algorithm for each test
%           image
%           
[p,q] = size(trainset);
[m,n] = size(testset);

testlabels = zeros(m,1);

error_1 = 0;

for i = 1:m
    distances = zeros(70,1);
   for j = 1:p
      %row i is ith image
      %calculte distance from test image i to train image j
      X = trainset(j,:);
      Y = testset(i,:);
      %we can ignore sqrt
      if(whichNorm == 1)
          distances(j,1) = sum(abs((X - Y)));
      else
        distances(j,1) = sum((X - Y).^2);
      end
   end
   %Got all distances from image i
   %get the k smallest values and their indices
   %indices gives
   [P , I] = sort(distances);
    
   %all labels from k nearest neighbors
   labels = trainlabels(I(1:k));% k x 1
   
   %count occurances of each one
   a = unique(labels);
   out = [a,histc(labels(:),a)];
   
   c = sortrows(out,2);
   
   label = c(end,1);
   
   testlabels(i,1) = label;
   
   correctlabel = correctlabels(i,1); 
   if( label ~= correctlabel)
       error_1 = error_1 + 1;
   end          
end

end
