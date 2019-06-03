
function [vec] = ordenEntrelazadoBits (submat)
  [m , n, o] = size(submat)    
  vec = reshape(submat, [m*n ,1], 3);
  for i = 1:m
    bin_final = num2str(0);
    bin_1 = de2bi(vec(i,1) , 8);
    bin_2 = de2bi(vec(i,2) , 8); 
    bin_3 = de2bi(vec(i,3) , 8); 
    for j = 1:8
      bin_final = strcat(bin_final,num2str(bin_1(j))); 
      bin_final = strcat(bin_final,num2str(bin_2(j)));
      bin_final = strcat(bin_final,num2str(bin_3(j)));
    end 
   vec(i, 4) = str2num(bin_final); 
  end  
  
  vec = sortrows(vec, 4)
  
  vec =  reshape(vec, m*n , 1, 4);
  
  vec(:,:,4) = [];
  

end
