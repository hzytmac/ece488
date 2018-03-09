%design the state feedback

close all;
clear;
clc;

A=[0 -2 -1;1 0 -1;0 1 -1];
B=[1;0;0];
C=[1 0 0];
D=0;

%% controllable
Q=ctrb(A,B);
a=rank(Q);
b=size(A,1);

%% step 1
s=tf('s')

[num,den]=ss2tf(A,B,C,D);

%% step 2
Abar=[0 1 0;
      0 0 1;
      fliplr(-den(2:end))];
Bbar=[0;0;1];

%% step 3
Q=ctrb(A,B);
Qbar=ctrb(Abar,Bbar);
P=Qbar/Q;

%% step 4 find Kbar
Kbar=acker(Abar,Bbar,[-2 -2 -2]);

%% step 5 find K
K=Kbar*P;

%% step 6 step response
sys=ss(A-B*K,B,C,D);
step(sys);