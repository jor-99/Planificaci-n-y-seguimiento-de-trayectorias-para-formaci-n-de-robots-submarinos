function path_done = GestorBarrido(start, finish, C, n, W)
%==========================================================================
%   Nombre: GestorBarrido
%
%   Esta función se encarga de generar el barrido en funcion del 
%   cuadrante en el que se encuentre el robot.
%
%   Entradas:
%   start = Punto inicial del robot.
%   finish = Punto final del robot.
%   C = Cuadrante del robot.
%   n = Limite que acota el area de barrido.
%   W = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%
%   Salidas:
%   path_done = Vector que contiene las posiciones que forman la    
%   trayectoria.
%==========================================================================
    
    tx=abs(finish(1)-start(1)); %Anchura de barrido en x.
    ty=abs(finish(2)-start(2)); %Anchura de barrido en y.


    switch(C)
        case 1
            path_done = Barrer_1(start, tx, ty, n, W);
        case 2
            path_done = Barrer_2(start, tx, ty, n, W);
        case 3
            path_done = Barrer_3(start, tx, ty, n, W);
        case 4
            path_done = Barrer_4(start, tx, ty, n, W);
    end
end