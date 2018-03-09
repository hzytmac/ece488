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

% design a state feedback and state estimator (use place)
% simulate the combined system (v=step)
% i) only state feedback ii)the combined system with x(0)=xhat(0) iii)let
% x(0)?xhat(0)

%% controllable
Q=ctrb(A,B);
a=rank(Q);
b=size(A,1);

%% state feedback
s=tf('s');
sys=ss(A,B,C,D);
F=place(A',C',[-10, -10.1,-10.2,-10.3])';
K=place(A,B,[-2, -2.1,-2.2,-2.3]);

Abar=[A -B*K;F*C A-F*C-B*K];
Bbar=[B;B];
Cbar=[C -D*K];
Dbar=D;

%% only state feedback
sys1=ss(A-B*K,B,C,D);
x0 = [0; 0; 0; 0];
t = 0:0.01:5;
u = ones(length(t),2)';
[y,t,x] = lsim(sys1, u, t, x0);
figure()
plot(t, x);
title('only state feedback');
xlabel('Time (sec)')

%% combined state feedback and estimator
sys2=ss(Abar,Bbar,Cbar,Dbar);
x0 = [0; 0; 0; 0; 0; 0; 0; 0];
[y,t,x] =lsim(sys2,u,t,x0);
n = 4;
x_est = x(:, n+1:end);
x = x(:,1:n);

figure()
plot(t, x, '-r', t, x_est, ':b');
title('x(0)==xhat(0)');
legend('True state', 'Estimated state');
xlabel('Time (sec)')

%% x(0)!=xhat(0)
x0 = [0; 0; 0; 0; 1; 1; 1; 1];
[y,t,x] =lsim(sys2,u,t,x0);
n = 4;
x_est = x(:, n+1:end);
x = x(:,1:n);

figure()
plot(t, x, '-r', t, x_est, ':b');
title('x(0)!=xhat(0)');
legend('True state', 'Estimated state');
xlabel('Time (sec)')