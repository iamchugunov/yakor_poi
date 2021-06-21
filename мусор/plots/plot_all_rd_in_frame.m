function [] = plot_all_rd_in_frame(time,RD)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

for j = 1:length(RD)
    if(RD(j)~=0)
        plot(time,RD(j),'.')
    end
end

end

