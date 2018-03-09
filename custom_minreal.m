function [Amin, Bmin, Cmin, Dmin] = custom_minreal(A, B, C, D)
    szA = size(A, 1);
    Q = ctrb(A, B);
    rQ = rank(Q);
    if rQ ~= szA
        [~, ind_col] = rref(Q);
        T = [Q(:, ind_col) rand(szA, szA-rQ)];
        % transform
        A = T\A*T;
        B = T\B;
        C = C*T;
        % extract
        A = A(1:rQ, 1:rQ);
        B = B(1:rQ, :);
        C = C(:, 1:rQ);
    end
    
    szA = size(A, 1);
    R = obsv(A, C);
    rR = rank(R);
     
    if rR ~= szA
        [~, ind_col] = rref(R');
        T = [R(ind_col, :);
             rand(szA - rR, szA)];
        % transform
        A = T*A/T;
        B = T*B;
        C = C/T;
        % extract
        A = A(1:rR, 1:rR);
        B = B(1:rR, :);
        C = C(:, 1:rR);
    end
    Amin = A;
    Bmin = B;
    Cmin = C;
    Dmin = D;
end