function [flag, zav] = make_first_estimation_zav(zav, config)
    
    if zav.count < 10
        flag = 0;
        zav = extend_zav(zav);
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
    end
    
    if flag
        [X] = zav_approx(zav, config);
    end
       
    
end

