function [RD, koef, i] = approx_rd(t,rd, orders)
%     koefs = zeros(orders+1);
%     figure(1)
%     grid on 
%     hold on
%    
%     
%     nums = find(rd ~= 0);
%     plot(t(nums),rd(nums),'kv-')
%     
%     T = t(nums) - t(1);
%     rd_ = rd(nums);
%     for i = 0:orders
%         [koef, sko] = mnk_step(T, rd_, i);
%         koefs(1:(i+1),i+1) = koef;
%         SKO(:,i+1) = [i;sko];
%         
% %         t1 = t(1):1:t(end);
%         t1 = 0:1:(t(end)-t(1));
%         RD = zeros(length(t1),1);
%         for k = 1:length(t1)
%             for j = 1:length(koefs(:,i+1))
%                 RD(k) = RD(k) + koefs(j,i+1) * t1(k)^(j - 1);
%             end
%         end
%         plot(t1 + t(1),RD,'linewidth',2)    
%         
%         
%     end
%     T = t1+t(1);
%     
%     
%     legend()
%     figure(2)
%     stem(SKO(1,:),SKO(2,:))
%     hold on

    koefs = zeros(orders+1);
    rds = zeros(length(rd),orders + 1);

    for i = 0:orders
        [koef, sko, RD] = mnk_step(t, rd, i);
        koefs(1:(i+1),i+1) = koef;
        SKO(:,i+1) = [i;sko];
        rds(:,i+1) = RD;
    end

    for i = 2:size(koefs,2)
        if abs(SKO(2,i) - SKO(2,i-1)) < 0.05
            break
        end
    end

    RD = rds(:,i);
    koef = koefs(:,i);
    
end

