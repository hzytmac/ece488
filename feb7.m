close all;
clear;
clc;

%1.design controllor to place poles at -.5,-1,-5. assuming no coupling
%2.bode,step response
%3.design the low frequency coupling matrix T, C'=TC
%4.redo step 2

zeta=1;
poles=[-0.5,-1,-5];

%Kp=0.25;
%Kd=0;
%Kp=1;
%Kd=1;
%Kp=25;
%Kd=9;

Kp=[0.25,1,25];
Kd=[0,1,9];

figure()
for i=1:1:3 
s=tf('s');
P=[1/(s*(s+1)) 1/(s*(s+10));1/(s*(s+10)) 1/(s*(s+1))];
C=[Kp(i)+Kd(i)*s/(0.01*s+1) 0;0 Kp(i)+Kd(i)*s/(0.01*s+1)];
sys=feedback(P*C,eye(2));
step(sys);
end

figure()
for i=1:1:3 
s=tf('s');
P=[1/(s*(s+1)) 1/(s*(s+10));1/(s*(s+10)) 1/(s*(s+1))];
C=[Kp(i)+Kd(i)*s/(0.01*s+1) 0;0 Kp(i)+Kd(i)*s/(0.01*s+1)];
sys=feedback(P*C,eye(2));
bode(sys);
end

%[1 1/10;1/10 1|1 0;0 1] to [1 0;0 1|T] find T; C'=TC sys=PC'