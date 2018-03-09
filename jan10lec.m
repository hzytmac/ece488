s=tf('s');
pm=45;

C=200;
P=1/((s+1)*(s+5)*(s+10));
sys=P*C;
bode(sys)
margin(sys)