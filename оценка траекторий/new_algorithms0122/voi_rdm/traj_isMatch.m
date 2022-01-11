function [flag] = traj_isMatch(traj, poit)
    if traj.Smode ~= -1 && poit.Smode ~=-1
        if traj.Smode == poit.Smode
            flag = 1;
            return;
        end
        if traj.Smode ~= poit.Smode
            flag = 0;
            return;
        end
    end
    
    
    %rd check
    k = 0;
    delta = [];
    for i = 1:6
        if (poit.rd(i) ~= 0 && traj.rd(i) ~= 0)
            k = k + 1;
            delta(k) = abs(poit.rd(i) - traj.rd(i));
        end
    end
    if k > 0
        if length(find(delta<500)) == k
            flag = 1;
        else
            flag = 0;
        end
    else
        flag = 0;
    end

end

