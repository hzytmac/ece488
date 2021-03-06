syms tao th thd thdd;
syms x1 x2 u y;

eq1=thd;
eq2=tao-sin(th)-thd;
motion_eq=[eq1,eq2];
measure_eq=[th,thd];

%linearization
A=jacobian(motion_eq,[th thd]);
B=jacobian(motion_eq,tao);
C=jacobian(measure_eq,[th thd]);
D=jacobian(measure_eq,tao);

A=subs(A,[th thd tao],[0 0 0]);
B=subs(B,[th thd tao],[0 0 0]);
C=subs(C,[th thd tao],[0 0 0]);
D=subs(D,[th thd tao],[0 0 0]);

A=double(A);
B=double(B);
C=double(C);
D=double(D);

sys=ss(A,B,C,D);
step(sys) 
