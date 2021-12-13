function [rdf] = process_rd(rd, dn, q)

    nums = find(~isnan(rd(2,:)));
    RD = rd(:,nums);
    
    i = 2;
    while i <= size(RD,2)
        if RD(1,i) - RD(1,i-1) == 0
            RD(2,i-1) = (RD(2,i-1) + RD(2,i))/2;
            RD(:,i) = [];
            i = i - 1;
        end
        i = i + 1;
    end
    
    X = [RD(2,1);(RD(2,10) - RD(2,1))/(RD(1,10) - RD(1,1))];
    
    Dx = eye(2);
    
    sigma_n = dn;
    sigma_ksi = q;
    D_ksi = eye(1) * sigma_ksi^2;
    D_n = eye(1) * sigma_n^2;
    
    rdf1(:,1) = [RD(1,1);RD(2,1);0];
    
    for i = 2:length(RD)
        dt = RD(1,i) - RD(1,i-1);
        y = RD(2,i);
        F = [1 dt; 0 1];
        G = [0; dt];
        H = [1 0];
        
        X_ext = F * X;
        D_x_ext = F * Dx * F' + G * D_ksi * G';
        K = D_x_ext * H' * inv(H*D_x_ext*H' + D_n);
        Dx = D_x_ext - K * H * D_x_ext;
        X = X_ext + K*(y - H*X_ext);
        
        rdf1(:,i) = [RD(1,i); X];
        
    end
    
    
    X = [RD(2,end);(RD(2,end-10) - RD(2,end))/(RD(1,end-10) - RD(1,end))];
    
    Dx = eye(2);
    
    D_ksi = eye(1) * sigma_ksi^2;
    D_n = eye(1) * sigma_n^2;
    
    rdf2 = rdf1 * 0;
    rdf2(:,end) = [RD(1,end);RD(2,end);0];
    
    for i = length(RD)-1:-1:1
        dt = RD(1,i) - RD(1,i+1);
        y = RD(2,i);
        F = [1 dt; 0 1];
        G = [0; dt];
        H = [1 0];
        
        X_ext = F * X;
        D_x_ext = F * Dx * F' + G * D_ksi * G';
        K = D_x_ext * H' * inv(H*D_x_ext*H' + D_n);
        Dx = D_x_ext - K * H * D_x_ext;
        X = X_ext + K*(y - H*X_ext);
        
        rdf2(:,i) = [RD(1,i); X];
        
    end
    
    rdf = 0.5*(rdf1 + rdf2);
    
end

