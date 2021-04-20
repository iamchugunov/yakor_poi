function [X, R] = max_likelyhood_cos(y,t,sigma,X0)
    N = length(y);               
    
    X = X0;
    
    k = 0;
    while 1
       d = zeros(2,1);
       dd = zeros(2,2);
        for j = 1:N
            d(1) = d(1) + 1/sigma^2 * (y(j) * cos(2*pi*X(2)*t(j)) - X(1)*cos(2*pi*X(2)*t(j))^2);
            d(2) = d(2) + 2*pi*t(j)*X(1)/sigma^2*(-y(j)*sin(2*pi*X(2)*t(j)) + X(1)*cos(2*pi*X(2)*t(j))*sin(2*pi*X(2)*t(j)));
            
            ddd(1,1) = -1/sigma^2 * cos(2*pi*X(2)*t(j))^2;
            ddd(1,2) = 1/sigma^2 * (-y(j) * 2*pi*t(j) * sin(2*pi*X(2)*t(j)) + 2 * X(1) * cos(2*pi*X(2)*t(j)) * sin(2*pi*X(2)*t(j))* 2*pi*t(j));
            ddd(2,1) = ddd(1,2);
            ddd(2,2) = 2*pi*t(j)*X(1)/sigma^2 * (-y(j)*2*pi*t(j)*cos(2*pi*X(2)*t(j)) + X(1)*(-2*pi*t(j)*sin(2*pi*X(2)*t(j))*cos(2*pi*X(2)*t(j)) + 2*pi*t(j)*cos(2*pi*X(2)*t(j))^2));
            dd = dd + ddd;
        end
        X_prev = X;
        X = X - inv(dd) * d;
        k = k + 1
        if norm(X - X_prev) < 0.01
            R = dd;
            break;
        end
        
    end
    
    
end


