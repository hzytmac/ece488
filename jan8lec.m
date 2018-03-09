%s=tf('s');
%sys=10/(s*(s+2));
%nyquist1(sys)

s=tf('s');
sys=2/(s^4+3*s^3+6*s^2+s);
rlocus(sys)