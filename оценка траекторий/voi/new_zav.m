function [zav] = new_zav(poit)
    zav.count = 0;
    zav.t0 = poit.Frame;
    zav.t_last = [];
    zav.ID = -1;
    zav.poits = poit;
    zav.last_4 = poit;
    zav.last_4_flag = 0;
    zav.ToA = [];
    zav.freq = [];
    zav.lifetime = 0;
end

