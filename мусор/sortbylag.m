function [out] = sortbylag(corr,lags)
%     [a ind] = sort(lag);
% функция находит центры пиков корреляции и возвращает значение лагов.
    thres = max(corr)/2;
    nums_th = find(corr > thres);
    lags_max = lags(nums_th);
    nums = find(diff(lags_max) > 10);
    out(1) = mean(lags_max(1:nums(1)));
    for i=2:length(nums)
        out(i) = mean(lags_max(nums(i-1)+1:nums(i)));
    end
    out(i+1) = mean(lags_max(nums(i)+1:end));
end