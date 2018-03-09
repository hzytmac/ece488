%% Question
%P=1/(s(s-b)) C=(kd*s+kp)/(s+a)
%step1:b,a,kp,kd,closed loop poles at -1
%step2:look at step response for b=1,5
%step 3:youla parameterization and look at step.

close all;
clear;
clc;

kp=1;
a=4;
b=1;
kd=7;
