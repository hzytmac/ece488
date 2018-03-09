function [C, P] = lecture13func(b, Kp)
    syms a Kd
    eqns = [Kd - a*b == 3;
            a - b == 3];
    [a, Kd] = solve(eqns, a, Kd);
    a = double(a);
    Kd = double(Kd);

    s = tf('s');
    P = 1/(s*(s - b));
    C = (Kd*s + Kp)/(s + a);
end