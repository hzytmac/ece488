% Group 2
% Tomas Gareau - 20517229
% Jeremy Wong - 20518722
% Ziyang Huang - 20484629

%% Part 1
s = tf('s');
P = 10/(s*(s+2));

figure;
subplot(1, 2, 1);
nyquist(P);
title('MATLAB Nyquist');
subplot(1, 2, 2);
nyquist1(P);
title('Modified Nyquist');

%% Part 2
h = 2/(s^4 + 3*s^3 + 6*s^2 + s);

% best answer for rlocus with data cursor: 0.9416
% can't get much more accurate than that: MATLAB generates the root locus
% plot with discrete samples - we cannot get the exact gain margin from
% this plot because we are limited by the resolution used internally by
% MATLAB.
% we can also see that the root locus plot starts at the origin. this
% suggests that K must be greater than 0 - note that this answer is exact
% because (presumably) MATLAB directly samples the point generated when K=0
figure;
rlocus(h);

% Using the tool designed for this problem though gives the exact answer of
% 0.9444 (or 17/18, as shown in the video lectures).
gm = margin(h);
