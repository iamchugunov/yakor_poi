function [] = visual_rd(traj, config)
    k = [0;0;0];
    for i = 1:length(traj.toa)
        if traj.toa(1,i)
           if traj.toa(2,i)
               k(1) = k(1)+1;
               t21(k(1)) = traj.toa(1,i);
               rd21(k(1)) = (traj.toa(2,i)-traj.toa(1,i))*config.c;
           end
           if traj.toa(3,i)
               k(2) = k(2)+1;
               t31(k(2)) = traj.toa(1,i);
               rd31(k(2)) = (traj.toa(3,i)-traj.toa(1,i))*config.c;
           end
           if traj.toa(4,i)
               k(3) = k(3)+1;
               t41(k(3)) = traj.toa(1,i);
               rd41(k(3)) = (traj.toa(4,i)-traj.toa(1,i))*config.c;
           end
        end 
    end
    plot(t21,rd21,'.')
    hold on
    plot(t31,rd31,'.')
    plot(t41,rd41,'.')
    grid on
end

