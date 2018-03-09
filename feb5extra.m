close all;
clear;
clc;

Kp = 1;
s = tf('s');

% Step response for b = 0.1, 0.5, and 1
[C01, P01] = lecture13func(0.1, Kp);


sys01 = feedback(P01*C01, 1);

figure;
step(sys01);
figure;
hold on;
for Td=0.1:0.1:0.5
delay=(1-Td*s/2)/(1+Td*s/2);
sys_delay=feedback(P01*C01*delay,1);
step(sys_delay);
end