close all;
clear;
clc;
s=tf('s');

A=[ 0 1 0 0 0 0 0 0;
    0 -1 0 0 0 0 0 0;
    0 0 0 1 0 0 0 0;
    0 0 0 -10 0 0 0 0;
    0 0 0 0 0 1 0 0;
    0 0 0 0 0 -10 0 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 -1];

B=[ 0 0;
    1 0;
    0 0;
    1 0;
    0 0;
    0 1;
    0 0;
    0 1];

C= [1 0 0 0 1 0 0 0;
    0 0 1 0 0 0 1 0];

D=[0 0;
    0 0];

%% controllable
Q=ctrb(A,B);
a=rank(Q);
b=size(A,1);

if a ~= b
    disp('not controllable');
else
    disp('controllable');
end

T=[Q(:,1:6) rand(b,b-a)];

Abar=inv(T)*A*T;
Bbar=inv(T)*B;
Cbar=C*T;

%% observable
Abar11=Abar(1:a,1:a);
Bbar1=Bbar(1:a,:);
Cbar1=Cbar(:,1:a);

R=obsv(Abar11,Cbar1);
a=rank(R);
b=size(Abar11,1);

if a ~= b
    disp('not observable');
else
    disp('observable');
end