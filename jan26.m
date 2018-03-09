% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484627

close all;
clear;
clc;

s = tf('s');
P = 100/((s+1)*(s-2)*(s+4));
[A, B, C, D] = ssdata(P);

poles = [-3+i, -3-i, -30];
K = place(A, B, poles);

observer_poles = [-300, -301, -302];
F = place(A', C', observer_poles)';

[xpn, xpd] = ss2tf(A-F*C, -F, -K, 0);
[npn, npd] = ss2tf(A-B*K, B, C-D*K, D);
[ypn, ypd] = ss2tf(A-F*C, -B+F*D, -K, 1);
[dpn, dpd] = ss2tf(A-B*K, B, -K, 1);
xp_tf = tf(xpn, xpd);
np_tf = tf(npn, npd);
yp_tf = tf(ypn, ypd);
dp_tf = tf(dpn, dpd);

r = 100/(s+100);
C_tf = (xp_tf + r*dp_tf)/(yp_tf-r*np_tf);

sys_tf = feedback(P*C_tf, 1);

xp_ss = ss(A-F*C, -F, -K, 0);
np_ss = ss(A-B*K, B, C-D*K, D);
yp_ss = ss(A-F*C, -B+F*D, -K, 1);
dp_ss = ss(A-B*K, B, -K, 1);

C_ss = (xp_ss + r*dp_ss)/(yp_ss - r*np_ss);
sys_ss = feedback(P*C_ss, 1);

% the figure below shows that MATLAB handles multiplication/feedback of ss
% systems perfectly without needing to switch to tf. sweet
figure;
step(sys_tf, 10);
hold on;
step(sys_ss, 10);
legend('TF', 'SS');