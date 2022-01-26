function [flag, zav] = process_zav(zav, config)
    
    D_n = config.sigma_n^2;
    D_ksi = config.sigma_ksi^2;
    
    poits = zav.poits;
    filters = [];
    rd = [];
    rd_flags = [];
    t = [poits.Frame];
    for i = 1:length(poits)
        rd(:,i) = poits(i).rd;
        rd_flags(:,i) = poits(i).rd_flag;
    end
    
    for i = 1:6
        nums = find(rd_flags(i,:));
        rd_cur = rd(i,nums);
        if length(rd_cur) < 10
            flag = 0;
            return;
        end
        t_cur = t(nums);
        [RD, koef, order] = approx_rd(t_cur - t(1),rd_cur, 4);
        X = [RD(1,1); koef(2); 0];
        tf = t_cur(1);
        D_x = eye(3);
        for j = 1:length(t_cur)
            dt = t_cur(j) - tf;
            [X, D_x, discr] = Kalman_step_1D(rd_cur(j), X, D_x, dt, D_n, D_ksi);
            tf = t_cur(j);
        end
        filters(i).X = X;
        filters(i).D_x = D_x;
        filters(i).t_last = tf;
    end
    zav.filters = filters;
    flag = 1;
end

