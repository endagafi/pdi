

function [vec] = ordenDistanica (submat, referencia)
  
  [m , n, o] = size(submat);
 
   vec_ordenamiento = [4 1 2 3];
  vec = reshape(submat, [m*n ,1], 3);
  
  for i=1:m 
      distancia = (vec(i,1) - referencia(:,:,1)) ^ 2 +  (vec(i,2) - referencia(:,:,2)) ^ 2  +  (vec(i,3) - referencia(:,:,3)) ^ 2;
      
      distancia =  sqrt(distancia);
      vec(i, 4) = distancia;
  end
  
  vec = sortrows(vec, vec_ordenamiento);
  
  vec =  reshape(vec, m*n , 1, 4);
  
  vec(:,:,4) = [];

end
