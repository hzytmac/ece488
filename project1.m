clear all;
clear;
clc

syms q1 q2 q1d q2d q1dd q2dd tao1 tao2
syms x1 x2 x3 x4 x5 x6 u y

%% constant
m1=1;
m2=1;
l1=1;
l2=1;
g=9.8;
c1=1;
c2=1;

%% equation setup
%eqn1=tao1==(m1*l1^2/3+m2*l2^2/12+m2*(l1^2+l2^2/4+l1*l2*cos(q2)))*q1dd+(m2*l2^2/3+m2*l1*l2/2*cos(q2))*q2dd-m2*l1*l2*sin(q2)*q1d*q2d-m2*l1*l2*sin(q2)/2*q2d^2+(m1*l1/2+m2*l1)*g*cos(q1)+m2*l2/2*g*cos(q1+q2)+c1*q1d;
%eqn2=tao2==(m2*l2^2/3+m2*l1*l2/2*cos(q2))*q1dd+m2*l2^2/3*q2dd+m2*l1*l2*sin(q2)/2*q1d^2+m2*l2/2*g*cos(q1+q2)+c2*q2;

eq1=tao1==(m1*l1^2/3+m2*l2^2/12+m2*(l1^2+l2^2/4+l1*l2*cos(q2)))*q1dd+(m2*l2^2/3+m2*l1*l2/2*cos(q2))*q2dd-m2*l1*l2*sin(q2)*q1d*q2d-m2*l1*l2*sin(q2)/2*q2d^2+(m1*l1/2+m2*l1)*g*cos(q1)+m2*l2/2*g*cos(q1+q2)+c1*q1d;
eq2=tao2==(m2*l2^2/3+m2*l1*l2/2*cos(q2))*q1dd+m2*l2^2/3*q2dd+m2*l1*l2*sin(q2)/2*q1d^2+m2*l2/2*g*cos(q1+q2)+c2*q2;

qdd=solve(eq1,eq2,q1dd,q2dd);
Q1dd=qdd.q1dd;
Q2dd=qdd.q2dd;

motion_eq=[q1d q2d Q1dd Q2dd];
measured_eq=[q1 q2 q1d q2d];

A=jacobian(motion_eq,[q1 q2 q1d q2d]);
B=jacobian(motion_eq,[tao1 tao2]);
C=jacobian(measured_eq,[q1 q2 q1d q2d]);
D=jacobian(measured_eq,[tao1 tao2]);

A=subs(A,[q1 q2 q1d q2d tao1 tao2],[0 0 0 0 0 0]);
B=subs(B,[q1 q2 q1d q2d tao1 tao2],[0 0 0 0 0 0]);
C=subs(C,[q1 q2 q1d q2d tao1 tao2],[0 0 0 0 0 0]);
D=subs(D,[q1 q2 q1d q2d tao1 tao2],[0 0 0 0 0 0]);

A=double(A);
B=double(B);
C=double(C);
D=double(D);

Q=ctrb(A,B);
a=rank(Q);
b=size(A,1);

%% state feedback
s=tf('s');
sys=ss(A,B,C,D);
F=place(A',C',[-10, -10.1,-10.2,-10.3])';
K=place(A,B,[-2, -2.1,-2.2,-2.3]);
