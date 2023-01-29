function distancia=C_Altura(Cx,Cy,W)
%==========================================================================
%   Nombre: C_Altura
%
%   Esta función se encarga de detectar el releive del mapa en la posicion
%   Cx y Cy devolviendo una altura de 20 unidades por encima del relieve.
%
%   Entradas:
%   Cx = Coordenada x del robot.
%   Cy = Coordenada y del robot.
%   W = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%
%   Salidas:
%   distancia = Variable donde se almacena la altura deseada.
%==========================================================================

distancia=60;%Limite de altura del mapa
fin=0;%Variable de tipo flag para poder salir del bucle while
Cx=round(Cx);
Cy=round(Cy);

while(~fin)
    distancia=distancia-1;
    if(W(Cx,Cy,distancia)==1)
            fin=1;
    end
end
distancia = distancia + 20;
end