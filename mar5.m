%xdot=Ax+Bu
%y=Cx

%estimator: xhatdot=(A-FC)*xhat+FCx+Bu
%regulator: u=-k1*xhat-k2*int(y-yref,dtao)

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

%% find the estimator F
s=tf('s');
sys=ss(A,B,C,D);
F=place(A',C',[-10, -10.1,-10.2,-10.3])';

%% Augmented
Aaug=[A zeros(4,2);C zeros(2,2);];
Baug=[B;zeros(2,2)];

% gain
K=place(Aaug,Baug,[-2, -2.1,-2.2,-2.3,-2.4,-2.5]);
K1=K(:,1:4);
K2=K(:,5:6);

%% system
Anew=[A -B*K1 -B*K2;
      F*C A-F*C-B*K1 -B*K2;
      C zeros(2,4) zeros(2,2);];

Bnew=[zeros(8,2);-eye(2)];

Cnew=[C zeros(2,6)];

Dnew=zeros(2,2);

sys=ss(Anew,Bnew,Cnew,Dnew);
x0 = [0; 0; 0;0;0;0;0;0;0;0];
t = 0:0.01:20;
u = ones(length(t),2)';
[y,t,x] = lsim(sys, u, t, x0);
figure()
plot(t, y);
title('simulation');
xlabel('Time (sec)')