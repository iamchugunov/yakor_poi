function [norm_E] = norm_Euc(imp1,imp2, flag)
    switch flag
        case 0 %dur,freq
            norm_E = sqrt((imp1.dur-imp2.dur)^2/max(imp1.dur,imp2.dur) + (imp1.freq-imp2.freq)^2/max(imp1.freq,imp2.freq));
        case 1 %dur,freq,amp
            norm_E = sqrt((imp1.dur-imp2.dur)^2/max(imp1.dur,imp2.dur) + (imp1.freq-imp2.freq)^2/max(imp1.freq,imp2.freq)+(imp1.amp-imp2.amp)^2/max(imp1.amp,imp2.amp));
        case 2 %dur,freq,per
            norm_E = sqrt((imp1.dur-imp2.dur)^2/max(imp1.dur,imp2.dur) + (imp1.freq-imp2.freq)^2/max(imp1.freq,imp2.freq)+(imp1.period-imp2.period)^2/max(imp1.period,imp2.period));
        case 3 %dur,freq,amp,per
            norm_E = sqrt((imp1.dur-imp2.dur)^2/max(imp1.dur,imp2.dur) + (imp1.freq-imp2.freq)^2/max(imp1.freq,imp2.freq)+(imp1.amp-imp2.amp)^2/max(imp1.amp,imp2.amp)+(imp1.period-imp2.period)^2/max(imp1.period,imp2.period));
    end
end

