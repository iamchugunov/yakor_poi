function [zav] = zav_add_poit(zav, poit)
    zav.count = zav.count + 1;
    
    zav.t_last = poit.Frame;
    ToA = zeros(4,1);
    nums = find(poit.ToA > 0);
    ToA(nums) = poit.ToA(nums) + (zav.t_last - zav.t0)*1e9;
    zav.poits(zav.count) = poit;
    zav.ToA(:,zav.count) = ToA;
    zav.freq(:,zav.count) = poit.freq;
    if (zav.ID == -1) && (poit.Smode ~= -1)
        zav.ID = poit.Smode;
    end
    if poit.count == 4
        zav.last_4 = poit;
        zav.last_4_flag = 1;
    end
    zav.lifetime = zav.t_last - zav.t0;
    if poit.xy_valid
        zav.last_4_cord = poit.coords;
        zav.xy_valid = 1;
    end
end

