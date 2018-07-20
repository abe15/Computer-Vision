

F = im2double(imread('filter.jpg'));
I = im2double(imread('toy.png'));

F_t = F - mean(F(:));
I_t = I - mean(I(:));


T = imfilter(I_t,F_t,'conv');

imagesc(T);
title('Mickey Heat Map');

%get size of filter image

[m,n] = size(F);


% Find the max intensities
maxValue = max(T(:));

%should be 3 . Each center of mickey value
% Find all locations where it exists.
[rows,cols] = find(T == maxValue);
[szx,szy] = size(rows);

figure, imshow(I);
title('Mickey Bounding Boxes');
rect = {[],[],[]};
for i = 1:szx
    
    
    %rows(i),cols(i) middle of image
    rect{i} = [ (cols(i)-(n/2)), (rows(i)-(m/2)), m ,n];
    h = rectangle('position',rect{i});
    
    
end


%Make up truth bounding boxes

r1 = [270 36 (395-270) (160-35)];
%rectangle('position',r1);
r2 =  [70 120 (230-100) (262-120)];
%rectangle('position',r2);
r3 = [306 204 (449-306) (310-197)];
%rectangle('position',r3);

ratio1 = rectint(rect{1},r2)/(rect{1}(3)*rect{1}(4) + r2(3)*r2(4)-rectint(rect{1},r2));
ratio2 = rectint(rect{2},r1)/(rect{2}(3)*rect{2}(4) + r1(3)*r1(4)-rectint(rect{2},r1));
ratio3 = rectint(rect{3},r3)/(rect{3}(3)*rect{3}(4) + r3(3)*r3(4)-rectint(rect{3},r3));





