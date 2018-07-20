function [ output_args ] = ssd( I1, I2, t, sigma, top_n )

%I1 = image 1 // dino01
%I2 = image 2 //dino02
%t= threshold

[F1, Ix1, Iy1] = image_filter(I1,sigma);
[F2 ,Ix2, Iy2] = image_filter(I2,sigma);

%Ci has top 50 corners of image i
C1 = corner_detection(F1,Ix1,Iy1,sigma,top_n);
C2 = corner_detection(F2,Ix2,Iy2,sigma,top_n);


imshow([I1,[I2;zeros(50,1900,3)]])
hold on;
%for each corner in image 1
for i = 1:top_n
    
    %take 9x9 patch aroundcorner
    
    row_range = C1(i,1)-9:C1(i,1)+9;
    col_range = C1(i,2)-9:C1(i,2)+9;
    x1 = max(min(row_range,size(F1,1)),1);
    x2 = max(min(col_range,size(F1,2)),1);
    %Patch 1
    P1 = F1(x1,x2);
    
    matching_corners= zeros(10,3);
    index = 1;
    %compare with each corner in image 2
    for j = 1:top_n
        
        
        row_range2 = C2(j,1)-9:C2(j,1)+9;
        col_range2 = C2(j,2)-9:C2(j,2)+9;
        x1_2 = max(min(row_range2,size(F2,1)),1);
        x2_2 = max(min(col_range2,size(F2,2)),1);
        %Patch 2
        P2 = F2(x1_2,x2_2);
        
        
        %Got two patches,cross corelate
        c = normxcorr2(P1,P2);
        %cmax = max(c(:));
        % [y2 x2] = find(c == cmax);
        [m, n] = size(c);
        centerc = c(floor(m/2),floor(n/2));
        
        if(centerc < t)
            matching_corners(index,:) = [ C2(j,1), C2(j,2),centerc];
            index = index + 1;
        end
        
    end
    
    %get corner with min nssd distance and plot it
    if(index ~= 1)
        r = sortrows(matching_corners,3);
        
        drawPoint(C1(i,:)');
        z = r(1,1:2)' + [size(F1,2);0];
        drawPoint([z(1) ,z(2)]);
        x = [C1(i,1), z(1)];
        y = [C1(i,2), z(2)];
        line(x,y);
    end
    
end



end

