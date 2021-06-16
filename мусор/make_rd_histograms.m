function [rd_hists] = make_rd_histograms(rd_frames)
    rd_hists.RD21(1).count = [];
    rd_hists.RD21(1).mean_rd = [];
    rd_hists.RD21(1).rd = [];
    rd_hists.RD21(1).t = [];
    
    rd_hists.RD31(1).count = [];
    rd_hists.RD31(1).mean_rd = [];
    rd_hists.RD31(1).rd = [];
    rd_hists.RD31(1).t = [];
    
    rd_hists.RD41(1).count = [];
    rd_hists.RD41(1).mean_rd = [];
    rd_hists.RD41(1).rd = [];
    rd_hists.RD41(1).t = [];
    
    rd_hists.RD32(1).count = [];
    rd_hists.RD32(1).mean_rd = [];
    rd_hists.RD32(1).rd = [];
    rd_hists.RD32(1).t = [];
    
    rd_hists.RD42(1).count = [];
    rd_hists.RD42(1).mean_rd = [];
    rd_hists.RD42(1).rd = [];
    rd_hists.RD42(1).t = [];
    
    rd_hists.RD43(1).count = [];
    rd_hists.RD43(1).mean_rd = [];
    rd_hists.RD43(1).rd = [];
    rd_hists.RD43(1).t = [];
    
    for i = 1:length(rd_frames)
        
        if rd_frames(i).RD21(1) ~= 0
            for j = 1:length(rd_frames(i).RD21)
                wei = length(rd_frames(i).RD21) - j + 1;
                if j == 1
                    wei = 3;
                elseif j == 2
                    wei = 2;
                else
                    wei = 1;
                end
%                 wei = 1;
                rd_hists.RD21 = add_new_rd(rd_hists.RD21, rd_frames(i).RD21(j), rd_frames(i).time, wei);
            end
        end
        
        if rd_frames(i).RD31(1) ~= 0
            for j = 1:length(rd_frames(i).RD31)
                wei = length(rd_frames(i).RD31) - j + 1;
                if j == 1
                    wei = 3;
                elseif j == 2
                    wei = 2;
                else
                    wei = 1;
                end
%                 wei = 1;
                rd_hists.RD31 = add_new_rd(rd_hists.RD31, rd_frames(i).RD31(j), rd_frames(i).time, wei);
            end
        end
        
        if rd_frames(i).RD41(1) ~= 0
            for j = 1:length(rd_frames(i).RD41)
                wei = length(rd_frames(i).RD41) - j + 1;
                if j == 1
                    wei = 3;
                elseif j == 2
                    wei = 2;
                else
                    wei = 1;
                end
%                 wei = 1;
                rd_hists.RD41 = add_new_rd(rd_hists.RD41, rd_frames(i).RD41(j), rd_frames(i).time, wei);
            end
        end
        
        if rd_frames(i).RD32(1) ~= 0
            for j = 1:length(rd_frames(i).RD32)
                wei = length(rd_frames(i).RD32) - j + 1;
                if j == 1
                    wei = 3;
                elseif j == 2
                    wei = 2;
                else
                    wei = 1;
                end
%                 wei = 1;
                rd_hists.RD32 = add_new_rd(rd_hists.RD32, rd_frames(i).RD32(j), rd_frames(i).time, wei);
            end
        end
        
        if rd_frames(i).RD42(1) ~= 0
            for j = 1:length(rd_frames(i).RD42)
                wei = length(rd_frames(i).RD42) - j + 1;
                if j == 1
                    wei = 3;
                elseif j == 2
                    wei = 2;
                else
                    wei = 1;
                end
%                 wei = 1;
                rd_hists.RD42 = add_new_rd(rd_hists.RD42, rd_frames(i).RD42(j), rd_frames(i).time, wei);
            end
        end
        
        if rd_frames(i).RD43(1) ~= 0
            for j = 1:length(rd_frames(i).RD43)
                wei = length(rd_frames(i).RD43) - j + 1;
                if j == 1
                    wei = 3;
                elseif j == 2
                    wei = 2;
                else
                    wei = 1;
                end
%                 wei = 1;
                rd_hists.RD43 = add_new_rd(rd_hists.RD43, rd_frames(i).RD43(j), rd_frames(i).time, wei);
            end
        end
        
    end
    
    
    rd_hists.RD21(1) = [];
    rd_hists.RD31(1) = [];
    rd_hists.RD41(1) = [];
    rd_hists.RD32(1) = [];
    rd_hists.RD42(1) = [];
    rd_hists.RD43(1) = [];

end

function RD = add_new_rd(RD, rd, t_frame, wei)
    match_flag = 0;
    for i = 1:length(RD)
        try
            if abs(RD(i).rd(end) - rd) < 250
                match_flag = 1;
                for j = 1:wei
                    RD(i).count = RD(i).count + 1;
                    RD(i).rd(RD(i).count) = rd;
                    RD(i).t(RD(i).count) = t_frame;
                    RD(i).mean_rd = mean(RD(i).rd);
                end
        end
        end
    end
    
    if match_flag == 0
        RD(end+1).count = 0;
        for j = 1:wei
            RD(end).count = RD(end).count + 1;
            RD(end).rd(RD(end).count) = rd;
            RD(end).t(RD(end).count) = t_frame;
            RD(end).mean_rd = mean(RD(end).rd);
        end
    end
end

