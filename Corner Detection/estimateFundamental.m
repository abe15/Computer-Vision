function A = estimateFundamental(p1,p2)

%convert to homogenous coordinates
p1 = [p1;ones(13,1)'];
p2 = [p2;ones(13,1)'];

n1 = p1;
n2 = p2;
%Nomrmalize data ---------------------------
c1 = mean(n1(1:2,:)')'; 
newp1(1,:) = n1(1,:)-c1(1);
newp1(2,:) = n1(2,:)-c1(2);

c2 = mean(n2(1:2,:)')'; 
newp2(1,:) = n2(1,:)-c2(1);
newp2(2,:) = n2(2,:)-c2(2);

dist1 = sqrt(newp1(1,:).^2 + newp1(2,:).^2);
dist2 = sqrt(newp2(1,:).^2 + newp2(2,:).^2);


scale1 = sqrt(2)/mean(dist1(:));
scale2 = sqrt(2)/mean(dist2(:));

T1 = [scale1,0,-scale1*c1(1);0,scale1,-scale1*c1(2);0,0,1];
T2 = [scale2,0,-scale2*c2(1);0,scale2,-scale2*c2(2);0,0,1];
  
  
n1 = T1*n1;
n2 = T2*n2;
%Finished normalization-----------------------

A = [];
%last row linear comb of 1st 2 rows, can take out
for i=1:size(n1,2)
   A = [A; zeros(3,1)'     -n2(3,i)*n1(:,i)'   n2(2,i)*n1(:,i)'; ...
           n2(3,i)*n1(:,i)'   zeros(3,1)'     -n2(1,i)*n1(:,i)'];
          % -n2(2,i)*n1(:,i)' n2(1,i)*n1(:,i)' zeros(3,1)'];
      
end

[U,D,V] = svd(A);

A = reshape(V(:,9),3,3)';
%[U, D, V] = svd(A);
%A=U*diag([D(1,1) D(2,2) 0])*V';
%denormalize
A = inv(T2)*A*T1;

