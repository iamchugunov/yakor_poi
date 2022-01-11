function [RD] = approx_rd(t,rd, orders)
    koefs = zeros(orders+1);
    figure(1)
    grid on 
    hold on
    
    nums = find(rd ~= 0);
    T = t(nums) - t(1);
    rd_ = rd(nums);
    for i = 0:orders
        [koef, sko] = mnk_step(T, rd_, i);
        koefs(1:(i+1),i+1) = koef;
        SKO(:,i+1) = [i;sko];
        
%         t1 = t(1):1:t(end);
        t1 = 0:1:(t(end)-t(1));
        RD = zeros(length(t1),1);
        for k = 1:length(t1)
            for j = 1:length(koefs(:,i+1))
                RD(k) = RD(k) + koefs(j,i+1) * t1(k)^(j - 1);
            end
        end
        plot(t1 + t(1),RD,'linewidth',2)    
        
        
    end
    
    plot(t(nums),rd(nums),'kv-')
    legend()
    figure(2)
    stem(SKO(1,:),SKO(2,:))
    hold on
    
end

