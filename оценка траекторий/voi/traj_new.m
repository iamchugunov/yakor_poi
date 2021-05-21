function [traj] = traj_new(zav, config)
    traj.all_poits_count = zav.count;
    traj.current_points_count = 0;
    traj.estimations_count = 1;
    traj.current_SV_approx = zav.SV_approx;
    traj.current_SV_interp = zav.SV_interp;
    traj.SV_approx = zav.SV_approx;
    traj.SV_interp = zav.SV_interp;
    traj.timestamps = zav.t0;
    traj.t0 = zav.t0;
    traj.current_t0 = zav.t_last;
    traj.t_last_estimation = zav.t0;
    traj.t_last_poit = zav.t_last;
    traj.ID = zav.ID;
    traj.all_poits = zav.poits;
    traj.last_4 = zav.last_4;
    traj.last_4_flag = zav.last_4_flag;
    traj.last_4_cord = zav.last_4_cord;
    traj.xy_valid = zav.xy_valid;
    traj.all_ToA = zav.ToA;
    traj.ToA = [];
    traj.freq = zav.freq;
    traj.lifetime = zav.lifetime;
    traj.T_nak = config.traj_T_nak;

    figure(1)
    traj.t1 = plot(zav.last_4_cord(1,:),zav.last_4_cord(2,:),'x');
    traj.t2 = text(zav.last_4_cord(1,:),zav.last_4_cord(2,:),num2str(traj.ID));
    pause(0.01)

end

