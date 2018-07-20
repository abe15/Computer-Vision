
% get fundamental matrix
F = estimateFundamental(cor1',cor2');
[m,n] = size(cor1);

imshow([dino01,[dino02;zeros(50,1900,3)]])
hold on;
for i =1 : m   
    x=[cor1(i,1) cor1(i,2)];
    y = [cor2(i,1) cor2(i,2)] + [2000,0];
    
    drawPoint(x);
    drawPoint(y);
    line([x(1) y(1)],[x(2) y(2)]);
end