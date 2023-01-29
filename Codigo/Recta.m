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

%     for i=11:91
%         path = [i;PI(2);PI(3)];
%         Trayectoria = [Trayectoria path];
%     end

    for i=21:60%Recta
        path = [i;PI(2);PI(3)];
        Trayectoria = [Trayectoria path];
    end
    for i=1:30
        path = [60-i*0.5773;51+i;PI(3)];
        Trayectoria = [Trayectoria path];
    end
end