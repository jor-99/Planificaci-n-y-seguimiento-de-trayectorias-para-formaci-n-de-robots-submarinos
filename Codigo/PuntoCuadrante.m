function [PI, PF, C]=PuntoCuadrante(Wo,start_point, n)
%==========================================================================
%   Nombre: PuntoCuadrante
%
%   Esta función se encarga de detectar en que cuadrante se encuentra el
%   robot y ajustar el punto inicial adecuado si no esta ajustado.
%
%   Entradas:
%   Wo = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%   start_point = Punto inicial del robot.
%   n = Limite que acota el area de barrido.
%
%   Salidas:
%   PI = Punto inicial del robot.
%   PF = Punto final del robot.
%   C = Variable de tipo entero que devuelve el cuadrante en el que se
%       encuentra el robot.
%==========================================================================

    [X Y Z]=size(Wo);       %Dimensiones del mapa.

    Lx = X - n +10;             %Limite de barrido, eje x.
    Ly = Y - n +10;             %Limite de barrido, eje y.

    C=Cuadrante(Wo,start_point);

    switch(C)%Se ajustan los puntos en función del cuadrante.
        case 1
            PI = [X - Lx; Y - Ly; C_Altura(X-Lx,Y-Ly,Wo)];
            PF = [Lx; Ly; C_Altura(Lx,Ly,Wo)];
        case 2
            PI = [X - Lx; Ly; C_Altura(X-Lx,Ly,Wo)];
            PF = [Lx; Y - Ly; C_Altura(Lx,Y-Ly,Wo)];
        case 3
            PI = [Lx; Ly; C_Altura(Lx,Ly,Wo)];
            PF = [X - Lx; Y - Ly; C_Altura(X-Lx,Y-Ly,Wo)];
        case 4
            PI = [Lx; Y - Ly; C_Altura(Lx,Y-Ly,Wo)];
            PF = [X - Lx; Ly; C_Altura(X-Lx,Ly,Wo)];
        otherwise
            disp('Error!');
    end
end