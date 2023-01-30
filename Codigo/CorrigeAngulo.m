function [alpha, beta] = CorrigeAngulo(pO,posicion)
%==========================================================================
%   Nombre: Funcion CorrigeAngulo
%
%   Esta función esta empleada para calcular el error de pista cruzada 
%   (croos track error), que es la distacia que hay entre la orientación 
%   del robot y el punto objetivo. En este caso, calculo dicho error en 
%   unidades angulares. 
%
%   Entradas:
%   p0 = Punto objetivo.
%   posicion = Punto en el que se encuentra el robot.
%   psi = Orientación del robot en el plano xy.
%
%   Salida:
%   alpha = La diferencia angular en radianes.
%==========================================================================
    vector = pO - posicion(1:3);
    proyeccion = [vector(1),vector(2),0];

    alpha = atan2(vector(2),vector(1));
    beta = acos((vector(1)*proyeccion(1)+vector(2)*proyeccion(2)+vector(3)*proyeccion(3))/((sqrt(vector(1)*vector(1)+vector(2)*vector(2)+vector(3)*vector(3)))*sqrt(proyeccion(1)*proyeccion(1)+proyeccion(2)*proyeccion(2)+proyeccion(3)*proyeccion(3))));
    rad2deg(alpha);
    rad2deg(beta);%mirar
    posicion(6) = posicion(6)*(pi/180);
    posicion(5) = posicion(5)*(pi/180);

    alpha = alpha - posicion(6);
   
    if((vector(3)>0) && (abs(posicion(5))<beta))
        beta = -(beta - posicion(5));
        if ((beta>(pi/2)) && (vector(3)>0))
            posicion(5) = 180 + posicion(5);
            beta = beta - posicion(5);
        end
    elseif((vector(3)>0) && (abs(posicion(5))>beta))
        beta = abs(posicion(5)) - beta;
    elseif((beta>(pi/2)) && (vector(3)<0))
        beta = 360-beta;
        posicion(5) = 180 + posicion(5);
        beta = beta - posicion(5);
    else
        beta = beta - posicion(5);
    end
end