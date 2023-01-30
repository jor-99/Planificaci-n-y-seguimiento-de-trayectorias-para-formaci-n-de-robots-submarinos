function Trayectoria=Recta(PI)
%==========================================================================
%   Nombre: Recta
%
%   Esta función se encarga de generar una linea recta como trayectoria del
%   robot.
%
%   Entradas:
%   PI = Punto inicial del robot.
%
%   Salidas:
%   Trayectoria = Vector que contiene las posiciones que forman la
%                 trayectoria.
%==========================================================================

    Trayectoria=PI;
    path=PI;

    for i=21:91
        path = [i;PI(2);PI(3)];
        Trayectoria = [Trayectoria path];
    end

end