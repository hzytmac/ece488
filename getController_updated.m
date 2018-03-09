function C = getController(k, G, pm_target)
    s = tf('s');
    [~, pm] = margin(k*G);
    theta_max = deg2rad(pm_target - pm);
    alpha = (1 + sin(theta_max))/(1 - sin(theta_max));
    target_gain = 10*log10(alpha);
    w = getGainCrossover(k*G, db2mag(target_gain));

    tau1 = 1/(sqrt(alpha)*w);
    tau2=0.5*k/50;
    C = k*(s+1/(alpha*tau1))*(s + alpha/tau2)/((s)*(s+1/tau1));
end