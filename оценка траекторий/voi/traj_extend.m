function [traj] = traj_extend(traj)
    traj.T_nak = traj.T_nak * 2;
    traj.hard_nak_flag = traj.hard_nak_flag + 1; 
end

