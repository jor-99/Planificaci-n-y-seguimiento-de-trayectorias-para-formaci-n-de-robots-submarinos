function [v_angxy,v_angxz,pO,Alpha] = PurePursuit(posicion,pO_ant,pO_sig,v)
    lookAhead=10;%m
    posicion = posicion.';

    err = errpos(posicion(1:3),pO_ant(1:3),pO_sig(1:3));%Error de posición

    pO = PuntoObj(posicion(1:2),pO_ant(1:2),pO_sig(1:2),lookAhead);
    pO=[pO, GetAltura(pO_sig,pO_ant,pO)]; 

    [alpha,beta]=CorrigeAngulo(pO,posicion);%Error de orientacion (en rad).

    Alpha= alpha*(180/pi);%Pasamos a grados para usarlo en las gráficas.
    if (Alpha<-180)
        Alpha = Alpha + 360;
        if (Alpha<-180)
            Alpha = Alpha +360;
        end
    end
        
    %Se calcula la curvatura para poder obtener la velocidad angular en xy.
    kapa = (2*sin(alpha))/lookAhead;
    v_angxy = kapa*v;

    %Se calcula la curvatura para poder obtener la velocidad angular en xz;
    kappa = (2*sin(beta))/lookAhead;
    v_angxz = 1.5*kappa*v;

end

function [error] = errpos(pos,pa,ps)
%==========================================================================
%   Nombre: Funcion errpista
%
%   Esta función esta empleada para calcular el error de posición con 
%   respecto a la trayectoria. 
%
%   Entradas:
%   pos = posicion en la que se encuentra el submarino.
%   pa = Punto objetivo anterior.
%   ps = Punto objetivo actual.
%
%   Salida:
%   error = distancia lateral (m).
%==========================================================================
    
    p = proyectarSeg(pos,pa,ps);

    error = sqrt((p(1)-pos(1))^2 + (p(2)-pos(2))^2 + (p(3)-pos(3))^2);   
end

function [proyeccion] = proyectarSeg(pos,pa,ps)
%==========================================================================
%   Nombre: Funcion proyectarSeg
%   
%   Esta función esta empleada para sacar la proyeccion de dos vectores 
%   necesaria para poder asi calcular la distancia lateral entre ellos.
%
%   Entradas:
%   pos = posicion en la que se encuentra el submarino.
%   pa = Punto objetivo anterior
%   ps = Punto objetivo actual
%
%   Salida:
%   proyeccion = Proyección ortogonal de vd sobre vp.
%==========================================================================
    vp=ps-pa; %Vector generado por el punto objetivo anterior y el actual.  
    vd=pos-pa; %Vector generado por el punto objetivo anterior y la posicion del robot.
    
    proyeccion = ((dot(vd,vp)/dot(vp,vp))*vp); 
    proyeccion = proyeccion + pa;
end

function [pO] = PuntoObj(posicion,pO_ant,pO_sig,r)
%==========================================================================
%   Nombre: Funcion puntoObj
%
%   Esta funcion esta implementada para obtener el punto a seguir dentro
%   del intervalo acotado por [pO_ant,pO_sig] a lo largo de la trayectoria.
%   Es decir, se determina una distancia (lookahead) en la que el robot
%   seguira la trayectoria, para ello hacemos un radio con dicha distancia
%   y se calcula la interseccion entre dicho radio y la recta objetivo.
%   Como  la interseccion puede dar dos puntos, se realiza una serie de
%   operaciones para determoinar el punto objetivo que corresponde a la
%   direccion del movimiento.
%
%   Entradas:
%   posicion = posicion en la que se encuentra el submarino.
%   pO_ant = Punto objetivo anterior.
%   pO_sig = Punto objetivo actual.
%   r = variable lookAhead, en este caso se implementara como radio de una
%   circunferencia.
%
%   Salida:
%   pO = Punto objetivo del submarino. 
%
%==========================================================================
    p1=[];
    p2=[];

    if (distancia(posicion,pO_sig)<r)
        pO = pO_sig; 
    else
        %Calculo de interseccion entre recta y circunferencia
        v_sa = pO_sig - pO_ant;
        v_ac = pO_ant - posicion;

        a = dot(v_sa,v_sa);
        b = 2*dot(v_ac,v_sa);
        c = dot(v_ac,v_ac)-r*r;
        discriminante = b*b - 4*a*c;

        if(discriminante < 0)

        else
            discriminante = sqrt(discriminante);
            r1 = (-b - discriminante)/(2*a);
            r2 = (-b + discriminante)/(2*a);
            
            % Se determina el punto objetivo que sigue el sentido del
            % movimiento
            if(r1>=0 && r1<=1)
                p1 = pO_ant + r1*v_sa;
                pO = real(p1);
            end

            if(r2>=0 && r2<=1)
                p2 = pO_ant + r2*v_sa;
                pO = real(p2);
            end
        end
        
        if(~isempty(p1) && ~isempty(p2))
            if(distancia(p1,pO_sig)<distancia(p2,pO_sig))
                pO = p1;
            else
                pO = p2;
            end
        end
    end
end

function dist = distancia(p1,p2)
    dist = sqrt((p1(1)-p2(1))^2 + (p1(2)-p2(2))^2);
end
