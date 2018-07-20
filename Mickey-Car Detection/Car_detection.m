F = im2double(imread('cartemplate.jpg'));

I1 = im2double(imread('car1.jpg'));
I2 = im2double(imread('car2.jpg'));
I3 = im2double(imread('car3.jpg'));

[r,c] = size(I1);

F = imresize(F,[r-150 c-150]);
%I1 = imresize(I1,.5);
%I2 = imresize(I2,.5);
%I3 = imresize(I3,.5);

F_t = F - mean(F(:));

It_1 = I1 - mean(I1(:));
It_2 = I2  - mean(I2(:));
It_3 = I3 - mean(I3(:));



T1 = imfilter(It_1,F_t,'conv');
T2 = imfilter(It_2,F_t,'conv');
T3 = imfilter(It_3,F_t,'conv');

subplot(3,2,1), imagesc(T1);
subplot(3,2,3), imagesc(T2);
subplot(3,2,5), imagesc(T3);
title('Car Detection');

%get size of filter image
[m,n] = size(F);


%car 1%%%%%%%%%%%%%%%%%%%%%%

% Find the max intensities
maxValue = max(T1(:));
% Find all locations where it exists.
[rows,cols] = find(T1 == maxValue);
[szx,szy] = size(rows);

subplot(3,2,2), imshow(I1);
rect1 =0;
for i = 1:szx
    
    
    %rows(i),cols(i) middle of image
    rect1  = [ (cols(i)-(n/2)), (rows(i)-(m/2)), m+100 ,n-200];
    h = rectangle('position',rect1);
    
    
end

%car 2%%%%%%%%%%%%%%%%%%%%%%

% Find the max intensities
maxValue = max(T2(:));
% Find all locations where it exists.
[rows,cols] = find(T2 == maxValue);
[szx,szy] = size(rows);

subplot(3,2,4), imagesc(I2);
rect2 = 0;
for i = 1:szx
    
    
    %rows(i),cols(i) middle of image
    rect2  = [ (cols(i)-(n/2)), (rows(i)-(m/2)), m+100 ,n-300];
    h = rectangle('position',rect2);
    
    
end

%car 3%%%%%%%%%%%%%%%%%%%%%%

% Find the max intensities
maxValue = max(T3(:));
% Find all locations where it exists.
[rows,cols] = find(T3 == maxValue);
[szx,szy] = size(rows);

subplot(3,2,6), imagesc(I3);
rect3 = 0;
for i = 1:szx
    
    
    %rows(i),cols(i) middle of image
    rect3  = [ (cols(i)-(n/2)), (rows(i)-(m/2)), m ,n];
    h = rectangle('position',rect3);
    
    
end


%%%%%%%%%%%%%%%%%%%%%%

%Now lets calculate the bounding box

%construct rectangle from txt files


x = importdata('car1.txt');
y = importdata('car2.txt');
z = importdata('car3.txt');


%truth bounding boxes
rct1 = [x(1) x(4) (x(2)-x(1)) (x(4)-x(3))];
rct2 = [y(1) y(4) (y(2)-y(1)) (y(4)-y(3))];
rct3 = [z(1) z(4) (z(2)-z(1)) (z(4)-z(3))];


%now calculate the overlap percentages

r1 = rectint(rect1,rct1)/(rect1(3)*rect1(4) + rct1(3)*rct1(4));
r2 = rectint(rect2,rct2)/(rect2(3)*rect2(4) + rct2(3)*rct2(4));
r3 = rectint(rect3,rct3)/(rect3(3)*rect3(4) + rct3(3)*rct3(4));


















