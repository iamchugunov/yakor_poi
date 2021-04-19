function [X, SV] = mnk_2d_v_const(posts, y)
    
    epsilon = 0.0001;
    max_iter = 15;
    
    N = size(y,2);
    Y = zeros(N * 4, 1);
    
    X = zeros(5 + N - 1, 1);
    H = zeros(N * 4, 5 + N - 1);
    
%     X(1) = -6.509489944612653e+04;
%     X(2) = 24.100553873473324;
%     X(3) = 4.419654259820752e+04;
%     X(4) = 198;
    X(5) = y(1,1);
    for i = 1:N
        y_m((1:4) + 4*(i-1),:) = y(:,i);
    end
    X(6:end) = diff(y(1,:));
    iter = 0;
    
    while 1
        
        iter = iter + 1;
        
        for i = 1:N
            for k = 1:4
                if i == 1
                    Y(k + 4*(i - 1)) = X(5) + norm([X(1);X(3);10000] - posts(:,k));
                    H(k + 4*(i - 1), 1) = (X(1) - posts(1,k))/norm([X(1);X(3);10000] - posts(:,k));
                    H(k + 4*(i - 1), 2) = 0;
                    H(k + 4*(i - 1), 3) = (X(3) - posts(2,k))/norm([X(1);X(3);10000] - posts(:,k));
                    H(k + 4*(i - 1), 4) = 0;
                    H(k + 4*(i - 1), 5) = 1;
                    for j = 6:5 + N - 1
                        H(k + 4*(i - 1), j) = 0;
                    end
                else
                    d = norm([X(1) + X(i + 4) * X(2)/3e8; X(3) + X(i + 4) * X(4)/3e8;10000] - posts(:,k));
                    Y(k + 4*(i - 1)) = X(5) + X(i + 4) + d;
                    H(k + 4*(i - 1), 1) = (X(1) + X(i + 4) * X(2)/3e8 - posts(1,k))/d;
                    H(k + 4*(i - 1), 2) = (X(1) + X(i + 4) * X(2)/3e8 - posts(1,k)) * X(i + 4)/3e8/d;
                    H(k + 4*(i - 1), 3) = (X(3) + X(i + 4) * X(4)/3e8 - posts(2,k))/d;
                    H(k + 4*(i - 1), 4) = (X(3) + X(i + 4) * X(4)/3e8 - posts(2,k)) * X(i + 4)/3e8/d;
                    H(k + 4*(i - 1), 5) = 1;
                    for j = 6:5 + N - 1
                        H(k + 4*(i - 1), j) = 0;
                    end
                    H(k + 4*(i - 1), i + 4) = 1 + ((X(1) + X(2) * X(i + 4)/3e8 - posts(1,k)) * X(2)/3e8 + (X(3) + X(4) * X(i + 4)/3e8 - posts(2,k)) * X(4)/3e8)/d;
                end
            end
        end
        
        X_prev = X;
        X = X + (H'*H)^(-1)*(H')*(y_m-Y);
        
        if (norm(X - X_prev) < epsilon) || (iter > max_iter)
            break
        end
    end
    
    SV(:,1) = [X(1,1);X(3,1);X(5,1)/3e8];
    for i = 2:N
        dt = X(i + 4)/3e8;
        SV(1,i) = X(1,1) + X(2,1) * dt;
        SV(2,i) = X(3,1) + X(4,1) * dt;
        SV(3,i) = X(5,1)/3e8 + dt;
    end
end

