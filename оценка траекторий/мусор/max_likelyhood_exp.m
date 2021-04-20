function [X, R] = max_likelyhood_exp(y,t,sigma,X0)
    N = length(y);               
    
    X = X0;
    
    k = 0;
    while 1
       d = zeros(2,1);
       dd = zeros(2,2);
        
        for j = 1:N
            d(1) = d(1) + 1/sigma^2 *( y(j) * exp(X(2)*t(j)) - X(1) * exp(2 * X(2) * t(j)) );
            d(2) = d(2) + 1/sigma^2 *( y(j) * X(1) * exp(X(2)*t(j))*t(j) - X(1)^2 * exp(2*X(2)*t(j))*t(j));
            
            ddd(1,1) = -1/sigma^2 *exp(2*X(2)*t(j));
            ddd(1,2) = y(j)/sigma^2 * exp(X(2)*t(j)) * t(j) - X(1)/sigma^2 * exp(2*X(2)*t(j))*2*t(j);
            ddd(2,1) = ddd(1,2);
            ddd(2,2) = y(j)/sigma^2 * X(1) * exp(X(2) * t(j)) * t(j)^2 - X(1)^2/sigma^2 * exp(2*X(2)*t(j)) * 2 * t(j)^2;
            dd = dd + ddd;
            
        end
        X_prev = X;
        X = X - inv(dd) * d;
        k = k + 1
        if norm(X - X_prev) < 1
            R = dd;
            break;
        end
        
    end
    
    
end


