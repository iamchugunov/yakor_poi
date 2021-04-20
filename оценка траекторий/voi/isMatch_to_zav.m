function [flag] = isMatch_to_zav(zav, poit)
    
%     check ID match
    if zav.ID ~= -1 && zav.ID == poit.Smode
        flag = 1;
        return;
    end
   
% first check for last 4
    if zav.last_4_flag
        dt = calculate_period(zav.last_4, poit);
        if std(dt) < 150
            flag = 1;
        else
            flag = 0;
            return;
        end
    end
% then check last N poits
    k = zav.count;
    while k >= zav.count - 5
        dt = calculate_period(zav.poits(k), poit);
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

