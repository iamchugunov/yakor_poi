function [] = plot_all_ARdb_rd(ARdb,out3_peaks,RD)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
figure()
hold on
switch RD
    case '21'
        for i = 1:length(out3_peaks)
            plot_all_rd_in_frame(out3_peaks(i).time,out3_peaks(i).RD21)
        end
        for i = 1:length(ARdb.RD21)
            for j = 1:ARdb.RD21(i).count
                plot(ARdb.RD21(i).time(j),ARdb.RD21(i).rd(j),'-o')
            end
        end
        
    case '31'
        for i = 1:length(out3_peaks)
            plot_all_rd_in_frame(out3_peaks(i).time,out3_peaks(i).RD31)
        end
        for i = 1:length(ARdb.RD31)
            plot(ARdb.RD31(i).time,ARdb.RD31(i).rd,'-o')
        end
    case '41'
        for i = 1:length(out3_peaks)
            plot_all_rd_in_frame(out3_peaks(i).time,out3_peaks(i).RD41)
        end
        for i = 1:length(ARdb.RD41)
            plot(ARdb.RD41(i).time,ARdb.RD41(i).rd,'-o')
        end
    case '32'
        for i = 1:length(out3_peaks)
            plot_all_rd_in_frame(out3_peaks(i).time,out3_peaks(i).RD32)
        end
        for i = 1:length(ARdb.RD32)
            plot(ARdb.RD32(i).time,ARdb.RD32(i).rd,'-o b')
        end
    case '42'
        for i = 1:length(out3_peaks)
            plot_all_rd_in_frame(out3_peaks(i).time,out3_peaks(i).RD42)
        end
        for i = 1:length(ARdb.RD42)
            for j = 1:ARdb.RD42(i).count
                plot(ARdb.RD42(i).time(j),ARdb.RD42(i).rd(j),'-o b')
            end
        end
    case '43'
        for i = 1:length(out3_peaks)
            plot_all_rd_in_frame(out3_peaks(i).time,out3_peaks(i).RD43)
        end
        for i = 1:length(ARdb.RD43)
%             for j = 1:ARdb.RD43(i).count
                plot(ARdb.RD43(i).time,ARdb.RD43(i).rd,'-o b')
%             end
        end
end


end

