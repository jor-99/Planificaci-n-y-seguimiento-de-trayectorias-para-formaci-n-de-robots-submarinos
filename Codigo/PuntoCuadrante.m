function [PI, PF]=PuntoCuadrante(Wo, n)
%==========================================================================
%   Nombre: PuntoCuadrante
%
%   Esta función se encarga de ajustar el punto inicial adecuado si no esta
%   ajustado. Tambien esta función esta pensada para introducir facilmente 
%   nuevos puntos de inicio.
%
%   Entradas:
%   Wo = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%   n = Limite que acota el area de barrido.
%
%   Salidas:
%   PI = Punto inicial del robot.
%   PF = Punto final del robot.
%==========================================================================

    [X Y Z]=size(Wo);       %Dimensiones del mapa.

    Lx = X - n +10;             %Limite de barrido, eje x.
    Ly = Y - n +10;             %Limite de barrido, eje y.

    PI = [X - Lx; Y - Ly; C_Altura(X-Lx,Y-Ly,Wo)];
    PF = [Lx; Ly; C_Altura(Lx,Ly,Wo)];
       
end