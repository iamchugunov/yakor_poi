function [Xf] = modes_filter_t(poits)
    t = poits(1,:);
    y = poits([2 4 6],:);
    
    
    D_n = diag([30 30 10].^2);
    
    D_ksi = diag([5 5 5]/10.^2);
    
    
    X = [y(1,1); 
        (y(1,2) - y(1,1))/(t(2) - t(1));
        y(2,1); 
        (y(2,2) - y(2,1))/(t(2) - t(1));
        y(3,1); 
        (y(3,2) - y(3,1))/(t(2) - t(1));];
    
    Dx = eye(6);
    
    Xf(:,1) = X;
    
    for i = 2:length(y)
        dt = t(i) - t(i-1);
        
        F = [1 dt 0 0 0 0; 
             0 1  0 0 0 0;
             0 0 1 dt 0 0;
             0 0 0 1 0 0;
             0 0 0 0 1 dt;
             0 0 0 0 0 1];
        G = [0 0 0; 
             dt 0 0;
             0 0 0;
             0 dt 0;
             0 0 0;
             0 0 dt];
             
       
        
        
        X_ext = F * X;
        D_x_ext = F * Dx * F' + G * D_ksi * G';
        
        H = [1 0 0 0 0 0;
             0 0 1 0 0 0;
             0 0 0 0 1 0;];
        K = D_x_ext * H' * inv(H*D_x_ext*H' + D_n);
        Dx = D_x_ext - K * H * D_x_ext;
        y_ext = [X_ext([1 3 5])];
        X = X_ext + K*(y(:,i) - y_ext);
        
        Xf(:,i) = X;
    end
    
   
    
end



