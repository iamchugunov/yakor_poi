function [X] = plot_interp(traj, config)
    SV = traj.fil1.SV;
    T = traj.fil1.timestamps;
    
    k = 0;
    for i = 1:length(T)-1
        t = 0;
        while t < T(i + 1) - T(i)
            k = k + 1;
            X(:,k) = SV([1 4 7],i) + SV([2 5 8],i) * t + SV([3 6 9],i) * t^2/2;
            t = t + 1;
        end
    end
    
end

