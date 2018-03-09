close all;
clear;
clc;

s=tf('s');
A=[-0.5 -1 -1.5 -2;
    0 1 -2 -2;
    -0.5 -1 0.5 2;
    0.5 1 0.5 -1;];
B=[0.5;1;-0.5;0.5];
C=[1 3 0 -1];
D=0;

%% controllable
Q=ctrb(A,B);
a=rank(Q);
b=size(A,1);

if a ~= b
    disp('not controllable');
else
    disp('controllable');
end

T=[Q(:,1:a) rand(b,b-a)];


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

T=[Q(1:a,:)];