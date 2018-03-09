% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484629

close all;
clear;
clc;

x = @(t) (1/4)*exp(-2*t) * (-2*t + 3*exp(2*t) - 3);

A = [-2  1; 0 -2];
B = [0; 1];
C = [1 1];
D = 0;

eqnfun = @(t, x) A*x + B;
x0 = [0;0];
yf = 6;
dt = 0.0001;

tstart = tic;
[t, y] = runge_kutta(eqnfun, x0, 0, yf, dt);
disp(sprintf("That just took: %f", toc(tstart)));

t_ = 0:0.001:yf;
vals = zeros(size(t_));
for i = 1:length(t_)
    vals(i) = x(t_(i));
end

figure;
plot(t_, vals);
hold on;
plot(t, y(1, :) + y(2, :));
legend('Analytical', 'Runge-Kutta');