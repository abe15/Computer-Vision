function [B,classes] = connected_components(I)


%get size of image
[m,n] = size(I);

%var to assign labels
current_label = 1;

%holds labels

B = zeros(m,n);

%holds equivalence classes
equiv = {};

for j = 1: n
    
    for i = 1:m
        
        if(i == 40 && j==127)
           x=1; 
        end
        
        if(I(i,j) == 1 && B(i,j) == 0)
            
            %found an unlabeled pixel
            %let's look at it's neighbors
            %that have been seen
            
            %holds labels of seen neighbors
            
            neighbors = zeros(1,4);
            
            if(i-1> 0)
                
                neighbors(1,1) = B(i-1,j);
                
                if( j-1> 0)
                    
                    neighbors(1,2) = B(i-1,j-1);
                    
                end
            end
            
            if(j-1 >0)
                
                neighbors(1,3) = B(i,j-1);
                
                if(i+1 <= m)
                    neighbors(1,4) = B(i+1,j-1);
                    
                end
                
                
            end
            
            %if all neighbors are 0 then new label assigned
            if( sum(neighbors(:)) == 0)
                B(i,j) =  current_label;
                current_label = current_label + 1;
                
            else% else it has a labeled neighbor
                %0 values aren't important
                neighbors( neighbors==0 ) = [];
                
                %check if all neighbors have the same label
                if( all(neighbors == neighbors(1)))
                    
                    %unique so assign this label to this pixel
                    
                    B(i,j) = neighbors(1);
                    
                else
                    %else we have that at least 2 neighbors
                    %contain differentlabels
                    %add to equivalence class
                    neighbors = unique(neighbors);
                    equiv = [equiv neighbors];
                    B(i,j) = neighbors(1);
                    
                end
                
                
            end
        end
        
    end
   
    
end
 


%A little bit of classes clean up
classes = cell(current_label,1);
[m,n] = size(equiv);

index = 0;
for i = 1:current_label
    index =index +  1;
    
    for j = 1:n
        
        if(ismember(i,equiv{j}))
            
           classes{index} = [classes{index} equiv{j}];          
        end
    end
end

%remove duplicates
[p,q] = size(classes);
for i= 1:p
    a =classes{i,1};
    a = unique(a);
   classes{i,1} = a;
end
 
%combine classes
for o = 1:2
for i = 1:(p-1)
    
    [m,n] = size(classes{i,1});
    if(m ~= 0)
    for k = 1:n
        
            
        neigh = classes{i,1}(1,k);
        classes{i,1} = [classes{i,1} classes{neigh,1}];
        classes{i,1}= unique(classes{i,1});
     end
        
    end
       
end
end


%Finally, relabel


for i = 1:(p-1)
    
    [m,n] = size(classes{i,1});
    for j = 2:n
       
        B( B == classes{i,1}(1,j) ) = classes{i,1}(1);
        
    end
    
    
    
end

 B( B== 1) = 57;



%EOF