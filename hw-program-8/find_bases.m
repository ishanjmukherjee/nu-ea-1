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
