function Wo = Fmapa(Tipo)
%==========================================================================
%   Nombre: Fmapa
% 
%   Función que genera el mapa submarino. Se genera un plano tridimensional
%   que sera el relieve de la superficie submarina. 
%
%   Entrada:
%   Tipo = Tipo de mapa a elegir (1 mapa llano, 2 mapa con dunas).
%
%   Salida:
%   Wo = Matriz de 3 dimensiones formada por 1 y 0 que conforman el mapa.
%
%==========================================================================

x=[0:0.1:10]; %Dimensión del eje X
y=[0:0.1:10]; %Dimensión del eje Y

[xq,yq]=meshgrid(x,y); %Se genera un plano con las dimensiones

switch(Tipo)%Eleccion de mapa
    case 1
        z=1;%Mapa llano 
    case 2
        z=sin(xq)+cos(yq); %Funcion para dar forma al relieve
end

h=25;
altura=rescale(z, 1, h);

%% Se dibuja el mapa 
[a,b]=size(z);
Wo=zeros(a,b,h+35);
 for i=2:a-1 
     for j=2:b-1
         for k=2:h
             % Se ponen ceros en los sitios libres
             if k<=round(altura(i,j))
                 Wo(i,j,k)=1;
             end
         end
     end
 end

%% Limites del mapa
Wo(1,:,:)=1;
Wo(100,:,:)=1;
Wo(:,1,:)=1;
Wo(:,100,:)=1;
Wo(:,:,1)=1;
Wo(:,:,60)=1;
end