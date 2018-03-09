s=tf('s');

G11=10/(s(s+1));
G12=1/(s(s+100));
G21=G12;
G22=G11;

Kp=10;
Ki=0;
Kd=2;


P=10/(s^2+10*s);
C=pid(Kp,Ki,Kd);
sys=feedback(P*C,1);

step(sys);
bode(sys);