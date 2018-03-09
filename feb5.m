close all;
clear;
clc;

s=tf('s');
Kd=-6;
Kp=4;
P=1/(s*(s+10));
C=Kd*s+Kp;
sys=feedback(P*C,1);
step(sys);

figure;
hold on;
for Td=0.1:0.1:1
delay=(1-Td*s/2)/(1+Td*s/2);
sys_delay=feedback(P*C*delay,1);
step(sys_delay);
end