function [ A ] = corner_detection(I,Ix,Iy,w,top_n)


%Used to hold top corner coordinates
n = zeros(top_n,3);
index_n = 1;

[numRows, numCols] = size(I);

IxIx = Ix.^2;
IyIy = Iy.^2;
IxIy = Ix .* Iy;
%2*sigma+1
window = ones(2*w+1,2*w+1);
Ix_sum = conv2( IxIx, window );
Iy_sum = conv2( IyIy, window );
Ixy_sum = conv2( IxIy, window);

%hold the lambda mins
lambda = zeros(size(I));

for i = 20:numRows-20
    for j = 20:numCols-20
                 
         C =[Ix_sum(i,j), Ixy_sum(i,j); Ixy_sum(i,j), Iy_sum(i,j)];
         
         lambda(i,j) = min(eig(C));         
    end
end




%Here we have the matrix lambda with eigenvalues

for i = 20:numRows-20
    for j = 20:numCols-20
        eigenVector = zeros(8,1);
        index = 1;
        for k = (i-1):(i+1)
            for q = (j-1):(j+1)
                
                if( k>0 && k<= numRows && q>0 && q<=numCols)
                    
                    %compare pixel ij with its neighbors
                    if( k==i && q==j)
                    else
                        
                        eigenVector(index) = lambda(k,q);
                        index = index + 1;
                        
                    end
                end
                
            end
        end
        %done. now have vector with eigenvalues
        %Check if corner
        x = lambda(i,j)>= eigenVector(1:index-1);
        if(sum(x) == index-1)
            %then i,j is a corner. record value and location
            n(index_n,:) = [j,i ,lambda(i,j)];
            index_n = index_n + 1;
            
        end
        
    end
    
end

m = sortrows(n,3);

[x, y ] = size(m);

A = m(x-top_n+1:x,:);
A(:,3) = [];

end

