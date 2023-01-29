function [pos] = CinematicaInvSub(posicionF,posicion,ts)
%==========================================================================
%   Nombre: CinematicaInvSub
%
%   Esta función se encarga de calcular la cinemática inversa del robot. 
%   Calcula el error de posicion y orientación con la diferencia de la
%   posicion/orientacion actual con la deseada. Aplica la ley de control 
%   se calcula la velocidad lineal y angular necesaria para alcanzar dicho
%   estado en un tiempo finito. Se calcula la cinematica para recalcular la
%   posición del robot con las velocidades. 
%
%   Entradas:
%   posicionF = Posición deseada del robot (6DOF).
%   posicion = Posición actual del robot (6DOF).
%   ts = tiempo de simulación.
%
%   Salidas:
%   pos = Posición del robot una vez aplicada la cinematica en función del
%   tiempo.
%==========================================================================

%Posicion inicial
xs=posicion(1);     phi=posicion(4);   %Rotación sobre eje x;
ys=posicion(2);     theta=posicion(5); %Rotación sobre eje y;
zs=posicion(3);     psi=posicion(6);   %Rotación sobre eje z;

%Definimos matrices de Rotación y velocidades empleando angulos de
%Euler
Rx = [1 0 0; 0 cosd(phi) -sind(phi); 0 sind(phi) cosd(phi)];         %Matriz de rotación en eje x
Ry = [cosd(theta) 0 sind(theta); 0 1 0; -sind(theta) 0 cosd(theta)]; %Matriz de rotación en eje y
Rz = [cosd(psi) -sind(psi) 0; sind(psi) cosd(psi) 0; 0 0 1];         %Matriz de rotacion en eje z
R = Rz*Ry*Rx; %Matriz de rotacion 
%Matriz de transformación (vector de velocidades angular y angulos de
%Euler)
T = [1 sind(phi)*tand(theta) cosd(phi)*tand(theta); 0 cosd(phi) -sind(phi); 0 sind(phi)/cosd(theta) cosd(phi)/cosd(theta)];
%Error de posicion
epx=posicionF(1)-posicion(1);
epy=posicionF(2)-posicion(2);
epz=posicionF(3)-posicion(3);
ep=[5*epx;5*epy;5*epz];

%Cinematica inversa velocidad
V1=inv(R)*ep;
u=V1(1);
v=V1(2);
w=V1(3);
V1 = [u; v; w]; %vector de velocidades lineales

%Cinematica inversa del ángulo
ephi=posicionF(4)-posicion(4);
etheta=posicionF(5)-posicion(5);
epsi=posicionF(6)-posicion(6);
ea=[1*ephi;2*etheta;2*epsi];
V2=inv(T)*ea;
p=V2(1);
q=V2(2);
r=V2(3);
V2 = [p; q; r]; %vector de velocidades angulares
V  = [V1, V2]; %Vector de velocidades
  
%Cinemática
N1=R*V1; %Vector de velocidades lineales del submarino
uN1 = N1(1); %Velocidad del submarino en el eje x (i)
vN1 = N1(2); %Velocidad del submarino en el eje y (j)
wN1 = N1(3); %Velocidad del submarino en el eje z (k)
N2 = T*V2; %Vector de velocidades angulares del submarino
pN2 = N2(1); %Velocidad del submarino en el eje x (i)
qN2 = N2(2); %Velocidad del submarino en el eje y (j)
rN2 = N2(3); %Velocidad del submarino en el eje z (k)
%Posicion
xs = xs + uN1*ts; %Posición del submarino en el eje x
ys = ys + vN1*ts; %Posición del submarino en el eje y
zs = zs + wN1*ts; %Posición del submarino en el eje z
phi = phi + pN2*ts; %Angulo phi en la siguiente posición.
theta = theta + qN2*ts; %Angulo theta en la siguiente posición.
psi = psi + rN2*ts; %Angulo psi en la siguiente posición.

pos = [xs;ys;zs;phi;theta;psi];

end