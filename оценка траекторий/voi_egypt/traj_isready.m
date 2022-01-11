function [flag] = traj_isready(traj)
    flag = traj.t_last_poit - traj.current_t0 > traj.T_nak || traj.current_points_count > 200;
end



