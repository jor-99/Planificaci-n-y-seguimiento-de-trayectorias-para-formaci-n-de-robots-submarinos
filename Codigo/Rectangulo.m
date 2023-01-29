function Rectangulo(posicion)
%==========================================================================
%   Nombre: Rectangulo
%
%   Esta función se encarga de dibujar el submarino en funcion de su 
%   posición y orientación.
%
%   Entradas:
%   posicion = Posicion del robot (6DOF).
%==========================================================================
    
    %Posición del robot
    xp=posicion(1);
    yp=posicion(2);
    zp=posicion(3);
    phi=posicion(4);
    theta=posicion(5);
    psi=posicion(6);

    %Vertices del cubo
    a=[4,1,1]; b=[4,-1,1]; c=[-4,-1,1]; d=[-4,1,1];
    e=[4,1,-1]; f=[4,-1,-1]; g=[-4,-1,-1]; h=[-4,1,-1];
    
    %Matrices de rotación
    Rx = [1 0 0; 0 cosd(phi) -sind(phi); 0 sind(phi) cosd(phi)];         %Matriz de rotación en eje x
    Ry = [cosd(theta) 0 sind(theta); 0 1 0; -sind(theta) 0 cosd(theta)]; %Matriz de rotación en eje y
    Rz = [cosd(psi) -sind(psi) 0; sind(psi) cosd(psi) 0; 0 0 1];         %Matriz de rotacion en eje z
    R = Rz*Ry*Rx; %Matriz de rotacion

    %Rotacion en x
    ar = R*[a(1);a(2);a(3)];
    br = R*[b(1);b(2);b(3)];
    cr = R*[c(1);c(2);c(3)];
    dr = R*[d(1);d(2);d(3)];
    er = R*[e(1);e(2);e(3)];
    fr = R*[f(1);f(2);f(3)];
    gr = R*[g(1);g(2);g(3)];
    hr = R*[h(1);h(2);h(3)];

    %Matriz de puntos rotados
    xr = [ar(1)+xp br(1)+xp cr(1)+xp dr(1)+xp ar(1)+xp er(1)+xp fr(1)+xp br(1)+xp fr(1)+xp gr(1)+xp cr(1)+xp gr(1)+xp hr(1)+xp dr(1)+xp hr(1)+xp er(1)+xp];
    yr = [ar(2)+yp br(2)+yp cr(2)+yp dr(2)+yp ar(2)+yp er(2)+yp fr(2)+yp br(2)+yp fr(2)+yp gr(2)+yp cr(2)+yp gr(2)+yp hr(2)+yp dr(2)+yp hr(2)+yp er(2)+yp];
    zr = [ar(3)+zp br(3)+zp cr(3)+zp dr(3)+zp ar(3)+zp er(3)+zp fr(3)+zp br(3)+zp fr(3)+zp gr(3)+zp cr(3)+zp gr(3)+zp hr(3)+zp dr(3)+zp hr(3)+zp er(3)+zp];

    %Cubo
    Cubo = line(xr,yr,zr); %Dibujo cubo
    Cubo.Color = 'yellow';
    Cubo.LineWidth = 3;

    pause(0.001);
end