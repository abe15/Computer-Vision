function [ Ujk ] = central_moment( I,j,k,d )

[m,n] = size(I);

% S = white region
%B = otsu(I);

M00 = moment(I,0,0,d);
M01 = moment(I,0,1,d);
M10 = moment(I,1,0,d);


xBar = M10/M00;
yBar = M01/M00;

Ujk = 0;

for x = 1:n
    
    for y = 1:m        
             Ujk = Ujk + (x - xBar)^j * (y-yBar)^ k;        
    end    
end
end

