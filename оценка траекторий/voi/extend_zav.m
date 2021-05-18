function [zav] = extend_zav(zav)
    zav.T_start = zav.T_start * 2;
    zav.hard_start_flag = zav.hard_start_flag + 1; 
end

