function Vnew = transform_mesh(A,V,T,C)
%transform_mesh Apply a linear transformation to a triangle mesh.
% Vnew = transform_mesh(A,V,T,C)
%   Vnew    : transformed vertix matrix
%   A       : transformation matrix
%   V       : matrix containing vertices to be transformed
%   T       : triangle matrix
%   C       : colormap matrix
% In addition to returning Vnew, this function plots both the original and
% transformed objects on the same set of axes.
%
% Homework Program 7
%
% Name:     Mukherjee, Ishan
% Section:  22
% Date:     11/10/2023

arguments
    A (3 ,3) {mustBeNumeric}
    V (:, 3) {mustBeNumeric}
    T (: ,4) {mustBeNumeric, mustBeInteger, mustBeGreaterThanOrEqual (T, 1)}
    C (:, 3) {mustBeNumeric, mustBeLessThanOrEqual (C, 1), mustBeNonnegative}
end

Vnew = V * A';

% Plot the new and original meshes
trisurf(T(: ,1:3) ,Vnew (: ,1),Vnew (: ,2),Vnew (: ,3),T(: ,4));
hold on
trisurf(T(: ,1:3) ,V(: ,1),V(: ,2),V(: ,3),T(: ,4), ...
    'EdgeColor','none','FaceAlpha' ,0.2);
hold off
colormap(C);
axis equal;

A_scale = [0.67 0 0; 0 1.5 0; 0 0 1.5];
A_refl = [1 0 0; 0 -1 0; 0 0 1];
A_rot = rotation_matrix([0 1 1 (pi/4)]);
A = A_scale * A_refl * A_rot;
B = A_rot * A_scale * A_refl;

% A_scale =
% 
%     0.6700         0         0
%          0    1.5000         0
%          0         0    1.5000
% 
% A_refl =
% 
%      1     0     0
%      0    -1     0
%      0     0     1
% 
% 
% A_rot =
% 
%     0.7071   -0.5000    0.5000
%     0.5000    0.8536    0.1464
%    -0.5000    0.1464    0.8536
% 
% A =
% 
%     0.4738   -0.3350    0.3350
%    -0.7500   -1.2803   -0.2197
%    -0.7500    0.2197    1.2803
% 
% B =
% 
%     0.4738    0.7500    0.7500
%     0.3350   -1.2803    0.2197
%    -0.3350   -0.2197    1.2803
