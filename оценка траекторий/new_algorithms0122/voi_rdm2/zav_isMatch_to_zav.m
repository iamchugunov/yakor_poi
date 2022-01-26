function [flag] = zav_isMatch_to_zav(zav, poit)

    
    if zav.Smode ~= -1 && poit.Smode ~=-1
        if zav.Smode == poit.Smode
            flag = 1;
            return;
        end
        if zav.Smode ~= poit.Smode
            flag = 0;
            return;
        end
    end
    
    if abs(poit.freq - zav.freq) > 10.
        flag = 0;
        return;
    end
    
    
    % first check for last 4
    if zav.last_4_flag
        dt = calculate_period(zav.last_4, poit);
        if std(dt) < 250
            flag = 1;
        else
            flag = 0;
            return;
        end
    end
    % then check last N poits
    k = zav.p_count;
    while k >= zav.p_count - 5
        dt = calculate_period(zav.poits(k), poit);
        if std(dt) < 250 && length(dt) > 1
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
    
    for i = 1:6
        if zav.rd(i) ~= 0 && poit.rd_flag(i)
            if abs(zav.rd(i) - poit.rd(i)) > 300
                flag = 0;
                return;
            end
        end
    end
    

    
%     %rd check
%     k = 0;
%     delta = [];
%     for i = 1:6
%         if (poit.rd(i) ~= 0 && traj.rd(i) ~= 0)
%             k = k + 1;
%             delta(k) = abs(poit.rd(i) - traj.rd(i));
%         end
%     end
%     if k > 0
%         if length(find(delta<500)) == k
%             flag = 1;
%         else
%             flag = 0;
%         end
%     else
%         flag = 0;
%     end

end

