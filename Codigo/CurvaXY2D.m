function Trayectoria=CurvaXY2D(PI)
%==========================================================================
%   Nombre: CurvaXY2D
%
%   Esta función se encarga de generar una curva en 2D como trayectoria del
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
    radio=20;%Radio de la circunferencia
    Cx=40; Cy=50;%Centro de la circunferencia

    for i=21:50 %recta 
        path = [PI(1);i;PI(3)];
        Trayectoria = [Trayectoria path];
    end

    for i=0:0.1:2%Circunferencia
        path = [Cx+radio*cos(i);Cy+radio*sin(i);PI(3)];
        Trayectoria = [Trayectoria path];
    end
end