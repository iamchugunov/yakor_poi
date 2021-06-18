function [] = plot_rd_hist(rd_hist)
    
    subplot(231)
    hold on
    grid on
    plot_rd(rd_hist.RD21)
    
    subplot(232)
    hold on
    grid on
    plot_rd(rd_hist.RD31)
    
    subplot(233)
    hold on
    grid on
    plot_rd(rd_hist.RD41)
    
    subplot(234)
    hold on
    grid on
    plot_rd(rd_hist.RD32)
    
    subplot(235)
    hold on
    grid on
    plot_rd(rd_hist.RD42)
    
    subplot(236)
    hold on
    grid on
    plot_rd(rd_hist.RD43)

end

function [] = plot_rd(rd)
    for i = 1:length(rd)
        plot(rd(i).time, rd(i).rd,'.-')
%     stem(rd(i).mean_rd, rd(i).count)
    end
end



