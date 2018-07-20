function [ mjk ] = normalized_moment( I,j,k,d )


[m,n] = size(I);



mjk = 0;

u20 = central_moment(I,2,0,d);
u02 = central_moment(I,0,2,d);

M00 = moment(I,0,0,d);


sigma_x = sqrt(u20/M00);
sigma_y = sqrt(u02/M00);


M01 = moment(I,0,1,d);
m10 = moment(I,1,0,d);


xBar = M10/M00;
yBar = M01/M00;


for x = 1:n
    
    for y = 1:m        
             mjk = mjk + ((x-xBar)/sigma_x)^j  * ((y-yBar)/sigma_y)^k;
    end
    
end
end

