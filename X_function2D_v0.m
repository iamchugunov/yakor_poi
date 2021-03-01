function [X] = X_function2D_v0(t,a,n)

% r = Inf;
b = NaN(1,n);

for q = 1:n   
    A(1,q) = -t(q);
    for k = 2:n
        A(k,q) = a(k-1,q);
    end   
end

% A = [-t';a];

% выбор номера min значения t, т.е. задержки
jj = argmin_func(t);

for q = 1:n   
    L(:,q) = A(:,q) - A(:,jj);
%     b(q) = kf_func(L(:,q),n)*2^(-1);
    b(q) = kf_func(L(:,q),n)*.5;
end

L = L';
c = Inf;

    for k = 1:n
        R = L;
        R(jj,k) = 1;
        if cond_eucl(R) < c
            c = cond_eucl(R);
            kk  = k;
        end
        if c == Inf
        break;
        end
    end

L(jj,kk) = 1;    
% P = L^(-1)*b';  
% P = inv(L)*b';
P = L\b';

% for q = 1:n
%     b1(q) = 0;
% end
b1 = zeros(n,1); % сразу вектор-столбец!

b1(jj) = 1;
% Q = L^(-1)*b1';
% Q = L\b1';
Q = L\b1;% уже вектор-столбец!
z = roots([kf_func(Q,n) 2*bf_func(P,Q,n) kf_func(P,n)]);
s = z;

X(:,1) = P + Q * s(1) + A(:,jj);
X(:,2) = P + Q * s(2) + A(:,jj);
% X(:,3) = [z(1); z(2); c; kk];
X(:,3) = [z(1); z(2); kk];
end

function [bf] = bf_func(u,v,n)

for i = 2:n
uv(i) = u(i)*v(i);
end

bf = - u(1)*v(1) + sum(uv);

end

function [CondA] = cond_eucl(A)

[m,n] = size(A);
if m == n
CondA = norm(A,'fro')*norm(inv(A),'fro');
else
    for i = 1:length(A)
        b = A;
        b(:,i) = [];
        Cond(i) = norm(b,'fro')*norm(inv(b),'fro');
    end
    CondA = min(Cond);
end
end

function [kf] = kf_func(v,n)

for i = 2:n
vv(i) = v(i)*v(i);
end

kf = - v(1)*v(1) + sum(vv);

end

function [jj] = argmin_func(t)

r = Inf;

for q = 1:length(t)

if t(q) < r
r = t(q);
jj = q;
end

end

end

