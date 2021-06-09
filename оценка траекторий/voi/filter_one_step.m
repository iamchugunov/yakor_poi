function [fil] = filter_one_step(fil, X, t, Dn)
    [Xnew, Dxnew, discr] = Kalman_step_3D(X, fil.cur_SV, fil.Dx, t - fil.t_last, Dn, fil.Dksi);
    if norm(discr([1 4 7])) > 0.5e4 || traj_is_ok(Xnew) == 0
        fil.skipped = fil.skipped + 1;
    else
        fil.skipped = 0;
        fil.count = fil.count + 1;
        fil.cur_SV = Xnew;
        fil.Dx = Dxnew;
        fil.SV(:,fil.count) = Xnew;
        fil.nev(:,fil.count) = discr;
        fil.nev_all(:,fil.count) = norm(discr);
        fil.nev_coords(:,fil.count) = norm(discr([1 4 7]));
        fil.t_last = t;
        fil.timestamps(:,fil.count) = t;
    end
end

