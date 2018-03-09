% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

close all;
clear;
clc;

% design a controller to place poles at -0.5, -1, -5, assuming no coupling
% look at bode plot and step response with coupling
% design the low frequency coupling matrix T

poles = [-0.5, -1, -5];
syms x;
s = tf('s');
P = [1/(s*(s+1))    1/(s*(s+10));
     1/(s*(s+10))   1/(s*(s+1))];

A = [1 1/10;
     1/10 1];
T = rref([A eye(2)]);
T = T(1:2, 3:4);

for i = 1:length(poles)
    char_eqn = (x - poles(i))^2;
    cfs = coeffs(char_eqn);
    Kd = double(cfs(2) - 1);
    Kp = double(cfs(1));
    
    C = [(Kp+Kd*s/(0.01*s+1))    0
         0                      (Kp+Kd*s/(0.01*s+1))];
    sys = feedback(P*C, eye(2));
    figure;
    subplot(1, 2, 1);
    bode(sys);
    title(sprintf('Bode plot\nKp = %0.2f, Kd = %0.2f', Kp, Kd));
    subplot(1, 2, 2);
    step(sys);
    title(sprintf('Step resp\nKp = %0.2f, Kd = %0.2f', Kp, Kd));
    
    Cprime = T*C;
    sys_prime = feedback(P*Cprime, eye(2));
    figure;
    subplot(1, 2, 1);
    bode(sys_prime);
    title(sprintf('Bode plot (Cprime)\nKp = %0.2f, Kd = %0.2f', Kp, Kd));
    subplot(1, 2, 2);
    step(sys_prime);
    title(sprintf('Step resp (Cprime)\nKp = %0.2f, Kd = %0.2f', Kp, Kd));
end