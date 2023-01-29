 function [pos,uN1,vN1,wN1,pN2,qN2,rN2] = CinematicaSub(posicion,v_x,w_xy,q_xz,ts)
 %==========================================================================
%   Nombre: CinematicaSub
%
%   Esta función se encarga de calcular la cinemática del robot.
%
%   Entradas:
%   posicion = Posición actual del robot.
%   v_x = Velocidad lineal en el eje x.
%   w_xy = Velocidad de rotación en el eje z.
%   q_xz = Velocidad de rotación en el eje y.
%   ts = Tiempo trancurrido.
%
%   Salidas:
%   pos = Posición del robot una vez aplicada la cinematica en función del
%   tiempo.
%==========================================================================

%Velocidades lineal y rotación
u= v_x; %Velocidad lineal en el eje x; Avance;
v= 0; %Velicidad lineal en el eje y; Desvio;
w= 0; %Velocidad lineal en el eje z; Viraje;
p= 0; %Velocidad rotacion sobre el eje x; Roll;
q= 50*q_xz; %Velocidad rotacion sobre el eje y; Pitch;
r= 50*w_xy ; %Velocidad rotacion sobre el eje z; Yaw;

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
V1 = [u; v; w]; %vector de velocidades lineales 
V2 = [p; q; r]; %vector de velocidades angulares
V  = [V1, V2]; %Vector de velocidades
  
%Cinemática
N1=R*V1; %Vector de velocidades lineales del submarino
uN1 = N1(1); %Velocidad del submarino en el eje x (i)
vN1 = N1(2); %Velocidad del submarino en el eje y (j)
wN1 = N1(3); %Velocidad del submarino en el eje z (k)
N2 = T*V2; %Vector de velocidades angulares del submarino
pN2 = N2(1); %Velocidad angular del submarino en el eje x (i)
qN2 = N2(2); %Velocidad angular del submarino en el eje y (j)
rN2 = N2(3); %Velocidad angular del submarino en el eje z (k)
%Posicion
xs = xs + uN1*ts; %Posición del submarino en el eje x
ys = ys + vN1*ts; %Posición del submarino en el eje y
zs = zs + wN1*ts; %Posición del submarino en el eje z
phi = phi + pN2*ts; %Angulo phi en la siguiente posición.
theta = theta + qN2*ts; %Angulo theta en la siguiente posición.
psi = psi + rN2*ts; %Angulo psi en la siguiente posición.



pos = [real(xs);real(ys);real(zs);phi;theta;psi];

 end