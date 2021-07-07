function [] = plot_rd(rd)
    for i = 1:length(rd)
        plot(rd(i).time,rd(i).rd)
    end
    legend()
end

