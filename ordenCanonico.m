

function [vec] = ordenCanonico (submat)
  [m , n, o] = size(submat);
  
  vec = reshape(submat, [m*n ,1], 3);
  
  vec = sortrows(vec, 1);
  
  for i= 1 : m - 1 
    if vec(i, 2) > vec(i + 1 ,2)
       if vec(i, 3) > vec(i + 1 ,3)
         temp = vec(i,:);
         vec(i,:) = vec(i + 1,:);
         vec(i + 1,:) = temp;
       end   
    end  
  end  
  
  vec =  reshape(vec, m*n , 1, 3);

end
