

%evaluating eigen Test on all subsets and k=1:20. Drawing graph
[A,B] = loadSubset(0);
T = zeros(4,9);
[W,mu] = fisherTrain(A,B,10);
for i = 1:4 
    
   [C,D] = loadSubset(i);
   [m,n] = size(C);
    
   for k = 1:9
       
       [error , testlabels] = eigenTest(A,B,C,D,W(k,:),mu,k);
       T(i,k) = (error/m)*100;
   end
    
end

legendInfo = {'Subset 1','Subset 2','Subset 3','Subset 4'};
figure; hold  on;
k=1:9;
for i = 1:4
    z = rand(1,3);
    plot(k,T(i,:),'Color',z);
    
end
legend(legendInfo); %i
 xlabel('K');
ylabel('Error Percentage');

[A,B] = loadSubset(0);
[W,mu] = fisherTrain(A,B,10);
imagesc(drawFaces(W, 10));
colormap(gray)