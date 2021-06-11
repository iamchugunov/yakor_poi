function [OUT] = sortbyfreq(post)
    [a ind] = sort([post.freq]);
    nums = find(diff(a) > 5000);
    if isempty(nums)
        out = [];
        OUT.imps = post;
        OUT.freq = mean([post.freq]);
        return
    end
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
        imps = post(out(i).indx);
        [a ind] = sort([imps.uT]);
        imps = imps(ind);
        OUT(i).imps = imps;
        OUT(i).freq = mean([imps.freq]);
        OUT(i).imps(1).period = 0;
        for j = 2:length(imps)
            OUT(i).imps(j).period = OUT(i).imps(j).T - OUT(i).imps(j-1).T;
        end
    end
end

