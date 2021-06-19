function [X, X1, D] = zav_approx(zav, config)
    
    k = 0;
    for i = 1:zav.count
        if zav.poits(i).xy_valid
            k = k + 1;
            cord(:,k) = zav.poits(i).coords;
            cord(4,k) = cord(4,k) + (zav.poits(i).Frame - zav.t0)*config.c*1e9;
        end
    end
        
        
    N = size(cord, 2);
    T = cord(4,:)/config.c*1e-9;
%     T = T - min(T);
    X = cord(1,:);
    Y = cord(2,:);
    Z = cord(3,:);
    
    X = medfilt1(X);
    Y = medfilt1(Y);
    Z = medfilt1(Z);
    
    A(1,1) = N;
    A(1,2) = 0;
    A(2,2) = 0;
    for i = 1:N
        A(1,2) = A(1,2) + T(i);
        A(2,2) = A(2,2) + T(i)^2;
    end
    A(2,1) = A(1,2);
    
    bx = [0;0];
    by = [0;0];
    bz = [0;0];
    for i = 1:N
        bx(1) = bx(1) + X(i);
        bx(2) = bx(2) + T(i)*X(i);
        by(1) = by(1) + Y(i);
        by(2) = by(2) + T(i)*Y(i);
        bz(1) = bz(1) + Z(i);
        bz(2) = bz(2) + T(i)*Z(i);
    end
    ax = A\bx;
    ay = A\by;
    az = A\bz;
    X = [ax(1);ax(2); 0; ay(1);ay(2); 0; az(1); az(2); 0];
    
    
        [X1, R, nev] = max_likelyhood_3Da(zav.ToA, config, X);
%     [X1, R, nev] = max_likelyhood_2dv(zav.ToA, config, X);
    D = inv(-R);
    D = D(1:9,1:9);
    X1 = X1(1:9);
%     [X X1(1:9)]
%     [N size(zav.ToA, 2)]
    
%     tend = zav.poits(end).Frame;
%     XX = [ ax(1) ax(1) + ax(2) * (tend - zav.t0); ay(1) ay(1) + ay(2) * (tend - zav.t0) ];
%     if norm([ax(2); ay(2)]) < 600
%         plot(cord(1,:),cord(2,:),'xb')
%         plot(XX(1,:),XX(2,:),'.-r')
%         pause(0.1)
%     end
    
end

