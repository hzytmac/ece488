% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

close all;
clear;
clc;

Kp = 1;
s = tf('s');

% Step response for b = 0.1, 0.5, and 1
[C01, P01] = lecture13func(0.1, Kp);
[C05, P05] = lecture13func(0.5, Kp);
[C1, P1] = lecture13func(1, Kp);

sys01 = feedback(P01*C01, 1);
sys05 = feedback(P05*C05, 1);
sys1 = feedback(P1*C1, 1);

figure;
step(sys01);
figure;
step(sys05);
figure;
step(sys1);

% (For kicks): do a Youla parameterization
