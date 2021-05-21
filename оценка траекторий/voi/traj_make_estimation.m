function [flag, traj] = traj_make_estimation(traj, config)
    
    if traj.current_points_count < 10
        flag = 0;
        traj = traj_extend(traj);
        return;
    end
    
    [flag, X, X1, D] = traj_approx(traj, config);
    if flag == 0
        traj = traj_extend(traj);
        return;
    end
    flag = 1;
    traj.current_SV_approx = X;
    traj.current_SV_interp = X1;
%     traj.DispMatrix = D;
    
    
    if traj.hard_nak_flag == 1
        traj.T_nak = traj.T_nak / 2;
    end
    traj.hard_nak_flag = 0;
    
    traj.estimations_count = traj.estimations_count + 1;
    traj.timestamps(traj.estimations_count) = traj.current_t0;
    traj.SV_approx(:,traj.estimations_count) = X;
    traj.SV_interp(:,traj.estimations_count) = X1;
    traj.t_last_estimation = traj.current_t0;
    traj.current_t0 = traj.all_poits(end).Frame;
    traj.all_ToA(:,end+1:end+traj.current_points_count) = traj.ToA;
    traj.ToA = [];
    traj.current_poits = struct([]);
    traj.current_points_count = 0;
    
    
          
    
end



