% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

clear; clc; close all;

% Part 1
s = tf('s');
tfs = [1/(s*(s+1)) 1/(s*(s+10));
       1/(s*(s+10)) 1/(s*(s+1))];
   
sys11 = canon(tfs(1, 1), 'companion');
sys12 = canon(tfs(1, 2), 'companion');
sys21 = canon(tfs(2, 1), 'companion');
sys22 = canon(tfs(2, 2), 'companion');

a0 = zeros(size(sys11.a));
A1 = [sys11.a                zeros(size(sys11.a))    zeros(size(sys11.a))    zeros(size(sys11.a));
     zeros(size(sys12.a))   sys12.a                 zeros(size(sys12.a))    zeros(size(sys12.a));
     zeros(size(sys21.a))   zeros(size(sys21.a))    sys21.a                 zeros(size(sys21.a));
     zeros(size(sys22.a))   zeros(size(sys22.a))    zeros(size(sys22.a))    sys22.a];

B1 = [sys11.b                zeros(size(sys11.b));
     sys12.b                zeros(size(sys12.b));
     zeros(size(sys21.b))   sys21.b;
     zeros(size(sys22.b))   sys22.b];

C1 = [sys11.c                zeros(size(sys21.c))    sys12.c                 zeros(size(sys22.c));
     zeros(size(sys11.c))   sys21.c                 zeros(size(sys12.c))    sys22.c];

D1 = [sys11.d sys12.d;
     sys21.d sys22.d];
 
[a1, b1, c1, d1] = custom_minreal(A1, B1, C1, D1);

% Part 2
A2 = [-0.5   -1  -1.5    -2;
     0      1   -2      -2;
     -0.5   -1  0.5     2;
     0.5    1   0.5     -1];
B2 = [0.5;
     1;
     -0.5;
     0.5];
C2 = [1 3 0 -1];
D2 = 0;

[a2, b2, c2, d2] = custom_minreal(A2, B2, C2, D2);

sys = ss(a2, b2, c2, d2);

