function [nums3, nums4] = find3or4(Frames)
    nums3 = [];
    nums4 = [];
    for i = 1:length(Frames)
        k = 0;
        if length(Frames(i).Post1) > 100
            k = k + 1;
        end
        if length(Frames(i).Post2) > 100
            k = k + 1;
        end
        if length(Frames(i).Post3) > 100
            k = k + 1;
        end
        if length(Frames(i).Post4) > 100
            k = k + 1;
        end
        if k == 3
            nums3 = [nums3 i];
        elseif k == 4
            nums4 = [nums4 i];
        end
    end
end

