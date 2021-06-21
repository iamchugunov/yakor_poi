function [flags, deltas] = check_rd_arr(rd)

    thres = 300;
    delta = abs(rd(2) - rd(4) - rd(1));
    if delta < thres
        flags(1,1) = 1;
    else
        flags(1,1) = 0;
    end
    deltas(1,1) = delta;
    
    delta = abs(rd(3) - rd(5) - rd(1));
    if delta < thres
        flags(2,1) = 1;
    else
        flags(2,1) = 0;
    end
    deltas(2,1) = delta;
    
    delta = abs(rd(3) - rd(6) - rd(2));
    if delta < thres
        flags(3,1) = 1;
    else
        flags(3,1) = 0;
    end
    deltas(3,1) = delta;
    
    delta = abs(rd(5) - rd(6) - rd(4));
    if delta < thres
        flags(4,1) = 1;
    else
        flags(4,1) = 0;
    end
    deltas(4,1) = delta;
end

