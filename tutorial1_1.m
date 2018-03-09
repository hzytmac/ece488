Kp=10;
Ki=0;
Kd=2;

s=tf('s');
P=10/(s^2+10*s);

C=pid(Kp,Ki,Kd);
sys=feedback(P*C,1);

step(sys);
bode(sys);

%critical damping zeta=1    
%under damping zeta<1