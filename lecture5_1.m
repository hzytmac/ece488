close all;
clear;
clc;

syms th thd thdd T;
syms x1 x2 u y;

%% Linear
eqn=thdd+thd+sin(th)==T;
eqn=subs(eqn,[th,thd,T], [x1,x2, u]);
x1_0=0;
x2_0=0;
y=x1;
f1=x2;
f2=solve(eqn,thdd);

A=jacobian([f1, f2],[x1,x2]);
B=jacobian([f1, f2],[u]);
C=jacobian([y],[x1,x2]);
D=jacobian([y],[u]);

A=subs(A, [x1,x2, u],[0,0, 0]);
B=subs(B, [x1,x2, u],[0,0, 0]);
C=subs(C, [x1,x2, u],[0,0, 0]);
D=subs(D, [x1,x2, u],[0,0, 0]);

[t,x]=ode45(@(t,x)g(t,x, subs(u,u,0.01), A, B),[0 100],[x1_0 x2_0]');
figure()
plot(t,x(:,1));
title('Linear');

%% Non linear
[t,x]=ode45(@(t,x)f(t,x, subs(u,u,0.01)),[0 100],[x1_0 x2_0]');
figure()
plot(t,x(:,1));
title('Non-linear');

%% functions
function dxdot=g(t, x, u, A, B)
    A=double(A);
    B=double(B);
    u=double(u);
    dxdot=A*x+B*u;
end

function xdot=f(t, x, u)
    xdot(1,1)=x(2); 
    xdot(2,1)=u-x(2)-sin(x(1));
end