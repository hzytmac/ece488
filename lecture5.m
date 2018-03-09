close all;
clear;
clc;

syms th thd thdd T;

eqn = thdd + thd + sin(th) == T;
eq1 = thd;
eq2 = solve(eqn, thdd);
mot_eqns = [eq1; eq2];
meas_eqns = [th; thd];

A = double(subs(jacobian(mot_eqns, [th thd]), [th thd T], [0 0 0]));
B = double(subs(jacobian(mot_eqns, T), [th thd T], [0 0 0]));
C = double(subs(jacobian(meas_eqns, [th thd]), [th thd T], [0 0 0]));
D = double(subs(jacobian(meas_eqns, T), [th thd T], [0 0 0]));

sys = ss(A, B, C, D);
step(sys);

nl_sys = @(t, x, u) [x(2); u - sin(x(1)) - x(2)];

[t, x] = ode45(@(t, x) nl_sys(t, x, 1), [0 14], [0 0]);
figure;
subplot(2, 1, 1);
plot(t, x(:, 1));
subplot(2, 1, 2);
plot(t, x(:, 2));