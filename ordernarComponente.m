

function [vec] = ordernarComponente (submat, numComponente)
  [m , n, o] = size(submat);
  if numComponente == 1
    vec_ordenamiento = [1 2 3];
  elseif   numComponente == 2
    vec_ordenamiento = [2 1 3];
  elseif numComponente == 3
    vec_ordenamiento = [3 1 2];
  else 
    error('numComponente inválido. Opciones validas: 1, 2 y 3. ');
  end 
  
  vec = reshape(submat, [m*n ,1], 3);
  
  vec = sortrows(vec, vec_ordenamiento);
  
  vec =  reshape(vec, m*n , 1, 3);
end
