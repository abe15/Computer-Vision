function [ F ,Ix,Iy ] = image_filter( I,sigma )

%Gaussian Function 1/(2*pi*sigma^2) * e^(-(x^2+y^2)/(2*sigma^2)


I = rgb2gray(I);
%Kernel matrix
K = zeros(2*sigma+1,2*sigma+1);

%Calculate kernel entries

[r,c] = meshgrid(-3*sigma:3*sigma,-3*sigma:3*sigma);
K = (1/(2*pi*sigma^2))*exp(-(r.^2 + c.^2)/(2*sigma^2));

%normalize
K = K/sum(K(:));


%Now convolutionize Image with kernel K

%Filtered image
F = imfilter(I,K);


%Now compute gradients

%d/dx
DX = [-1/2 0 1/2];
%d/dy
DY = [-1/2 ;0; 1/2];

Ix = imfilter(I,DX);

Iy = imfilter(I,DY);



end

