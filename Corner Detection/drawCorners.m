function [ output_args ] = drawCorners(I, A )
[m,n] = size(A);
imshow(I); 
hold on;
for i =1 : m
    
    drawPoint([A(i,1) A(i,2)]);
        
end
end

