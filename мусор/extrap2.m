function [to, Xo] = extrap2(Xf, traj)
    t_cur = traj(1,1);
    
    current_sv = Xf(:,1);
    cur_i = 1;
    dt = 0;
    k = 1;
    Xo(:,1) = Xf(:,1);
    to(:,1) = traj(1,1);
    for i = 1:(size(traj,2)-1)
        
        while t_cur + dt < traj(1,i+1)
            dt = dt + 1;
            k = k + 1;
            Xo(1,k) = Xf(1,i) + Xf(2,i) * dt;
            Xo(2,k) = Xf(2,i);
            Xo(3,k) = Xf(3,i) + Xf(4,i) * dt;
            Xo(4,k) = Xf(4,i);
            Xo(5,k) = Xf(5,i) + Xf(6,i) * dt;
            Xo(6,k) = Xf(6,i);
            to(1,k) = t_cur + dt;
        end
        t_cur = traj(1,i+1);
        k = k + 1;
        to(1,k) = t_cur;
        Xo(:,k) = Xf(:,i+1);
        dt = 0;
    end
end

