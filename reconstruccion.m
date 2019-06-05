

function [h] = reconstruccion (marcador, mascara, orden)
  
  if  strcmp(orden,'ordenComponente') == 1
      x = input('Ingrese el numero de componente: ');
    elseif  strcmp(orden, 'ordenDistancia') == 1
      x = input('Ingrese el cda de referencia: ');
    elseif  strcmp(orden, 'ordenLexicografico') == 1 
      x = input('Ingrese el vector de prioridades: ');
    elseif  strcmp(orden, 'ordenEntrelazadoBits') == 1 
      x = [];
    elseif  strcmp(orden, 'ordenCanonico') == 1  
      x = [];
    else
       error("Las opciones para orden son:ordenComponente, ordenDistancia,\n ordenCanonico, ordenEntrelazadoBits y  ordenLexicografico. ");
    end 
    
     [m , n, o]   = size(mascara);
     hk = dilatacioncolorcustom (marcador, orden, x).* (mascara & mascara);
     hk_previa = [];
     while (~isequal(hk, hk_previa))
         hk_previa = hk;
         hk = dilatacioncolorcustom (marcador, orden, x).* (mascara & mascara);
     end
     
     h = hk;

end



function [g] = dilatacioncolorcustom (F, orden, x)
  
    
    

   [m,n, o] = size(F);
   
   g = zeros(m,n, 3) ;
   for i = 1 : m
      for j = 1 : n
        contador = 1;
        submat = [];
        for k =  -1: 1
          for l = -1 : 1
            if i + k > 0 && i + k < m + 1 && j + l > 0 && j + l < n +1
              submat(contador, 1, :) = F(i + k,  j + l, : );
              contador = contador + 1;
            end  
          end
        end 
        temp = aplicarOrden(submat, orden, x);
        [r, s, t] = size(temp);
         g(i,j, :) =  temp(r, 1, :);
      end
  end  
   
   
end


function e =  refleccion(E)
    [m,n, o] = size(E);
    e(:,:,1)  = zeros(m); 
    e(:,:,2)  = zeros(m);
    e(:,:,3)  = zeros(m);
    for i = 1 : m 
      for j = 1 : n   
           e( m -i + 1,n - j + 1, :) = E(i,j,:);
      end
    end  
end  

function vec = aplicarOrden(submat, orden, x)
    if  strcmp(orden,'ordenComponente') == 1
      vec = ordenComponente(submat,x);
    elseif  strcmp(orden, 'ordenDistancia') == 1
      vec = ordenDistancia(submat,x);
    elseif  strcmp(orden, 'ordenLexicografico') == 1
      vec = ordenLexicografico(submat,x);
    elseif  strcmp(orden, 'ordenEntrelazadoBits') == 1 
      vec = ordenEntrelazadoBits(submat);
    elseif  strcmp(orden, 'ordenCanonico') == 1  
      vec = ordenCanonico(submat);
    else
       error("Las opciones para orden son:ordenComponente, ordenDistancia,\n ordenCanonico, ordenEntrelazadoBits y  ordenLexicografico. ");
    end 
    
end   