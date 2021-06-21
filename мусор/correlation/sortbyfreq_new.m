function [OUT] = sortbyfreq_new(in)
    [a ind] = sort([in.freq]);
    nums = find(diff(a) > 5000);
    
    out = [];
    for i = 1:length(nums)
        if i == 1
            out(i).indx = ind(1:nums(i));
            continue
        end
        out(i).indx = ind(nums(i-1)+1:nums(i));
    end
    out(i+1).indx = ind(nums(end)+ 1:end);
    
    for i = 1:length(out)
        imps = in(out(i).indx);
        [a ind] = sort([imps.time]);
        imps = imps(ind);
        OUT(i).imps = imps;
        OUT(i).freq = mean([imps.freq]);
        
        
    end
end



