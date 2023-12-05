function c = Span(b, A)
%This function determines whether a vector is in the span of the columns of
%a square matrix and gives the coefficients as the output if it is.

%Inputs:
%A: The square matrix that has the vectors as its columns.
%b: The column vector that is tested for being in the span of the vectors on the columns of A.

% Output:
% c: The coefficient vector to express b in terms of the columns of A.
% 
% If we define the columns of A as a1, a2, a3..., then b = c1*a1 + c2*a2 + c3*a3 + ... 

%Dimensions
[m, n] = size(A);  

%Augmented Matrix
aug = [A b];       

%RREF (Use "Help rref" to see how it works)
[R,piv] = rref(aug);

%After the rref form is obtained for the augmented matrix we can check 
%whether the b vector is in the span of the column vectors of A. 
%If it is, the last column of R should give the coefficients
%and the rest of the matrix should be an identity matrix. 

%First, we find the rank of A. We will use this to check for
%the span.
%Rank of a matrix is the number of pivots in that matrix.
r = rank(A);

%Checking if the system is consistent
if rank(aug) == r
        %Assigning the coefficients that correspond to the pivot variables
        %to c. The rest will be 0 since they are not used.
        c = zeros(1,n);
        c(piv) = R(piv,end)';
else
    error('b is not in the span of A')  %b is not in the span. There are no coefficients, just an error message.
end




