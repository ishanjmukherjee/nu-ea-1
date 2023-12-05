function [cs, ns, coords_cs, coords_ns] = find_bases(A, b)
%find_bases Finds basis vectors for the column space and null space of a
%given matrix.
% [cs, ns, coords_cs, coords_ns] = find_bases(A, b)
%   cs          : column space of A
%   ns          : null space of A
%   coords_cs   : coordinates of b if it's in the column space of A (or an
%                 empty matrix otherwise)
%   coords_ns   : coordinates of b if it's in the null space of A (or an
%                 empty matrix otherwise)
%   A           : input matrix
%   b           : input vector (optional, empty by default)
%
% Homework Program 8
%
% Name:     Mukherjee, Ishan
% Section:  22
% Date:     11/16/2023
% Grade:    100%

% Argument validators
arguments
    A (:,:) {mustBeNonempty}
    b (:,1) = []
end

% Initializing reduced form of A and its pivot columns
[A_red, piv_cols] = rref(A);

% Setting variables for height and width of A
[m, n] = size(A);

% Using pivot columns to identify and initialize non-pivot columns of A
non_piv_cols = setdiff(1:n, piv_cols);

% Storing column space of A (corresponding to pivot columns in reduced A)
% in cs
cs = A(:,piv_cols);

% Storing null space of A in ns
ns = zeros(n, length(non_piv_cols));
ns(non_piv_cols,:) = eye(length(non_piv_cols));
ns(piv_cols, :) = -A_red(1:length(piv_cols), non_piv_cols);

% Printing dimensions of column space and null space
fprintf("The column space is a %i dimensional subspace of R^%i\n", size(cs,2), m);
fprintf("The null space is a %i dimensional subspace of R^%i\n\n", size(ns,2), n);

if isempty(b)
    % Setting coordinates to be empty matrices if b isn't defined by user
    coords_cs = [];
    coords_ns = [];
else
    coords_cs = [];
    coords_ns = [];

    if length(b) ~= m && length(b) ~= n
        fprintf("b is R^%i and is in neither nul A nor col A\n", length(b));
    end

    if length(b) == m 
        if size(cs,2) ~= 0
            [~, pivs] = rref([A b]);
            if pivs(end) ~= n+1 && ~isempty(pivs) % Checking if b is in col A
                coords_cs = cs \ b;
                fprintf("b is in R^%i and is in the column space of A, and its coordinates are:\n", m);
                fprintf("%f\n", coords_cs);
            else
                fprintf("b is in R^%i but is not in the column space of A\n", m);
            end
        else
            fprintf("b is in R^%i but is not in the column space of A\n", m);
        end
    end
    
    if length(b) == n
        if A * b == zeros(m,1) % Checking if b is in nul A
            coords_ns = ns \ b;
            fprintf("b is in R^%i and is in the null space of A, and its coordinates are:\n", n);
            fprintf("%f\n", coords_ns);
        else
            fprintf("b is in R^%i but is not in the null space of A\n", n);
        end
    end
end

% Displaying cs, ns, coords_cs and coords_ns
cs
ns
coords_cs
coords_ns

% 1. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2];
% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% 
% b is in R^3 and is in the column space of A, and its coordinates are:
% 121.000000
% -30.000000
% 20.000000
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coords_cs =
% 
%    121
%    -30
%     20
% 
% 
% coords_ns =
% 
%      []

% 2. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2;3];
% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% 
% b is R^4 and is in neither nul A nor col A
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coords_cs =
% 
%      []
% 
% 
% coords_ns =
% 
%      []

% 3. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2;3;-1];
% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% 
% b is in R^5 and is in the null space of A, and its coordinates are:
% 2.000000
% -1.000000
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coords_cs =
% 
%      []
% 
% 
% coords_ns =
% 
%     2.0000
%    -1.0000

% 4. A = [1 2 -4 -3 0;-2 -3 5 8 8;2 2 -2 -9 -13]; b = [1;8;2;3;-2];
% The column space is a 3 dimensional subspace of R^3
% The null space is a 2 dimensional subspace of R^5
% 
% b is in R^5 but is not in the null space of A
% 
% cs =
% 
%      1     2    -3
%     -2    -3     8
%      2     2    -9
% 
% 
% ns =
% 
%     -2    -5
%      3    -2
%      1     0
%      0    -3
%      0     1
% 
% 
% coords_cs =
% 
%      []
% 
% 
% coords_ns =
% 
%      []

% 5. A = [1 0 2;0 1 3;0 0 0]; b = [1;2;3];
% The column space is a 2 dimensional subspace of R^3
% The null space is a 1 dimensional subspace of R^3
% 
% b is in R^3 but is not in the column space of A
% b is in R^3 but is not in the null space of A
% 
% cs =
% 
%      1     0
%      0     1
%      0     0
% 
% 
% ns =
% 
%     -2
%     -3
%      1
% 
% 
% coords_cs =
% 
%      []
% 
% 
% coords_ns =
% 
%      []

% 6. A = [2 -2;2 -2];b = [1;1];
% The column space is a 1 dimensional subspace of R^2
% The null space is a 1 dimensional subspace of R^2
% 
% b is in R^2 and is in the column space of A, and its coordinates are:
% 0.500000
% b is in R^2 and is in the null space of A, and its coordinates are:
% 1.000000
% 
% cs =
% 
%      2
%      2
% 
% 
% ns =
% 
%      1
%      1
% 
% 
% coords_cs =
% 
%     0.5000
% 
% 
% coords_ns =
% 
%     1.0000

% 7. A = zeros(3);b = zeros(3,1);
% The column space is a 0 dimensional subspace of R^3
% The null space is a 3 dimensional subspace of R^3
% 
% b is in R^3 but is not in the column space of A
% b is in R^3 and is in the null space of A, and its coordinates are:
% 0.000000
% 0.000000
% 0.000000
% 
% cs =
% 
%   3×0 empty double matrix
% 
% 
% ns =
% 
%      1     0     0
%      0     1     0
%      0     0     1
% 
% 
% coords_cs =
% 
%      []
% 
% 
% coords_ns =
% 
%      0
%      0
%      0

% 8. A = eye(3);b = zeros(3,1);
% The column space is a 3 dimensional subspace of R^3
% The null space is a 0 dimensional subspace of R^3
% 
% b is in R^3 and is in the column space of A, and its coordinates are:
% 0.000000
% 0.000000
% 0.000000
% b is in R^3 and is in the null space of A, and its coordinates are:
% 
% 
% cs =
% 
%      1     0     0
%      0     1     0
%      0     0     1
% 
% 
% ns =
% 
%   3×0 empty double matrix
% 
% 
% coords_cs =
% 
%      0
%      0
%      0
% 
% 
% coords_ns =
% 
%   0×1 empty double column vector

% 9. A = [1 0 0 1;0 1 0 2;0 0 1 3;0 0 -1/3 -1]; b = [1;2;3;-1];
% The column space is a 3 dimensional subspace of R^4
% The null space is a 1 dimensional subspace of R^4
% 
% b is in R^4 and is in the column space of A, and its coordinates are:
% 1.000000
% 2.000000
% 3.000000
% b is in R^4 and is in the null space of A, and its coordinates are:
% -1.000000
% 
% cs =
% 
%     1.0000         0         0
%          0    1.0000         0
%          0         0    1.0000
%          0         0   -0.3333
% 
% 
% ns =
% 
%     -1
%     -2
%     -3
%      1
% 
% 
% coords_cs =
% 
%     1.0000
%     2.0000
%     3.0000
% 
% 
% coords_ns =
% 
%    -1.0000

% 10. A = [1 0 0 1;0 1 0 2;0 0 1 3;0 0 -1/3 -1];
% The column space is a 3 dimensional subspace of R^4
% The null space is a 1 dimensional subspace of R^4
% 
% b is in R^4 and is in the column space of A, and its coordinates are:
% 1.000000
% 2.000000
% 3.000000
% b is in R^4 and is in the null space of A, and its coordinates are:
% -1.000000
% 
% cs =
% 
%     1.0000         0         0
%          0    1.0000         0
%          0         0    1.0000
%          0         0   -0.3333
% 
% 
% ns =
% 
%     -1
%     -2
%     -3
%      1
% 
% 
% coords_cs =
% 
%     1.0000
%     2.0000
%     3.0000
% 
% 
% coords_ns =
% 
%    -1.0000
