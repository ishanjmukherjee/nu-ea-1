% Homework Program 4
%
% Name:     Mukherjee, Ishan
% Section:  22
% Date:     10/20/2023
% Grade:    100%

function [EscTime, EscVal, Image] = julia(c, limits, nx, ny, maxEscTime)
%julia Visualize Julia set
% Function julia visualizes Julia sets for a given parameter c in the 
% complex region defined by limits represented in ny-by-nx pixels. 
% 
% Calling sequence:
%   [EscTime, EscVal, Image] = julia(c, limits, nx, ny, MaxEscTime)
% 
% Variables:
%   c           -- scalar representing the parameter c (mandatory input)
%   limits      -- 4-element vector representing the rectangular region in the
%                  complex plane
%   nx          -- number of pixels in the x-direction
%   ny          -- number of pixels in the y-direction
%   maxEscTime  -- max iterations when calculating escape times
%   EscTime     -- ny-by-nx array of escape times for each pixel
%   EscVal      -- ny-by-nx array of escape values for each pixel
%   Image       -- array of color data for image

% Set escape radius
R = (1+sqrt(1+4*abs(c)))/2;

% Set default values in case input arguments are not entered or are empty.
if ~exist('limits', 'var') || isempty(limits)
    limits = [-R R -R R];
end
if ~exist('nx', 'var') || isempty(nx)
    nx = 1024;
end
if ~exist('ny', 'var') || isempty(ny)
    ny = 1024;
end
if ~exist('maxEscTime', 'var') || isempty(maxEscTime)
    maxEscTime = 1000;
end

% Create an ny-by-nx array Z containing all z_0 values in the desired
% rectangular region.
x = linspace(limits(1), limits(2), nx);
y = linspace(limits(4), limits(3), ny);
[X, Y] = meshgrid(x,y);
Z = X + 1i*Y;

% Initialize EscTime as an array of default values Inf
EscTime = Inf(ny,nx);

% Initialize EscValue as an array of default values NaN
EscVal = NaN(ny,nx);

% Initialize done as an array of initial values false
done = false(ny,nx);

% Loop until maxEscTime is reached.
for k = 1:maxEscTime
    % Replace each element of Z with its square plus the parameter c.
    Z = Z.^2 + c;

    % new's elements are true if abs(Z) > R and corresponding element of
    % done is false.
    new = abs(Z) > R & ~done;
    
    % Set EscTime values indexed by new to k, and EscVal times indexed by
    % new to those values of abs(Z) indexed by new
    EscTime(new) = k;
    EscVal(new) = abs(Z(new));
    
    % Set each element of done to true if it was always true or if new's
    % corresponding element is true.
    done = done | new;
    
    % Break if all elements of done are true
    if done
        break;
    end
end

% Plot result as a color image
Image = showJulia(EscTime, EscVal, limits);

end
