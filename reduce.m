% Homework Program 5
%
% Name:     Mukherjee, Ishan
% Section:  22
% Date:     10/27/2023

function [M, pivots] = reduce(M, verbose)
%reduce Returns reduced echelon form of given matrix and array of pivot
%positions.
% [M, pivots] = reduce(M, verbose) returns the reduced echelon form of the
% input matrix as the first output and a row vector containing the numbers
% of the pivot columns.

% Defaulting verbose to true if unspecified.
if ~exist('verbose', 'var') || isempty(verbose)
    verbose = true;
end

% Initializing the pivots array and columns to iterate through.
pivots = [];
col = 0;

for row = 1:size(M, 1)
    [x, pos] = max(abs(M(row:end, col+1:end)), [], 1);
    loc = find(x>0, 1);

    if ~isempty(pos(loc)) % If x above is all zeros, find() will return an
        % empty array to loc, causing pos(loc) to be an
        % empty array as well. Although exchange() would
        % still work with [] as one of the row indices,
        % the output text would be "Exchanging rows
        % <number> and .", which is ugly.
        M = exchange(M, row, row + pos(loc) - 1, verbose);
    end

    col = col + loc;
    pivots = [pivots col];

    for ii = (row + 1):size(M,1)
        r = -M(ii, col)/M(row, col);

        if r ~= 0 % Avoiding wasted computations
            M = add(M, r, row, ii, verbose);
        end
    end

    for row = length(pivots):-1:1
        r = 1/M(row,pivots(row));
        M = mult(M, r, row, verbose);
        for other_row = row-1:-1:1
            r = -M(other_row, pivots(row));
            M = add(M, r, row, other_row, verbose);
        end
    end
end
end

function M = exchange(M, row1, row2, verbose)
%exchange Exchanges two rows of a given matrix.
% M = exchange(M, row1, row2, verbose) returns a matrix identical to M
% except with row1-th row swapped with row2-th row, and prints what the
% function is doing if verbose is true (defaults to true if unspecified).

M_rows = size(M,1);

if row1 ~= round(row1) | row2 ~= round(row2) | row1 < 1 | row2 < 1 | row1 > M_rows | row2 > M_rows
    error("2nd & 3rd args must be integers between (& including) 1 and # of rows in the 1st arg.");
end

% Swapping specified rows.
M([row1 row2], :) = M([row2 row1], :);

if verbose
    fprintf("Exchanging rows %i and %i.\n", row1, row2);
end

end

function M = add(M, r, row1, row2, verbose)
%add Adds a coefficient times a row to another row of a given matrix.
% M  = add(M, r, row1, row2, verbose) returns a matrix identical to input M
% except with r times each element of row1-th row added to each corresponding
% element of row2-th row, and prints what the function is doing if verbose
% is true (defaults to true if unspecified).


M_rows = size(M,1);

if row1 ~= round(row1) || row2 ~= round(row2) || row1 < 1 || row2 < 1 || row1 > M_rows || row2 > M_rows
    error("2nd & 3rd args must be integers between (& including) 1 and # of rows in the 1st arg.");
end

% Adding r times specified row to the other row.
M(row2, :) = M(row2, :) + M(row1, :) .* r;

if verbose
    fprintf("Adding %f * row %i to row %i.\n", r, row1, row2);
end

end

function M = mult(M, d, row, verbose)
%mult Multiply each element in a given row of a matrix by a given number.
% M = mult(M, d, row, verbose) multiplies each element of the row-th row of
% M by d, and prints what the function is doing if verbose is true
% (defaults to true if unspecified).

if d == 0
    error("2nd arg must be nonzero.");
end

if row ~= round(row) || row < 1 || row > size(M, 1)
    error("3rd arg must be an integer between (& including) 1 and # of rows in the 1st arg.")
end

% Multiplying specified row by d
M(row, :) = M(row,:) .* d;

if verbose
    fprintf("Multiplying row %i by %f.\n", row, d);
end

end

% Step 4: A = randi([-5 5], 4, 10); [R, piv] = reduce(A)
% Exchanging rows 1 and 1.
% Adding -0.600000 * row 1 to row 2.
% Adding -0.400000 * row 1 to row 3.
% Adding 0.800000 * row 1 to row 4.
% Multiplying row 1 by -0.200000.
% Exchanging rows 2 and 2.
% Adding -1.000000 * row 2 to row 3.
% Adding -1.000000 * row 2 to row 4.
% Multiplying row 2 by -0.500000.
% Adding -1.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Exchanging rows 3 and 4.
% Adding 0.750000 * row 3 to row 4.
% Multiplying row 3 by 0.312500.
% Adding 0.100000 * row 3 to row 2.
% Adding 0.500000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Exchanging rows 4 and 4.
% Multiplying row 4 by -0.108108.
% Adding 1.187500 * row 4 to row 3.
% Adding 2.218750 * row 4 to row 2.
% Adding -1.906250 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
%
% R =
%
%   Columns 1 through 6
%
%     1.0000         0         0         0    1.2264    0.6520
%          0    1.0000         0         0   -0.7061   -1.4966
%          0         0    1.0000         0   -0.2230   -2.2095
%          0         0         0    1.0000   -0.1351    1.2973
%
%   Columns 7 through 10
%
%    -0.3716    1.1892   -0.6486    0.3311
%     0.5473   -1.3514   -0.0811   -0.6149
%     0.0676   -0.2162   -0.9730    1.1216
%     0.1622    0.0811    0.8649   -0.1081
%
%
% piv =
%
%      1     2     3     4

% Step 4: A = randi([-5 5], 10, 4); [R, piv] = reduce(A)
% Exchanging rows 1 and 5.
% Adding 0.200000 * row 1 to row 2.
% Adding 0.600000 * row 1 to row 3.
% Adding -0.200000 * row 1 to row 4.
% Adding -0.800000 * row 1 to row 5.
% Adding -0.600000 * row 1 to row 6.
% Adding -0.800000 * row 1 to row 7.
% Adding -0.400000 * row 1 to row 8.
% Adding -0.200000 * row 1 to row 9.
% Multiplying row 1 by -0.200000.
% Exchanging rows 2 and 4.
% Adding -0.260870 * row 2 to row 3.
% Adding -0.956522 * row 2 to row 4.
% Adding 0.347826 * row 2 to row 5.
% Adding -0.826087 * row 2 to row 6.
% Adding 1.000000 * row 2 to row 7.
% Adding -0.260870 * row 2 to row 8.
% Adding 0.521739 * row 2 to row 9.
% Adding -0.434783 * row 2 to row 10.
% Multiplying row 2 by 0.217391.
% Adding 0.400000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Exchanging rows 3 and 7.
% Adding -0.192547 * row 3 to row 4.
% Adding -0.111801 * row 3 to row 5.
% Adding 0.801242 * row 3 to row 6.
% Adding -0.130435 * row 3 to row 7.
% Adding 0.440994 * row 3 to row 8.
% Adding -0.024845 * row 3 to row 9.
% Adding -0.503106 * row 3 to row 10.
% Multiplying row 3 by -0.142857.
% Adding 0.739130 * row 3 to row 2.
% Adding 0.695652 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Exchanging rows 4 and 10.
% Adding 0.023425 * row 4 to row 5.
% Adding 0.113893 * row 4 to row 6.
% Adding -0.904685 * row 4 to row 7.
% Adding -0.273021 * row 4 to row 8.
% Adding 0.583199 * row 4 to row 9.
% Adding -0.617124 * row 4 to row 10.
% Multiplying row 4 by 0.130048.
% Adding -0.714286 * row 4 to row 3.
% Adding 0.559006 * row 4 to row 2.
% Adding -0.062112 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Multiplying row 4 by 1.000000.
% Adding -0.000000 * row 4 to row 3.
% Adding 0.000000 * row 4 to row 2.
% Adding -0.000000 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Multiplying row 4 by 1.000000.
% Adding -0.000000 * row 4 to row 3.
% Adding -0.000000 * row 4 to row 2.
% Adding -0.000000 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Multiplying row 4 by 1.000000.
% Adding -0.000000 * row 4 to row 3.
% Adding -0.000000 * row 4 to row 2.
% Adding -0.000000 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Multiplying row 4 by 1.000000.
% Adding -0.000000 * row 4 to row 3.
% Adding -0.000000 * row 4 to row 2.
% Adding -0.000000 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Multiplying row 4 by 1.000000.
% Adding -0.000000 * row 4 to row 3.
% Adding -0.000000 * row 4 to row 2.
% Adding -0.000000 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Multiplying row 4 by 1.000000.
% Adding -0.000000 * row 4 to row 3.
% Adding -0.000000 * row 4 to row 2.
% Adding -0.000000 * row 4 to row 1.
% Multiplying row 3 by 1.000000.
% Adding -0.000000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
%
% R =
%
%     1.0000         0         0         0
%          0    1.0000         0         0
%          0         0    1.0000         0
%          0         0         0    1.0000
%          0         0         0         0
%          0         0         0         0
%          0         0   -0.0000         0
%          0         0         0         0
%          0         0         0         0
%          0         0         0         0
%
%
% piv =
%
%      1     2     3     4

% Step 4: A = [1 2 0 0 0;0 0 0 2 3;0 0 2 1 3]; [R, piv] = reduce(A)
% Exchanging rows 1 and 1.
% Multiplying row 1 by 1.000000.
% Exchanging rows 2 and 3.
% Multiplying row 2 by 0.500000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
% Exchanging rows 3 and 3.
% Multiplying row 3 by 0.500000.
% Adding -0.500000 * row 3 to row 2.
% Adding -0.000000 * row 3 to row 1.
% Multiplying row 2 by 1.000000.
% Adding -0.000000 * row 2 to row 1.
% Multiplying row 1 by 1.000000.
%
% R =
%
%     1.0000    2.0000         0         0         0
%          0         0    1.0000         0    0.7500
%          0         0         0    1.0000    1.5000
%
%
% piv =
%
%      1     3     4

% Step 4: a = [1 2 4 3 5]; A = [a;a;a;a]; [R, piv] = reduce(A)
% Exchanging rows 1 and 1.
% Adding -1.000000 * row 1 to row 2.
% Adding -1.000000 * row 1 to row 3.
% Adding -1.000000 * row 1 to row 4.
% Multiplying row 1 by 1.000000.
% Multiplying row 1 by 1.000000.
% Multiplying row 1 by 1.000000.
% Multiplying row 1 by 1.000000.
%
% R =
%
%      1     2     4     3     5
%      0     0     0     0     0
%      0     0     0     0     0
%      0     0     0     0     0
%
%
% piv =
%
%      1

% Step 5: slowest line
% The slowest line is
% M = add(M, r, row, ii, verbose);
% This is chiefly because the add() function involves creating a new matrix
% using an old matrix, which is slow in MATLAB. Also, it involves
% arithmetic operations on two different rows of the matrix, making it even
% slower than lines where exchange() is called (no arithmetic operations on
% rows required) and where mult() is called (only one row needs to be
% operated upon arithmetically).

% Step 6
% Output of fprintf:
% Our code is 0.53 times faster than rref
% What the code is doing:
% Generating 1e4 n x m matrices of random numbers between 0 & 1, where
% 1 <= n, m <= 20 and n & m are randomly chosen. Then, reducing (and timing
% how long reducing takes) both matrices using rref and our reduce
% function. Then, printing the ratio of the mean of times rref takes and
% the mean of times reduce takes.