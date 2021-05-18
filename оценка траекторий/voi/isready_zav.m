function [flag] = isready_zav(zav)
    flag = zav.t_last - zav.t0 > zav.T_start || zav.count > 200;
end

