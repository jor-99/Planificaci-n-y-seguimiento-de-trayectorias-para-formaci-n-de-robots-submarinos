%%
% Inputs:
% map: 3D map to be plotted
% alpha_val: transparency value (0: total transparency, ovbiously impossible, 1 total pacity)
% nfigure: figure number
% view_ori: orientation of the view
% F: size of something internal, never really used

function plot_map3d(map, alpha_val, nfigure, view_ori, F)
%==========================================================================
%
%   Nombre: plot_map3d
%
%   Esta función se encarga de realizar el plot del mapa mostrando el
%   entorno de simulación.
%
%   Entradas:
%   map: Mapa a representar
%   alpha_val: Valor de transparencia. 0 vacio, 1 lleno.
%   nfigure: numero de la figura
%   view_ori: orientación de la vista
%   F: tamaño
%
%   Salidas:
%       Ninguna.
%==========================================================================

    fig=figure(nfigure); 
    clf;
    if nargin < 4
        F = isosurface(map, 0.5 );     % Para hacer el código mas rápido.
        view_ori = [-148 18];
    elseif nargin < 5   
        F = isosurface(map, 0.5 );     % Para hacer el código mas rápido.        
    end
    p = patch(F);
    isonormals( map,p );
    set(p, 'FaceColor', 'black', 'EdgeColor', 'none');
    box on;
    lighting phong;
    alpha(alpha_val);
    view(view_ori); 
    daspect([1 1 1]);
end
