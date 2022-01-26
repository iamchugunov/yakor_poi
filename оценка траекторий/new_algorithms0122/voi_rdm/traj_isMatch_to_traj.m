function [flag, D] = traj_isMatch_to_traj(traj, poit, config)
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
    
    D_n = config.sigma_n^2;
    D_ksi = config.sigma_ksi^2;
    
    k = 0;
    flags = [];
    nevs = [];
    for i = 1:6
        if poit.rd_flag(i)
            dt = poit.Frame - traj.filters(i).t_last;
            [flag, nev] = isMatch_rd(poit.rd(i), traj.filters(i).X, traj.filters(i).D_x, dt, D_n, D_ksi);
            k = k + 1;
            flags(k) = flag;
            nevs(k) = nev;
        end
    end
    
    D = norm(nev);
    
    flag = prod(flags);
    
    

    
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



