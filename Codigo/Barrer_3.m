function path_done = Barrer_3(start, tx, ty, n, W)
%==========================================================================
%   Nombre: Barrer_3
%
%   Esta función se encarga de generar el barrido de la zona desde la 
%   posicion del submarino en el tercer cuadrante.
%
%   Entradas:
%   start = Punto inicial del robot.
%   tx = Anchura de barrido en x.
%   ty = Anchura de barrido en y.
%   n = Limite que acota el area de barrido.
%   Wo = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%
%   Salidas:
%   path_done = Vector que contiene las posiciones que forman la    
%   trayectoria.
%==========================================================================

    path = start;
    path_done = start;
    flag = 1;

     for i=1:ty
        if (mod(i,n)==false || i==1)
            if(flag == 1)
                if(i==1)
                    for j=0:tx
                        path = [start(1)-j; start(2)+1-i; C_Altura(start(1)-j, start(2)+1-i, W)];
                        path_done = [path_done path];
                        flag=0;
                    end
                else
                    for j=0:tx
                        path = [start(1)-j; start(2)-i; C_Altura(start(1)-j, start(2)-i, W)];
                        path_done = [path_done path];
                        flag=0;
                    end
                end
             elseif(flag==0)
                   for j=0:tx
                     path = [start(1)-tx+j; start(2)-i; C_Altura(start(1)-tx+j, start(2)-i, W)];
                     path_done = [path_done path];
                     flag = 1;
                   end  
            end
        end
        if (path(1)==n)
             path = [start(1)-j; start(2)-i; C_Altura(start(1)-j, start(2)-i, W)];
             path_done = [path_done path];
        else
             path = [start(1)+tx-j; start(2)-i; C_Altura(start(1)+tx-j, start(2)-i, W)];
             path_done = [path_done path];
        end
     end
end