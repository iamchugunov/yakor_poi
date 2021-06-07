[lags_at_max_corr12] = sortbylag(x12_T,lags12_T);
[lags_at_max_corr13] = sortbylag(x13_T,lags13_T);
[lags_at_max_corr14] = sortbylag(x14_T,lags14_T);
kk =0;
for i=1:length(lags_at_max_corr12)
    for j=1:length(lags_at_max_corr13)
        for k=1:length(lags_at_max_corr14)
            RD = [lags_at_max_corr12(i);lags_at_max_corr13(j);lags_at_max_corr14(k)];
            [UserPos,dX] = NavSolver_RD(config.PostsENU, RD./1e9.*config.c, [0;0;0]);
            if norm(dX) < 1e-9
                kk = kk + 1;
                XX(:,kk) = UserPos;
                nev(kk) = norm(dX);
            end
        end
    end
end