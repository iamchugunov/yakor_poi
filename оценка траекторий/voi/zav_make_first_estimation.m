function [flag, zav] = zav_make_first_estimation(zav, config)
    
    if zav.count < 10
        flag = 0;
        zav = zav_extend(zav);
        return;
    end
    
    indx = find([zav.poits.xy_valid]);
    
    if length(indx)
        flag = 1;
        X0 = zav.poits(indx(1)).coords;
        for i = indx(1):-1:1
            if zav.poits(i).count == 3
                X0(4) = max(zav.poits(i).ToA) * config.c;
                zav.poits(i) = poit_calc(zav.poits(i), X0, config);
                if zav.poits(i).xy_valid
                    X0 = zav.poits(i).coords;
                end
            end
        end
    else
        disp('Нет четверок')
        flag = 0;
        zav = zav_extend(zav);
        return;
    end
    
    if flag
        [X, X1, D] = zav_approx(zav, config);
        zav.SV_approx = X;
        zav.SV_interp = X1;
        zav.DispMatrix = D;
    end
       
    
end

