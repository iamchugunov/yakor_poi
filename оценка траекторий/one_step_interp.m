function [t0, X1, X2, X3, R3] = one_step_interp(poits, config, X0)
    t0 = poits(1).Frame;
    y = zeros(4,length(poits));
    for i = 1:length(poits)
        nums = find(poits(i).ToA > 0);
        y(nums,i) = poits(i).ToA(nums) + (poits(i).Frame - t0)*1e9;
    end
    
    if nargin == 2
    [X1, hei, flag] = make_first_estimation(y, config);
    else
    [X1, hei, flag] = make_first_estimation(y, config, X0);
    end
    
    [X2, R2, nev] = max_likelyhood_2dv(y, config, [X1(1) X1(2) 0 X1(3) X1(4) 0 hei 0 0]');
    X2 = X2([1 2 4 5]);

    [X3, R3, nev] = max_likelyhood_3Da(y, config, [X1(1) X1(2) 0 X1(3) X1(4) 0 hei 0 0]');
    X3 = X3(1:9);
    
end

