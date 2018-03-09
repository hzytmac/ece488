% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

close all; clc; clear;
A=[0 1 0 0; 0 0 1 0; -3 1 2 3; 2 1 0 0];
B=[0 0; 0 0; 1 2; 0 2];
C=[1 0 0 0; 0 0 0 1];
D=0;

% Design a state feedback and state estimator
% Simulate the combined system with v=step
% only state feedback
% combined system with x(0)=x_hat(0)
% let x(0)!=x_hat(0)

Q=ctrb(A,B);
rank(Q)
R=obsv(A,C);
rank(R)
F=place(A',C',[-10, -10.1,-10.2,-10.3])';
K=place(A,B,[-2, -2.1,-2.2,-2.3]);

A_hat=[A -B*K; F*C A-F*C-B*K];
B_hat=[B;B];
C_hat=[C -D*K];
D_hat=0;

%% only state feedback
sys=ss(A-B*K,B,C,D);
x0 = [0; 0; 0; 0];
t = 0:0.1:10;
u = ones(length(t),2);
[y,t,x] = lsim(sys, u, t, x0);
figure()
plot(t, x);
title('only state feedback');
xlabel('Time (sec)')

%% x(0)==x_hat(0)
sys=ss(A_hat,B_hat,C_hat,D_hat);
x0 = [0; 0; 0; 0; 0; 0; 0; 0];
t = 0:0.1:10;
u = ones(length(t),2);
[y,t,x] = lsim(sys, u, t, x0);

n = 4;
x_est = x(:, n+1:end);
x = x(:,1:n);

figure()
plot(t, x, '-r', t, x_est, ':b');
title('x(0)==xhat(0)');
legend('True state', 'Estimated state');
xlabel('Time (sec)')

%% x(0)!=x_hat(0)
x0 = [0; 0; 0; 0; 1; 1; 1; 1];
t = 0:0.1:10;
u = ones(length(t),2);
[y,t,x] = lsim(sys, u, t, x0);

n = 4;
x_est = x(:, n+1:end);
x = x(:,1:n);

figure()
plot(t, x, '-r', t, x_est, ':b');
title('x(0)!=xhat(0)');
legend('True state', 'Estimated state');
xlabel('Time (sec)')