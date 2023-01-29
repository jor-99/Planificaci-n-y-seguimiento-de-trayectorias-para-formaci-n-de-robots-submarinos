function [Trayectoria, PI,LookAhead,LA]=GestorFunciones(Wo,TipoF)
%==========================================================================
%   Nombre: GestorFunciones
%
%   Esta función se encarga de seleccionar la trayectoria deseada llamando 
%   a la funcion que genera dicha trayectoria. La posicion inicial del                                               
%   robot lider se define en esta función.
%
%   Entradas:
%   Wo = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%   TipoF = Variable de tipo entero que define el tipo de trayectoria. 
%           1. Trayectoria realizando una recta.
%           2. Trayectoria realizando una curva en 2D.
%           3. Trayectoria realizando una espiral ascendente.
%           4. Trayectoria realizando un barrido de la zona a una altura
%           determinada.
%
%   Salidas:
%   Trayectoria = Vector que contiene las posiciones que forman la
%                 trayectoria.
%   PI = Punto inicial del robot. 
%==========================================================================

    switch(TipoF)
        case 1
            LookAhead=3;%Variable que determina la escala del siguiente punto objetivo.
            LA=5;
            PI=[21;50;21;0;0;0];
            Trayectoria=Recta(PI(1:3));
        case 2
            LookAhead=3;%Variable que determina la escala del siguiente punto objetivo.
            LA=3;
            PI=[60;20;21;0;0;90];
            Trayectoria=CurvaXY2D(PI(1:3));
        case 3
            LookAhead=3;%Variable que determina la escala del siguiente punto objetivo.
            LA=3;
            PI=[60;20;21;0;0;90];
            Trayectoria=Espiral(PI(1:3));
        case 4
            LookAhead=5;%Variable que determina la escala del siguiente punto objetivo.
            LA=7;
            PI=[10;10;40];
            n=20;
            [PI, PF, C] = PuntoCuadrante(Wo,PI,n);
            Trayectoria=GestorBarrido(PI,PF,C,n,Wo);
            PI=[PI;0;0;0];
    end
end