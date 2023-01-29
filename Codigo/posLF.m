function [distF1, distF2, distFoll] = posLF(pos,posF1,posF2)
%==========================================================================
%   Nombre: posLF
%
%   Esta función se encarga de calcular la distancia que existe entre el 
%   lider y los followers. Se emplea para obtener datos de como se mantiene
%   la formación.
%
%   Entradas:
%   pos = Posición del robot lider (3DOF).
%   posF1 = Posición del robot seguidor 1 (3DOF).
%   posF2 = Posición del robot seguidor 2 (3DOF).
%
%   Salidas:
%   distF1 = Distancia del submarino 1 con respecto al lider.
%   distF2 = Distancia del submarino 2 con respecto al lider.
%==========================================================================

    distF1 = sqrt((pos(1)-posF1(1))^2+(pos(2)-posF1(2))^2+(pos(3)-posF1(3))^2);
    distF2 = sqrt((pos(1)-posF2(1))^2+(pos(2)-posF2(2))^2+(pos(3)-posF2(3))^2);
    distFoll = sqrt((posF1(1)-posF2(1))^2+(posF1(2)-posF2(2))^2+(posF1(3)-posF2(3))^2);

end