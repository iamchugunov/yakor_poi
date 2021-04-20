function [t, X1, X2, X3, X3f] = test_cord_solv(zav, T1, T2, config)
    
    %завязка
    t0 = zav.poits(1).Frame;
    M = find([zav.poits.Frame] - t0 > T1);
    M = M(1) - 1;
    if M > 200
        M = 200;
    end
    y = zav.poits(1:M);
    k = 1;
    [t(k), X1(:,k), X2(:,k), X3(:,k), R3] = one_step_interp(y, config);
    N = M + 1;
    
    
    D_x = eye(9);
    X3f(:,k) = X3(:,k);
    %фильтрация
    while 1
        t0 = zav.poits(N).Frame;
        M = find([zav.poits.Frame] - t0 > T2);
        if isempty(M)
            break;
        end
        
        y = zav.poits(N:M(1)-1);
        N = M(1);
        k = k + 1;
        [t(k), X1(:,k), X2(:,k), X3(:,k), R3] = one_step_interp(y, config, [X3([1 4 7],k-1); 1000]);
        d4 = inv(-R3);
        D3(:,k) = [d4(1,1); d4(2,2); d4(3,3); d4(4,4); d4(5,5); d4(6,6); d4(7,7); d4(8,8); d4(9,9)];
        D_n = diag(D3(:,k));
        D_ksi = diag([0.1 0.1 0.1].^2);
        [X3f(:,k), D_x] = Kalman_step_3D(X3(:,k), X3f(:,k-1), D_x, t0 -, D_n, D_ksi);
    end
    
end

