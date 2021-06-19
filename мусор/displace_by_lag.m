function [out,t] = displace_by_lag(imp,lag)
% out = zeros(1,length(imp)+lag-1);
% nums = find(imp==1);
% nums = nums+lag;
% out = imps(nums);
if(lag>0)
    t = 1:length(imp)+lag;
    out = [zeros(1,fix(abs(lag))) imp];
else
    t = lag:1:length(imp)-1;
    out = [imp zeros(1,fix(abs(lag)))];
    
end

% if(lag>0)
%     for i=1:length(out)
%         out(i) = imp(i+lag);
%     end
% else
%     for i=
% end

end