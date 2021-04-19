function [X, R] = max_likelyhood_lin(y,t,sigma,X0)
    N = length(y);               
    
    X = X0;
    
%     X = X0(1);
    
    k = 0;
    while 1
       d = zeros(2,1);
       dd = zeros(2,2);
        
%     d = zeros(1,1);
%     dd = zeros(1,1);
        for j = 1:N
            d(1) = d(1) + 1/sigma^2 *(y(j) - X(1) - X(2) * t(j));
            d(2) = d(2) + t(j)/sigma^2 *(y(j) - X(1) - X(2) * t(j));
            
%             d(1) = d(1) + 1/sigma^2 *(y(j) - X(1) - X0(2) * t(j));
            
            dd = dd + [-1/sigma^2 -t(j)/sigma^2; -t(j)/sigma^2 -t(j)^2/sigma^2];
            
%             dd = dd -1/sigma^2;
        end
        X_prev = X;
        X = X - inv(dd) * d;
        k = k + 1
        norm(X - X_prev)
        if norm(X - X_prev) < 1
            R = dd;
            break;
        end
        
    end
    
    
end
