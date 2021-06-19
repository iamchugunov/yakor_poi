function [max_rd] = find_max_rd(rd_hists)

    [m, n] = max([rd_hists.RD21.count]);
    max_rd(1,1) = rd_hists.RD21(n).mean_rd;
    
    [m, n] = max([rd_hists.RD31.count]);
    max_rd(2,1) = rd_hists.RD31(n).mean_rd;
    
    [m, n] = max([rd_hists.RD41.count]);
    max_rd(3,1) = rd_hists.RD41(n).mean_rd;
    
    [m, n] = max([rd_hists.RD32.count]);
    max_rd(4,1) = rd_hists.RD32(n).mean_rd;
    
    [m, n] = max([rd_hists.RD42.count]);
    max_rd(5,1) = rd_hists.RD42(n).mean_rd;
    
    [m, n] = max([rd_hists.RD43.count]);
    max_rd(6,1) = rd_hists.RD43(n).mean_rd;
end

