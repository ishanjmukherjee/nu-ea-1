
clear
clc

%Matrix input
A = input('Enter a matrix:\n');    

%The dimensions
[m,n] = size(A);                   

%If there are more cols than rows, the columns cannot be linearly
%independent.
if m<n
    fprintf('More columns than rows: The columns cannot be linearly independent.\n')
%If the matrix is square or has more rows than cols, we should check if
%there is a pivot at each column.
else
    [R,piv] = rref(A);
    if length(piv) == n
        fprintf('The columns are linearly independent.')
    else
        fprintf('The columns are not linearly independent.')
    end
end