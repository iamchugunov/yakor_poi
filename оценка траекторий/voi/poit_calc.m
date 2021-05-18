function [poit] = poit_calc(poit, X0, config)
    hei = 0:1000:15000;
    if poit.count == 4
        [cord, flag] = coord_solver_2D_h(poit.ToA*config.c, config.posts, X0([1 2 4]), hei);
        if flag
            poit.coords = cord;
            poit.xy_valid = flag;
        end
        return;
    elseif poit.count == 3
        nums = find(poit.ToA > 0);
        [cord, dop, nev, flag] = coord_solver2D(poit.ToA(nums')*config.c, config.posts(:,nums'), X0([1 2 4]), X0(3));
        if flag
            X = [cord(1); cord(2); X0(3); cord(3)];
            if norm(X(1:2) - X0(1:2)) < 10000
                poit.coords = X;
                poit.xy_valid = flag;
            end
        end
        return;
    end
        
end

