function [flag, traj] = traj_make_estimation(traj, config)
    
    flag = 1;
    traj.estimations_count = traj.estimations_count + 1;
    traj.timestamps(traj.estimations_count) = traj.current_t0;
    traj.t_last_estimation = traj.current_t0;
    traj.current_t0 = traj.all_poits(end).Frame;
    traj.all_ToA(:,end+1:end+traj.current_points_count) = traj.ToA;
    traj.ToA = [];
    traj.current_points_count = 0;
          
    
end



