function M = rotation_matrix(R)
%ROTATION_MATRIX Convert rotation from axis-angle to matrix representation.
%  M = rotation_matrix(R) returns a matrix representation of rotation 
%  defined by the axis-angle rotation vector R.
%
%  The rotation vector R is a row vector of 4 elements,
%  where the first three elements specify the rotation axis
%  and the last element defines the angle.
%
%  This is a replacement for the vrrotvec2mat function which is now
%  inconveniently part of a toolbox.

arguments
    R (1,4) {mustBeNumeric,mustHaveNonzeroAxis};
end

u = R(1:3)'/norm(R(1:3));
theta = R(4);

% cross-product matrix
C = [0 -u(3) u(2); u(3) 0 -u(1); -u(2) u(1) 0];
M = cos(theta)*eye(3) + sin(theta)*C + (1-cos(theta))*u*u';

end

function mustHaveNonzeroAxis(R)
    if norm(R(1:3)) == 0
        eidType = 'mustHaveNonzeroAxis:notNonzeroAxis';
        msgType = 'The rotation axis cannot be the zero vector.';
        throwAsCaller(MException(eidType,msgType))
    end
end