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
    
    for i = 1:zav.count
        zav.dop(i) = zav.poits(i).dop;
    end
    zav.dop = median(zav.dop(find(zav.dop)));
    
    if zav.dop < 20
        flag = 1;
    elseif zav.dop < 100
        if zav.T_start == zav.T_start_default * 2
            flag = 1;
        else
            zav.T_start = zav.T_start_default * 2;
            flag = 0;
        end
    else
        if zav.T_start == zav.T_start_default * 3
            flag = 1;
        else
            zav.T_start = zav.T_start_default * 3;
            flag = 0;
        end
    end
    
    if flag
        [X, X1, D] = zav_approx(zav, config);
        flag1 = zav_is_ok(X);
        flag2 = zav_is_ok(X1);
        
        if flag1 == 0 && flag2 == 0
            flag = 0;
            zav = zav_extend(zav);
            return;
        elseif flag1 == 1 && flag2 == 0
            X1 = X;
            D = eye(9);
            D(1,1) = 100^2;
            D(4,4) = 100^2;
            D(7,7) = 100^2;
        elseif flag1 == 0 && flag2 == 1
            X = X1;
        end
            
        zav.SV_approx = X;
        zav.SV_interp = X1;
        zav.DispMatrix = D;
        
        
    end
       
    
end

