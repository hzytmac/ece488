close all;
clear;
clc;

syms q1 q2 q1d q2d q1dd q2dd T1 T2;
syms x1 x2 x3 x4 x5 x6 u1 u2 y;

%% Constants
m1=1;
m2=1;
l1=1;
l2=1;
c1=1;
c2=1;
g=9.81;

%% Setup
eqn1=T1==((m1*l1^2)/3+(m2*l2^2)/12+m2*(l1^2+l2^2/4+l1*l2*cos(q2)))*q1dd+((m2*l2^2)/3+(m2*l1*l2)/2*cos(q2))*q2dd-m2*l1*l2*sin(q2)*q1d*q2d-(m2*l1*l2*sin(q2))/2*q2d^2+(m1*l1/2+m2*l1)*g*cos(q1)+m2*l2/2*g*cos(q1+q2)+c1*q1d;
eqn2=T2==(m2*l2^2/3+m2*l1*l2/2*cos(q2))*q1dd+m2*l2^2/3*q2dd+m2*l1*l2*sin(q2)/2*q1d^2+m2*l2/2*g*cos(q1+q2)+c2*q2d;
eqn1=subs(eqn1,[q1,q2,q1d,q2d,T1,T2], [x1,x2,x3,x4, u1,u2]);
eqn2=subs(eqn2,[q1,q2,q1d,q2d,T1,T2], [x1,x2,x3,x4, u1,u2]);

f1=x3;
f2=x4;
eqns=[eqn1,eqn2];
vars=[q1dd q2dd];
[f3, f4]=solve(eqns,vars);
x1_0=0;%-pi/2;
x2_0=0;
x3_0=0;
x4_0=0;
y=[x1; x2];
K=[-300 0 -50 0;   %Kp1, Kd1
    0 -300 0 -50]; %Kp2, Kd2

%% Input
% u=[0; 0];
x_des=[pi/2; 0; 0; 0];

%% Linearize
% A=jacobian([f1, f2, f3, f4],[x1,x2, x3, x4]);
% B=jacobian([f1, f2, f3, f4],[u1, u2]);
% C=jacobian([y],[x1,x2, x3, x4]);
% D=jacobian([y],[u1, u2]);
% 
% A=subs(A, [x1,x2,x3,x4,u1,u2],[-pi/2,0,0,0,0,0]);
% B=subs(B, [x1,x2,x3,x4,u1,u2],[-pi/2,0,0,0,0,0]);
% C=subs(C, [x1,x2,x3,x4,u1,u2],[-pi/2,0,0,0,0,0]);
% D=subs(D, [x1,x2,x3,x4,u1,u2],[-pi/2,0,0,0,0,0]);
% A=double(A);
% B=double(B);
% C=double(C);
% D=double(D);
% 
% [t,x]=ode45(@(t,x)func(t,x, u,A, B),[0 10],[0 x2_0 x3_0 x4_0]');
% figure()
% plot(t,x(:,1),t,x(:,2));
% 
% sys=ss(A,B,C,D);
% pole(sys);

f3_func=matlabFunction(f3);
f4_func=matlabFunction(f4);

%% Non linear
% f=(@(t,x, u)[x(3),x(4),double(subs(f3,[x1,x2,x3,x4, u1, u2],[x(1),x(2),x(3),x(4),u(1),u(2)])),double(subs(f4,[x1,x2,x3,x4, u1,u2],[x(1),x(2),x(3),x(4), u(1), u(2)]))]');
f=(@(t,x, u)[x(3),x(4),f3_func(u(1),u(2),x(1),x(2),x(3),x(4)),f4_func(u(1),u(2),x(1),x(2),x(3),x(4))]');
[t,x]=ode45(@(t,x)f(t,x,K*(x-x_des)),[0 5],[x1_0 x2_0 x3_0 x4_0]');
% figure()
% plot(t,x(:,1),t,x(:,2));
% legend('q1', 'q2');

visualize([m1 m2 l1 l2 c1 c2], t, x(:,1), x(:,2), '');

%% functions
function dxdot=func(t, x, u, A, B)
    u=double(u);
    dxdot=A*x+B*u;
end