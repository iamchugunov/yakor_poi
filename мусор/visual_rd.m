function [] = visual_rd(traj, config)
    traj.toa = traj.all_ToA;
    k = [0;0;0];
    for i = 1:length(traj.toa)
        if traj.toa(1,i)
           if traj.toa(2,i)
               k(1) = k(1)+1;
%                t21(k(1)) = traj.toa(1,i);
               t21(k(1)) = traj.all_poits(i).Frame; 
               rd21(k(1)) = (traj.toa(2,i)-traj.toa(1,i))*config.c;
           end
           if traj.toa(3,i)
               k(2) = k(2)+1;
%                t31(k(2)) = traj.toa(1,i);
               t31(k(2)) = traj.all_poits(i).Frame; 
               rd31(k(2)) = (traj.toa(3,i)-traj.toa(1,i))*config.c;
           end
           if traj.toa(4,i)
               k(3) = k(3)+1;
%                t41(k(3)) = traj.toa(1,i);
               t41(k(3)) = traj.all_poits(i).Frame; 
               rd41(k(3)) = (traj.toa(4,i)-traj.toa(1,i))*config.c;
           end
        end 
    end
    t0 = min([t21(1) t31(1) t41(1)]);
    plot((t21 - t0)*1,rd21,'.')
    hold on
    plot((t31 - t0)*1,rd31,'.')
    plot((t41 - t0)*1,rd41,'.')
    grid on
end

