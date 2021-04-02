function [traj, R] = make_esimation(y, config)
    
    k = 0;
    while 1
        k = k + 1;
        if length(find(y(:,k)>0)) == 4
            X0 = coord_solver2D(y(:,k)*config.c, config.posts, [0;0;mean(y(:,k))], config.hei);
            break;
        end
    end
    
    k = size(y,2) + 1;
    while 1
        k = k - 1;
        if length(find(y(:,k)>0)) == 4
            Xend = coord_solver2D(y(:,k)*config.c, config.posts, [0;0;mean(y(:,k))], config.hei);
            break;
        end
    end
    
    X(1) = X0(1);
    X(2) = (Xend(1) - X0(1))/(Xend(3) - X0(3))*config.c;
    X(3) = 0;
    X(4) = X0(2);
    X(5) = (Xend(2) - X0(2))/(Xend(3) - X0(3))*config.c;
    X(6) = 0;
    X(7) = config.hei;
    X(8) = 0;
    X(9) = 0;
    
%     X
    
    [X, R] = max_likelyhood_3Da(y, config, X);
    
    traj(:,1) = X(1:9,:);
    T = X(10:end)/1e9;
    for i = 2:size(y,2)
       dT = T(i) - T(i-1);
       F = [1 dT dT^2/2 0 0 0 0 0 0;
            0 1 dT 0 0 0 0 0 0;
            0 0 1 0 0 0 0 0 0;
            0 0 0 1 dT dT^2/2 0 0 0;
            0 0 0 0 1 dT 0 0 0;
            0 0 0 0 0 1 0 0 0;
            0 0 0 0 0 0 1 dT dT^2/2;
            0 0 0 0 0 0 0 1 dT;
            0 0 0 0 0 0 0 0 1;];
       traj(:,i) = F * traj(:,i-1);
    end
    traj(10,:) = T;
        
    
    
    
    
    
    
    
end

