function path_done = GestorBarrido(start, finish, n, W)
%==========================================================================
%   Nombre: GestorBarrido
%
%   Esta función se encarga de generar el barrido del robot. Esta
%   estructura esta pensada para poder generar mas barridos desde distintos
%   puntos o distintas direcciones con mayor facilidad.
%
%   Entradas:
%   start = Punto inicial del robot.
%   finish = Punto final del robot.
%   n = Limite que acota el area de barrido.
%   W = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%
%   Salidas:
%   path_done = Vector que contiene las posiciones que forman la    
%   trayectoria.
%==========================================================================
    
    tx=abs(finish(1)-start(1)); %Anchura de barrido en x.
    ty=abs(finish(2)-start(2)); %Anchura de barrido en y.

    path_done = Barrer_1(start, tx, ty, n, W);

end