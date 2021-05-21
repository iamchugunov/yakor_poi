function [mod_frames] = generate_sorted_imp(frame, config)

    [OUT1] = sortbyfreq(frame.Post1);
    [OUT2] = sortbyfreq(frame.Post2);
    [OUT3] = sortbyfreq(frame.Post3);
    [OUT4] = sortbyfreq(frame.Post4);
    %%
    freqs = [];
    for i = 1:length(OUT1)
        freqs = [freqs OUT1(i).freq];
    end
    for i = 1:length(OUT2)
        freqs = [freqs OUT2(i).freq];
    end
    for i = 1:length(OUT3)
        freqs = [freqs OUT3(i).freq];
    end
    for i = 1:length(OUT4)
        freqs = [freqs OUT4(i).freq];
    end
    [a ind] = sort(freqs);
    nums = find(diff(a) > 5000);
    
    freq = [];
    for i = 1:length(nums)
        if i == 1
            freq(i) = mean(freqs(ind(1:nums(i))));
            continue
        end
        freq(i) = mean(freqs(ind(nums(i-1)+1:nums(i))));
    end
    freq(i+1) = mean(freqs(ind(nums(end)+ 1:end)));
    %%
    mod_frames = [];
    
    parfor i = 1:length(freq)
        mod_frames(i).time = frame.time;
        mod_frames(i).freq = freq(i);
        mod_frames(i).Post1 = [];
        mod_frames(i).Post2 = [];
        mod_frames(i).Post3 = [];
        mod_frames(i).Post4 = [];
        for j = 1:length(OUT1)
            if abs(freq(i) - OUT1(j).freq) < 5000
                mod_frames(i).Post1 = OUT1(j).imps;
                break
            end
        end
        for j = 1:length(OUT2)
            if abs(freq(i) - OUT2(j).freq) < 5000
                mod_frames(i).Post2 = OUT2(j).imps;
                break
            end
        end
        for j = 1:length(OUT3)
            if abs(freq(i) - OUT3(j).freq) < 5000
                mod_frames(i).Post3 = OUT3(j).imps;
                break
            end
        end
        for j = 1:length(OUT4)
            if abs(freq(i) - OUT4(j).freq) < 5000
                mod_frames(i).Post4 = OUT4(j).imps;
                break
            end
        end
    end
end

