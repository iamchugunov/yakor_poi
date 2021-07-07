for i = 1:length(out3)
    if out3(i).RD42(1) ~= 0
%         for j = 1:length(out3(i).RD43)
        for j = 1:1
        hold on
        plot(out3(i).time,out3(i).RD42(j),'r.')
        end
    end
end