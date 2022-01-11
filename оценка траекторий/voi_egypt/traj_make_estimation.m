function [flag, traj] = traj_make_estimation(traj, config)
    
    if traj.current_points_count < 10
        flag = 0;
        traj = traj_extend(traj);
        return;
    end
    
    for i = 1:traj.current_points_count
        traj.dop(i) = traj.current_poits(i).dop;
    end
    traj.dop = median(traj.dop(find(traj.dop)));
    
    if traj.dop < 20
        traj.T_nak = traj.T_nak_default;
    elseif traj.dop < 100
        if traj.T_nak == traj.T_nak_default * 2
            flag = 1;
        else
            traj.T_nak = traj.T_nak_default * 2;
            flag = 0;
            return;
        end   
    else
        if traj.T_nak == traj.T_nak_default * 3
            flag = 1;
        else
            traj.T_nak = traj.T_nak_default * 3;
            flag = 0;
            return;
        end   
    end
    
    [flag, X, X1, D] = traj_approx(traj, config);
    
    if flag == 0
        traj = traj_extend(traj);
        return;
    end
    flag = 1;
    if X(1) == 0
       disp("") 
    end
    
    flag1 = zav_is_ok(X);
    flag2 = zav_is_ok(X1);
        
    if flag1 == 0 && flag2 == 0
        flag = 0;
        traj = traj_extend(traj);
        return;
    elseif flag1 == 1 && flag2 == 0
        X1 = X;
        D = eye(9);
        D(1,1) = 100^2;
        D(4,4) = 100^2;
        D(7,7) = 100^2;
    elseif flag1 == 0 && flag2 == 1
        X = X1;
    end
    
    traj.current_SV_approx = X;
    traj.current_SV_interp = X1;
%     traj.DispMatrix = D;
    
    if traj.hard_nak_flag == 1
        traj.T_nak = traj.T_nak / 2;
    end
    traj.hard_nak_flag = 0;
    
    
    
    D1 = D;
    D1(3,3) = 0;
    D1(6,6) = 0;
    D1(9,9) = 0;
%     D1()
%     D_ksi = diag([0.1 0.1 0.001].^2);
%     [X1f, D_x] = Kalman_step_3D(X, traj.SV_fil1(:,end), traj.Dx1, traj.current_t0 - traj.last_f1_t0, D1, D_ksi);
    traj.fil1 = filter_one_step(traj.fil1, X, traj.current_t0, D1);
    if traj.fil1.skipped > 1
        traj.fil1 = filter_reset(traj.fil1, X, traj.current_t0);
    end
    traj.fil2 = filter_one_step(traj.fil2, X1, traj.current_t0, D);
    if traj.fil2.skipped > 1
        traj.fil2 = filter_reset(traj.fil2, X1, traj.current_t0);
    end
%     if norm(X1f - traj.SV_fil1(:,end)) < 1e4
%         traj.current_SV_fil1 = X1f;
%         traj.Dx1 = D_x;
%         traj.last_f1_t0 = traj.current_t0;
%         traj.SV_fil1(:,traj.estimations_count) = X1f;
%     else
%         X_prev = traj.SV_fil1(:,end);
%         X1f(1,1) = X_prev(1,1) + X_prev(2,1) * (traj.current_t0 - traj.last_f1_t0);
%         X1f(2,1) = X_prev(2,1);
%         X1f(3,1) = X_prev(3,1);
%         X1f(4,1) = X_prev(4,1) + X_prev(5,1) * (traj.current_t0 - traj.last_f1_t0);
%         X1f(5,1) = X_prev(5,1);
%         X1f(6,1) = X_prev(6,1);
%         X1f(7,1) = X_prev(7) + X_prev(8,1) * (traj.current_t0 - traj.last_f1_t0);
%         X1f(8,1) = X_prev(8,1);
%         X1f(9,1) = X_prev(9,1);
%         traj.SV_fil1(:,traj.estimations_count) = X1f;
%     end
    
%     [X2f, D_x] = Kalman_step_3D(X1, traj.SV_fil2(:,end), traj.Dx2, traj.current_t0 - traj.last_f2_t0, D, D_ksi);
    
%     flag_f = traj_is_ok(X2f);
%     if flag_f == 0
%         flag = 0;
%         traj = traj_extend(traj);
%         return;
%     end

%     if norm(X2f - traj.SV_fil2(:,end)) < 1e4
%         traj.current_SV_fil2 = X2f;
%         traj.Dx2 = D_x;
%         traj.last_f2_t0 = traj.current_t0;
%         traj.SV_fil2(:,traj.estimations_count) = X2f;
%     else
%         traj.SV_fil2(:,traj.estimations_count) = X1f;
%     end
        
    
    traj.estimations_count = traj.estimations_count + 1;
    
%     traj.current_SV_fil1 = X1f;
%     traj.Dx1 = D_x;
%     traj.last_f1_t0 = traj.current_t0;
%     traj.SV_fil1(:,traj.estimations_count) = X1f;
    
%     traj.current_SV_fil2 = X2f;
%     traj.Dx2 = D_x;
%     traj.last_f2_t0 = traj.current_t0;
%     traj.SV_fil2(:,traj.estimations_count) = X2f;
        
    traj.timestamps(traj.estimations_count) = traj.current_t0;
    traj.SV_approx(:,traj.estimations_count) = X;
    traj.SV_interp(:,traj.estimations_count) = X1;
    traj.t_last_estimation = traj.current_t0;
    traj.dops(traj.estimations_count) = traj.dop;
        
    traj = traj_reset(traj);
%     traj.current_t0 = traj.all_poits(end).Frame;
%     traj.all_ToA(:,end+1:end+traj.current_points_count) = traj.ToA;
%     traj.ToA = [];
%     traj.current_poits = struct([]);
%     traj.current_points_count = 0;
    
    traj_set_plot(traj, traj.fil2.SV(1,:), traj.fil2.SV(4,:));
    
          
    
end



