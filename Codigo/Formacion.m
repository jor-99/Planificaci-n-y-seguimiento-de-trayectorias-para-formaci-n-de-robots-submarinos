function [Posiciones]=Formacion(Leader)    
%==========================================================================
%   Nombre: Formacion
%
%   Esta función se encarga de calcular la formacion de los robots. La
%   formación elegida es una formación triangular.
%
%   Entradas:
%   Leader = Posición del robot lider (6DOF).
%
%   Salidas:
%   Posiciones = Posiciones (6DOF) deseadas de los robot seguidores.
%==========================================================================
    
%Calculo los puntos de mi formación respecto a la posicion del lider
    r=8;
    mu1=2.2935;%131º, Angulo de referencia para la posición del primer follower.
    mu2=3.9897;%228º, Angulo de referencia para la posición del segundo follower.
    punto1 = [Leader(1)+r*cos((Leader(6)*pi/180)+mu1)*sin(pi/2+(Leader(5)*pi/180)); Leader(2)+r*sin((Leader(6)*pi/180)+mu1)*sin(pi/2+(Leader(5)*pi/180));Leader(3)-r*cos(pi/2+(Leader(5)*pi/180));Leader(4);Leader(5);Leader(6)];
    punto2 = [Leader(1)+r*cos((Leader(6)*pi/180)+mu2)*sin(pi/2+(Leader(5)*pi/180)); Leader(2)+r*sin((Leader(6)*pi/180)+mu2)*sin(pi/2+(Leader(5)*pi/180));Leader(3)-r*cos(pi/2+(Leader(5)*pi/180));Leader(4);Leader(5);Leader(6)];
    
    Posiciones=[punto1; punto2];
    
end