% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484629

clear;
clc;
close all;

dt = 0.1;

s = tf('s');
G = 1/((s+1)*(s+5)*(s+10));

ess = 0.5;
pm_target = 45 + 5;
    
C500 = getController_updated(500, G, pm_target);
C700 = getController_updated(700, G, pm_target);

t = 0:dt:10;

figure;
subplot(1, 2, 1);
sys500 = feedback(C500*G, 1);
[~, pm500] = margin(C500*G);
lsim(sys500, t, t);
title(sprintf('K = 500, phase margin = %f', pm500));
subplot(1, 2, 2);
sys700 = feedback(C700*G, 1);
[~, pm700] = margin(C700*G);
lsim(sys700, t, t);
title(sprintf('K = 700, phase margin = %f', pm700));
figure;
subplot(1, 2, 1);
bode(C500*G)
margin(C500*G);
subplot(1, 2, 2);
bode(C700*G)
margin(C700*G);

% Phase margin:
% A gain of 700 resulted in a larger final phase margin than the gain of
% 500.
% This is becuase with a higher gain (e.g. 700), the initial phase margin
% of k*G is smaller and our theta_max value is correspondingly larger.
% Alpha increases in value, giving us a larger target gain as well.
% This moves the lead compoensator to the right, closer to the new
% gain crossover frequency and thus phase margin increases.

% Steady state error:
% Because tau2 is caluated based on the initial k and on the desired
% steady state error, the steady state error for both cases are the same.