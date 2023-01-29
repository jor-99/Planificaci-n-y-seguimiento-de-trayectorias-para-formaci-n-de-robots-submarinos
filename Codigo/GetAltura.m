function Altura=GetAltura(pO_sig,pO_ant,pO)
%==========================================================================
%   Nombre: GetAltura
%
%   Esta función se encarga de calcular la altura del punto objetivo actual
%   en la trayectoria para que pueda ser seguido por el robot.
%   La trayectoria se descompone en rectas, esta función se encarga de
%   determinar la altura en la que se encuentra el pO mientras avanza en
%   dicha recta.
%
%   Entradas:
%   pO_sig = Punto objetivo siguiente.
%   pO_ant = Punto objetivo anterior.
%   pO = Punto objetivo actual.
%
%   Salidas:
%   Altura = Devuelve la altura del punto
%==========================================================================
    
    pO = [pO, pO_ant(3)];
    Recorrido = pO_sig - pO_ant;
    Base = pO - pO_ant;

    ang = acos((Recorrido(1)*Base(1)+Recorrido(2)*Base(2)+Recorrido(3)*Base(3))/((sqrt(Recorrido(1)*Recorrido(1)+Recorrido(2)*Recorrido(2)+Recorrido(3)*Recorrido(3)))*sqrt(Base(1)*Base(1)+Base(2)*Base(2)+Base(3)*Base(3))));
    distancia = sqrt((pO(1)-pO_ant(1))^2 + (pO(2)-pO_ant(2))^2);

    Altura = tan(ang)*distancia;
    if(Recorrido(3)>0)
        Altura = pO_ant(3) + Altura;
    else
        Altura = pO_ant(3) - Altura;
    end
end