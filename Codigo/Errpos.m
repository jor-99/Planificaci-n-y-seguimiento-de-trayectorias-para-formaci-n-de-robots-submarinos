function [error]=Errpos(pos,tra)
%==========================================================================
%   Nombre: Errpos
%
%   Esta función se encarga de calcular el error de posición del AUV con 
%   respecto a la trayectoria.
%
%   Entradas:
%   pos = Posición del robot lider (3DOF).
%   tra = Vector de puntos de la trayectoria a realizar. 
%
%   Salidas:
%   error = Error de posición resultante.
%==========================================================================

    errdist = [];

    for i=1:length(tra)
        punto = tra(:,i);
        distancia = distanciaeuclidia(pos,punto);
        errdist = [errdist distancia];
    end
    error = min(errdist);
end

function [dist]=distanciaeuclidia(posicion, p)
%==========================================================================
%   Nombre: distanciaeuclidia
%
%   Esta función esta empleada para calcular la distancia euclidia de los 
%   distintos puntos que conforman la trayectoria.
%
%   Entradas:
%   posicion = Esta variable es la posición actual del submarino.
%   p = Punto de la trayectoria para medir su distancia.
%
%   Salida:
%   dist = distancia entre la posicion del submarino y el punto. 
%==========================================================================
    dist=sqrt((posicion(1)-p(1))^2+(posicion(2)-p(2))^2+(posicion(3)-p(3))^2);
end