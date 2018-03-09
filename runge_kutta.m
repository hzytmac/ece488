function [t, x] = runge_kutta(eqnfun, x0, t0, tf, dt)
    t = t0:dt:tf;
    x = zeros(length(x0), length(t));
    x(:, 1) = x0;
    for i = 2:length(t)
        k1 = eqnfun(t(i), x(:, i-1));
        k2 = eqnfun(t(i) + dt/2, x(:, i-1) + dt*k1/2);
        k3 = eqnfun(t(i) + dt/2, x(:, i-1) + dt*k2/2);
        k4 = eqnfun(t(i) + dt, x(:, i-1) + dt*k3);
        x(:, i) = x(:, i-1) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
end