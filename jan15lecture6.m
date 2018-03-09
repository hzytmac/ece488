Tomas Gareau - 20517229
Ziyang Huang - 20484627
Jeremy Wong - 20518722

% no solution

A = [1 2 1/2;
     2 4 1];
y = [1; 3];


% infinite solutions

A = [2 7 4;
     4 1 4];
y = [1; 2];

% one solution
% impossible to get a unique solution because for a unique solution you
% require the number of variables to equal the rank of your matrix. we have
% three variables, but only need to set two outputs in y, so we'll always
% have a free variable we can set to whatever we want. (e.g. we can set a
% lin. dependent column to any value, cancel it out with the lin.
% independent columns, and still get an answer for Ax=y). 