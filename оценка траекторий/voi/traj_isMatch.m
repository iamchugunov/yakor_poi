function [flag] = traj_isMatch(traj, poit)
    
%     check ID match
    if traj.ID ~= -1 && traj.ID == poit.Smode
        flag = 1;
        return;
    end
   
% first check for last 4
    if traj.last_4_flag
        dt = calculate_period(traj.last_4, poit);
        if std(dt) < 150
            flag = 1;
        else
            flag = 0;
            return;
        end
    end
% then check last N poits
    k = traj.all_poits_count;
    while k >= traj.all_poits_count - 5
        dt = calculate_period(traj.all_poits(k), poit);
        if std(dt) < 150 && length(dt) > 1 
            flag = 1;
        else
            flag = 0;
            return;
        end
        k = k - 1;
        if k == 0
            break;
        end
    end
    
end


