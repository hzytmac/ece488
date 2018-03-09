% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

close all;
clear;
clc;

A = [0 0 -1;
    -1 0 0;
    3 -1 -3];
B = [0;0;1];
C = [0 1 0];
D = 0;

R = obsv(A, C);
if rank(R) ~= size(A, 1)
    disp('Not observable');
    return;
end

[num, den] = ss2tf(A, B, C, D);
Abar = [0 0;
        1 0;
        0 1];
Abar = [Abar -fliplr(den(2:end))'];
Bbar = fliplr(num(2:end))';
Cbar = zeros(1, size(Abar, 1) - 1);
Cbar = [Cbar 1];
Dbar = 0;

evs = [-8 -12 -6];
Fbar = -fliplr(den(2:end))' - evs';
Rbar = obsv(Abar, Cbar);

T = inv(Rbar)*R;

F = inv(T)*Fbar;

At = [A         zeros(size(A))
      F*C       A-F*C];
Bt = [B;
      B];
Ct = [C     zeros(size(C))];
Dt = 0;

sys = ss(At, Bt, Ct, Dt);
x0 = [0; 0; 0; 1; 1; 1];
t = 0:0.1:10;
u = ones(size(t));
[y,t,x] = lsim(sys, u, t, x0);

n = 3;
x_est = x(:, n+1:end);
x = x(:,1:n);

plot(t, x, '-r', t, x_est, ':b');
legend('True state', 'Estimated state');
xlabel('Time (sec)')