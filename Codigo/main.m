clc; clear all; close all;
%==========================================================================
%   main.m
%
%   Función principal de la simulación, se estructura de la siguiente
%   manera:
%
%   - Generar mapa: Se definen las variables y las funciones necesarias para
%   poder generar el entorno de la simulación.
%   - Generador de trayectoria: Se definen las variables y las funciones
%   necesarias para generar la trayectoria. 
%   - Variables para la simulacion: Se determinan todas las variables
%   necesarias para el desarrollo de la simulacion. Estan dicididas en
%   categorias.
%   - Bucle de simulación: Formado por un bucle while con una condición de
%   salida (cuando el robot llega al punto objetivo), las funciones
%   necesarias para el desarrollo del purepursuit, cinemática y la
%   formación de AUVs. También se almacenan las variables necesarias para
%   los resultados y las funciones necesarias para dibujar la simulación.
%   - Gráficas: En esta sección se muestran las gráficas de los resultados
%   obtenidos (comentadas por defecto).
%   - Funcion EnPos: Función que expone el criterio empleado para
%   determinar si el robot ha llegado a su destino. 
%
%   La opción por defecto si se corre el código sin realizar un cambio es
%   la formación de AUVs siguiendo una linea recta, para cambiar y realizar
%   otras simulaciones se recomienda ver antes el README del repositorio. 
%
%==========================================================================

%Generar mapa
%==========================================================================
TipoM=1;%Variable para elegir el tipo de mapa
Wo=Fmapa(TipoM);
%==========================================================================
     
%Generador de trayectoria
%==========================================================================
TipoF=1;%Variable para elegir el tipo de trayectoria
[Ta, PI, LookAhead, LA]=GestorFunciones(Wo, TipoF);
%==========================================================================

%Variables para la simulación 
%==========================================================================
%Variables dela cinematica
v=7;%m/s
t=0.1;%s
posicion=PI;%Variable que indica la posicón del submarino.
ruta = posicion; %Variable que almacena las posiciones que toma el robot a lo largo del recorrido.
error=0;%Variable que almacena el error de posición a lo largo del recorrido.
epsi=0;%Variable que almacena el error de orientación en el angulo psi.


%Variables para los robots seguidores
n=2;%Numero de robots seguidores.
[posicionesF]=Formacion(posicion);%Posición inicial de los robots seguidores.
PF=posicionesF;%Variable que acumula las posiciones de los seguidores.
distLF1=8;%Distancia ideal a mantener entre el robot lider y los seguidores.
distLF2=8;
distFF=12;%Distancia ideal a mantener entre los seguidores.



%Variables para el Purepursuit
vc=Ta(:,LookAhead);%Variable que almacena el punto final de la primera recta.
pO_ant = [posicion(1),posicion(2),posicion(3)];%Variable que indica el punto objetivo anterior del submarino.
pO_sig = [vc(1),vc(2),vc(3)];%Variable que indica el punto objetivo actual del submarino.

%Variables de control para el bucle de simulación
EnPosFinal=0;%Flag que controla la salida del bucle.
flag=1;%Variable empleada para condicionar la salida del bucle. 
i=0;%Contador que cuentas los ciclos de simulación (empleada para hacer las gráficas de resultados).
%==========================================================================

%Bucle de simulación
%==========================================================================
while(~EnPosFinal)
    %Leader
    [v_angxy,v_angxz,pO,a]=PurePursuit(posicion,pO_ant,pO_sig,v);

    [posicion]=CinematicaSub(posicion,v,v_angxy,v_angxz,t);
    
    %Operacion para determinar el siguiente intervalo de la trayectoria.
    if(flag==1)
        if((pO(1)==pO_sig(1) && pO(2)==pO_sig(2)))
            pO_ant = pO_sig;
            LookAhead =LookAhead + LA;
            if(LookAhead>length(Ta))
                LookAhead=length(Ta);
                vc = Ta(:,LookAhead);
                pO_sig = [vc(1),vc(2),vc(3)];
                flag=0;
            end
            vc = Ta(:,LookAhead);
            pO_sig = [vc(1),vc(2),vc(3)];
        end
    else
        if(EnPosicion(posicion,pO_sig))
                EnPosFinal=1;
        end
    end

     %Followers
    [posicionesFS]=Formacion(posicion);%Posición siguiente de los robots seguidores.
    
    for j=1:1:n
        [posicionesF(j*6-5:j*6)]=CinematicaInvSub(posicionesFS(j*6-5:j*6),posicionesF(j*6-5:j*6),t);
    end

    %Dibuja el submarino
    plot_map3d(pagetranspose(Wo), 0.1, 1);
    hold on;  
    title('Movimiento del Submarino')
    xlabel('x[m]')
    ylabel('y[m]')
    zlabel('z[m]')
    view(3)
    plot3(Ta(1,:),Ta(2,:),Ta(3,:), 'r-', 'LineWidth', 3)
    plot3(ruta(1,:),ruta(2,:),ruta(3,:), 'b-', 'LineWidth', 2)
    for j=0:1:(n-1)
        plot3(PF(6*j+1,:),PF(6*j+2,:),PF(6*j+3,:), 'c:', 'LineWidth', 2)
    end
    scatter3(pO(1),pO(2), pO(3), 250,'gx', 'LineWidth', 2);
    Rectangulo(posicion);
    for j=1:1:n
        Rectangulo(posicionesF(j*6-5:j*6));
    end

    %Función calculo de error de posicion y orientación
    [err]=Errpos(posicion(1:3),Ta);
    [distF1, distF2, distFoll]=posLF(posicion(1:3),posicionesF(1:3),posicionesF(7:9));
    
    %Datos de la simulación
    ruta = [ruta posicion];%Se almacena la ruta del robot.
    PF = [PF posicionesF];%Path followers
    error=[error err];%Se almacena el error de posición del robot.
    epsi=[epsi a];%Se almacena el error de orientación sobre psi.
    distLF1=[distLF1 distF1];%Se almacena la distancia entre el lider y el primer follower.
    distLF2=[distLF2 distF2];%Se almacena la distancia entre el lider y el segundo follower.
    distFF=[distFF distFoll];%Se almacena la distancia entre los seguidores.
    i=i+1;%Numero de ciclos
end
%==========================================================================

%Graficas de datos
%==========================================================================
i=0:1:i;%Se transforma la variable en un vector (tiempo transcurrido).

% figure%Error de posición
% plot(i,error), grid on
% title('Error de posicion respecto a la trayectoria')
% xlabel('t[s]')
% ylabel('m')
% 
% figure%Error de orientación
% plot(i,epsi), grid on
% title('Diferencia de orientación respecto al punto objetivo')
% xlabel('t[s]')
% ylabel('Grados')

% figure%Error de posición
% plot(i,distLF1), hold on
% plot(i,distLF2), hold off
% title('Posición respecto al Lider')
% legend('Follower 1','Follower 2')
% xlabel('t[s]')
% ylabel('m')
% 
% figure%Error de posición
% plot(i,distFF), grid on
% title('Distancia entre followers')
% xlabel('t[s]')
% ylabel('m')
%==========================================================================

function [enPos]=EnPosicion(posicion, obj)
%==========================================================================
%   Nombre: Funcion EnPosicion
%
%   Esta función esta empleada para determinar si el submarino ha llegado
%   al objetivo, se ha estipulado un pequeño margen de error para determinar
%   si el submarino ha llegado o no al punto objetivo.
%
%   Entradas:
%   posicion = Esta variable es la posición actual del submarino.
%   obj = esta variable es el punto objetivo actual del submarino.
%
%   Salida:
%   enPos = Variable de tipo booleana que determina si el submarino ha
%   llegado o no al puntop objetivo. 
%==========================================================================
    eradio=2;
    dist=sqrt((posicion(1)-obj(1))^2+(posicion(2)-obj(2))^2);
    enPos=abs(dist)<eradio;
end
