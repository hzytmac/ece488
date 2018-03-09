clear;
clc;
close all;

Kp = 10;
Ki = 0;
Kd = 2;

s = tf('s');
P = 10/(s^2 + 10*s);

figure;
bode(P);
title('Bode plot of plant');

C = pid(Kp, Ki, Kd);
sys = feedback(P*C, 1);

figure;
step(sys);
title('Step response for Kp = 10, Kd = 2');

%%%%%%%%%%%%%%%%%%%%%%
% Critically damped system
%%%%%%%%%%%%%%%%%%%%%%

Kd_crit = 1;
Kp_crit = 10;

C_crit = pid(Kp_crit, 0, Kd_crit);
sys_crit = feedback(P*C_crit, 1);
figure;
bode(sys_crit);
title('Critically damped system');

figure;
step(sys_crit);
title('Step response: critically damped');

%%%%%%%%%%%%%%%%%%%%%%
% Underdamped system
%%%%%%%%%%%%%%%%%%%%%%

zeta = 0.7;
Kp_under = 10;
Kd_under = (zeta*2*sqrt(10*Kp_under)-10)/10;

C_under = pid(Kp_under, 0, Kd_under);
sys_under = feedback(P*C_under, 1);
figure;
bode(sys_under);
title('Underdamped system');

figure;
step(sys_under);
title('Step response: underdamped');

%%%%%%%%%%%%%%%%%%%%%%
% Overdamped system
%%%%%%%%%%%%%%%%%%%%%%

zeta = 1.5;
Kp_over = 10;
Kd_over = (zeta*2*sqrt(10*Kp_over)-10)/10;

C_over = pid(Kp_over, 0, Kd_over);
sys_over = feedback(P*C_over, 1);
figure;
bode(sys_over);
title('Overdamped system');

figure;
step(sys_over);
title('Step response: overdamped');