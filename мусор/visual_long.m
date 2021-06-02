function [] = visual_long(traj, config, mode)
    plot3(config.posts(1,:),config.posts(2,:),config.posts(3,:),'v')
    hold on
    grid on
    for i = 1:length(traj)
        if mode == 2
            plot3(traj(i).fil2.SV(1,:),traj(i).fil2.SV(4,:),traj(i).fil2.SV(7,:),'.-')
            text(traj(i).fil2.SV(1,1),traj(i).fil2.SV(4,1),traj(i).fil2.SV(7,1),num2str(i))
        end
        if mode == 1
            plot3(traj(i).fil1.SV(1,:),traj(i).fil1.SV(4,:),traj(i).fil1.SV(7,:),'.-')
            text(traj(i).fil1.SV(1,1),traj(i).fil1.SV(4,1),traj(i).fil1.SV(7,1),num2str(i))
        end
    end
end

