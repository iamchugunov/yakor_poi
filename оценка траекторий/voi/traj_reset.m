function [traj] = traj_reset(traj)
    traj.current_t0 = traj.all_poits(end).Frame;
    traj.all_ToA(:,end+1:end+traj.current_points_count) = traj.ToA;
    traj.ToA = [];
    traj.current_poits = struct([]);
    traj.current_points_count = 0;
    
    if traj.dop < 20
        traj.T_nak = traj.T_nak_default;
    elseif traj.dop < 100
        traj.T_nak = traj.T_nak_default * 2;
    else
        traj.T_nak = traj.T_nak_default * 3;
    end
end

