function [] = plot_frames(Frames,nums)
    figure()
    hold on
    grid on
    for j = 1:length(nums)
        for i = 1:length(Frames(nums(j)).Post1)
            plot_imp(Frames(nums(j)).Post1(i), 'b')
        end
        for i = 1:length(Frames(nums(j)).Post2)
            plot_imp(Frames(nums(j)).Post2(i), 'r')
        end
        for i = 1:length(Frames(nums(j)).Post3)
            plot_imp(Frames(nums(j)).Post3(i), 'g')
        end
        for i = 1:length(Frames(nums(j)).Post4)
            plot_imp(Frames(nums(j)).Post4(i), 'c')
        end
        
    end
end

