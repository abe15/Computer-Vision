function [ O ] = otsu( I )

I_2 = zeros(size(I));

[rows columns numberOfColorChannels] = size(I);
if numberOfColorChannels > 1
  I_2 = rgb2gray(I);
else
  I_2= I; % It's already gray.
end

I = I_2;

%I_2 = rgb2gray(I);
%Convert image to grayscale
%I = rgb2gray(I);

%Normalize and convert to double precision
I  = im2double(I);

%Create histogram of intensities and normalize it.
%There are 256 shades of gray
H = imhist(I,256);
H = H/sum(H);

%Holds sigma values for each potential threshold value
sigma = zeros(256,1);

% i represents a threshold. pixels with level< i are class
%0. pixels with level level>i ae class 1
for i = 1:256
    
    %number of pixels in class 0, background
    w_0 = sum(H(1:i,1));
    
    %number of pizels in class 1,objects
    w_1 = sum(H((i+1): 256,1));
    
    %class mean levelfor class 0 . sum j*p_j from j = 1 to j=t 
    u_0 = sum( H(1:i,1) .* (1:i)' )/w_0;
    
    u_1 = sum( H((i+1):256,1) .* ((i+1):256)' )/w_1;
    
    sigma(i) = w_0*w_1*((u_1-u_0)^2);
end

%Choose k to be index of max sigma value value
[maxval,k] = max(sigma);

%Now create binary image
% Those with level  < k are 0 else 1
O = (I_2 > k) + 0;

end

