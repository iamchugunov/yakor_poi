function [ready_flag, zav] = zav_add_poit(zav, poit, config)
    
    zav.p_count = zav.p_count + 1;
    zav.t_current = poit.Frame;
    zav.lifetime = zav.t_current - zav.t0;
    zav.poits(zav.p_count) = poit;
    zav.freqs(zav.p_count) = poit.freq;
    
    zav.freq = (zav.freq * (zav.p_count - 1) + poit.freq)/zav.p_count;
    
    if (zav.Smode == -1) && (poit.Smode ~= -1)
        zav.Smode = poit.Smode;
    end
       
    if poit.count == 4
        zav.last_4 = poit; 
        zav.last_4_flag = 1; 
    end
    
    for i = 1:6
        if poit.rd_flag(i)
            zav.rd(i) = poit.rd(i);
        end
    end
    
    
    if zav.t_current - zav.t0 > zav.T_nak
        ready_flag = 1;
    else
        ready_flag = 0;
    end
    
end



