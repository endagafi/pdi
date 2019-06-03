

function [g] = ErosionColor (F, orden)
  
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
    
   reflex = refleccion(F);
   
   [m,n, o] = size(F);
   
   g(:,:,1)  = zeros(m,n); 
   g(:,:,2)  = zeros(m,n);
   g(:,:,3)  = zeros(m,n);
   
   for i = 1 : m
    for j = 1 : m
       ## Falta este concepto que no es como en binario XD tengo que consultar g(i,j, :) = aplicarOrden(submat, orden, x) (1, :, :);
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
