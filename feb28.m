% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

close all;
clear;
clc;

A=[0 1 0 0;
   0 0 1 0;
   -3 1 2 3;
   2 1 0 0];

B=[0 0;
    0 0;
    1 2;
    0 2];

C=[1 0 0 0;
    0 0 0 1];
D=[0 0;
    0 0;];

%% controllable
Q=ctrb(A,B);
a=rank(Q);
b=size(A,1);

%% Augmented
Aaug=[A zeros(4,2);C zeros(2,2);];
Baug=[B;zeros(2,2)];

% gain
K=place(Aaug,Baug,[-2, -2.1,-2.2,-2.3,-2.4,-2.5]);
K1=K(:,1:4);
K2=K(:,5:6);

%% state space when [x;e] edot=y-yref
s=tf('s');
Anew=[A-B*K1 -B*K2;C zeros(2,2)];
Bnew=[zeros(4,2);-eye(2)];
Cnew=[C zeros(2,2)];
Dnew=D;

sys=ss(Anew,Bnew,Cnew,Dnew);
x0 = [0; 0; 0; 0;0;0];
t = 0:0.01:5;
u = ones(length(t),2)';
[y,t,x] = lsim(sys, u, t, x0);
figure()
plot(t, y);
title('simulation');
xlabel('Time (sec)')
