function [RD, T] = get_interp_rd(traj, config)
    traj.toa = traj.all_ToA;
    k = [0;0;0];
    
    for i = 1:length(traj.all_poits)
        T(i) = traj.all_poits(i).Frame + max(traj.all_poits(i).ToA)/1e9;
        if traj.all_poits(i).ToA(1)
           if traj.all_poits(i).ToA(2)
               k(1) = k(1)+1;
%                t21(k(1)) = traj.toa(1,i);
               t21(k(1)) = traj.all_poits(i).Frame + max(traj.all_poits(i).ToA)/1e9;
               rd21(k(1)) = (traj.all_poits(i).ToA(2)-traj.all_poits(i).ToA(1))*config.c_ns;
           end
           if traj.all_poits(i).ToA(3)
               k(2) = k(2)+1;
%                t31(k(2)) = traj.toa(1,i);
               t31(k(2)) = traj.all_poits(i).Frame + max(traj.all_poits(i).ToA)/1e9;
               rd31(k(2)) = (traj.all_poits(i).ToA(3)-traj.all_poits(i).ToA(1))*config.c_ns;
           end
           if traj.all_poits(i).ToA(4)
               k(3) = k(3)+1;
%                t41(k(3)) = traj.toa(1,i);
               t41(k(3)) = traj.all_poits(i).Frame + max(traj.all_poits(i).ToA)/1e9;
               rd41(k(3)) = (traj.all_poits(i).ToA(4)-traj.all_poits(i).ToA(1))*config.c_ns;
           end
        end 
    end
    t0 = min([t21(1) t31(1) t41(1)]);
    RD(1,:) = interp1(t21,rd21,T);
    RD(2,:) = interp1(t31,rd31,T);
    RD(3,:) = interp1(t41,rd41,T);
end



