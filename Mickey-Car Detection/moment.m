function [ Mjk ] = moment(I,j,k,d )

[m,n] = size(I);

% S = white region
B = I;

Mjk = 0;

for x = 1:m
    
    for y = 1:n
        if(I(x,y) == d)
             Mjk = Mjk + B(x,y)*x^j*y^k;        
        end
        
        
    end
    
end
end

