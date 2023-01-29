function C=Cuadrante(Wo,start)
%==========================================================================
%   Nombre: Cuadrante
%
%   Función empleada para determinar el cuadrante donde se encuentra el 
%   punto de inicio del submarino. Los cuadrantes estan repartidos de la
%   siguiente forma.
% 
%                                  limite_x
%                                     =
%                                     =
%                             2       =       3
%                                     =
%                                     =
%                        ===========================  limite_y
%                                     =
%                                     =
%                             1       =       4
%                                     =
%                                     =
% 
%   Entradas:
%       Wo = Mapa de la zona formado por una matriz de unos y ceros.
%         start = Punto a identificar.
%     Salidas:
%         C = Variable donde se almacena el numero del cuadrante.
%
%==========================================================================
    
    [X Y Z]=size(Wo); %Limites del mundo.
    limite_X = X/2;   %Limite de cuadrante, eje x.
    limite_Y = Y/2;   %Limite de cuadrante, eje y.

    if (start(1)<=limite_X && start(2)<=limite_Y)
        C = 1;
    elseif(start(1)>limite_X && start(2)<limite_Y)
        C = 4;
    elseif(start(1)>=limite_X && start(2)>=limite_Y)
        C = 3;
    elseif(start(1)<limite_X && start(2)>limite_Y)
        C = 2;
    end
end