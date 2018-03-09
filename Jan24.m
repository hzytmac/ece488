% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

% Find any tf that satisfieds |G(jw)|<=1
% Show the small gain theorem for 3 examples of delta
% try 0.9, 0.9a/(s+a), 0.9e^(-sTd)
% Close loop and show nyquist plot for 1 and 2

close all;
clc;
clear;

s=tf('s');
G=s/(s+5);
delta1=0.9;
a=1;
delta2=0.9*a/(s+a);
T=1;
delta3=0.9*exp(-s*T);
sys1=feedback(G,delta1);
sys2=feedback(G,delta2);
sys3=feedback(G,delta3);
figure()
subplot(1,2,1);
step(sys1);
subplot(1,2,2);
nyquist(delta1*G);

figure()
subplot(1,2,1);
step(sys2);
subplot(1,2,2);
nyquist(delta2*G);

figure()
subplot(1,2,1);
step(sys3);
subplot(1,2,2);
nyquist(delta3*G);