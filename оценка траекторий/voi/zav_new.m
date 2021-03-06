function [zav] = zav_new(poit, config)
    zav.count = 0;
    zav.t0 = poit.Frame;
    zav.t_last = [];
    zav.ID = -1;
    zav.poits = poit;
    zav.last_4 = poit;
    zav.last_4_flag = 0;
    zav.last_4_cord = zeros(4,1);
    zav.xy_valid = 0;
    zav.ToA = [];
    zav.freq = [];
    zav.lifetime = 0;
    zav.T_start_default = config.traj_T_start;
    zav.T_start = zav.T_start_default;
    zav.hard_start_flag = 0;
    if poit.xy_valid
        zav.last_4_cord = poit.coords;
        zav.xy_valid = 1;
    end
    zav.SV_approx = [];
    zav.SV_interp = [];
    zav.DispMatrix = [];
    zav.dop = [];
        
end

