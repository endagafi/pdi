

function [vec] = ordenLexicografico(submat, vectorPrioridad)
  if size(vectorPrioridad) ~= [1,3]
    error ('Vector de prioridades inválido.')
  end
  
  [m , n, o] = size(submat); 
  
  vec = reshape(submat, [m*n ,1], 3);
  
  vec = sortrows(vec, vectorPrioridad);
  
  vec =  reshape(vec, m*n , 1, 3);

end
