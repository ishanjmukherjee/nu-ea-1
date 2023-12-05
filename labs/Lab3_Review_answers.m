

%%%%%%%% Exercise 1 %%%%%%%%%%%%%%%

A1 = [1 3 5; 20 16 12; 3 7 8];

A2 = [1:2:5; 20 16 12; 3 7 8];

A3 = [1 3 5; 20:-4:12; 3 7 8];

%%%%%%% Exercise 2 %%%%%%%%%%%%%%%%
% 2ii should be 2*ii
% Last line should be inside the loop so all entries of C will be updated

%The correct form is:

B = [];
C = [];
for ii = 1:4
    B(ii) = 2*ii;
    C(ii) = B(ii)*4;
end

%%%%%%%%% Exercise 3 %%%%%%%%%%%%%%%

% a) x is 4.

% b) To change x to 6 after the code runs, you need to change a condition
% in the first if, so the elseif statement will execute. A possible change
% is done below, changing (x>3) to (x>3).
x = 7;
if (x<3) && (x>5)
x = 4;
elseif (x>3) && (x>=7)
x = 6;
else
x = 8;
end

%%%%%%%%% Exercise 4 %%%%%%%%%%%%%%%

g1 = input('Enter the first grade score: ');
g2 = input('Enter the second grade score: ');
g3 = input('Enter the third grade score: ');

av = (g1 + g2 + g3)/3;

if av >=90
    grade = 'A';
elseif av>=80
    grade = 'B';
elseif av >=70
    grade = 'C';
elseif av >= 60
    grade = 'D';
else
    grade = 'F';
end

fprintf('The letter grade is %s.\n',grade)