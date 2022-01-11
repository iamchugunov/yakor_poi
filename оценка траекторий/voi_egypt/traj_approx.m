function [flag, X, X1, D] = traj_approx(traj, config)
    
   
    k = 0;
    for i = 1:traj.current_points_count
        if traj.current_poits(i).xy_valid
            k = k + 1;
            cord(:,k) = traj.current_poits(i).coords;
            cord(4,k) = cord(4,k) + (traj.current_poits(i).Frame - traj.current_t0)*config.c*1e9;
        end
    end
    
    if k < 4
        flag = 0;
        X = [];
        X1 = [];
        D = [];
        return;
    end

    flag = 1;
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
    
    
%     [X1, R, nev] = max_likelyhood_3dv(traj.ToA, config, X);
    [X1, R, nev] = max_likelyhood_2dv(traj.ToA, config, X);
    D = inv(-R);
    D = D(1:9,1:9);
    X1 = X1(1:9);
    
    

%     [X X1(1:9)]
%     [N size(zav.ToA, 2)]
    
%     norm(X([1 2 4 5],:) - X1([1 2 4 5],:))
    
%     tend = traj.current_poits(end).Frame;
% %     XX = [ ax(1) ax(1) + ax(2) * (tend - traj.current_t0); ay(1) ay(1) + ay(2) * (tend - traj.current_t0) ];
% %     XX1 = [ ax(1) ax(1) + ax(2) * (tend - traj.current_t0); ay(1) ay(1) + ay(2) * (tend - traj.current_t0) ];
%     XX = [X(1) X(1) + X(2) * T(end) + X(3) * T(end)^2/2; X(4) X(4) + X(5) * T(end) + X(6) * T(end)^2/2];
%     XX1 = [X1(1) X1(1) + X1(2) * T(end) + X1(3) * T(end)^2/2; X1(4) X1(4) + X1(5) * T(end) + X1(6) * T(end)^2/2];
%     if norm([ax(2); ay(2)]) < 600
%         plot(cord(1,:),cord(2,:),'xb')
%         hold on
%         plot(XX(1,:),XX(2,:),'.-r')
%         plot(XX1(1,:),XX1(2,:),'.-g')
%         pause(0.1)
%     end
    
end



