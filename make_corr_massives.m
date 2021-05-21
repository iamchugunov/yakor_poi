function [a1, a2, a3, a4] = make_corr_massives(frame, config)
    t = 0:1:12000000;
    
    a1 = zeros(1,length(t));
    for i = 1:length(frame.Post1)
        if frame.Post1(i).freq > 1090000
            a1(frame.Post1(i).uT) = frame.Post1(i).uT;
        end
    end
    
    a2 = zeros(1,length(t));
    for i = 1:length(frame.Post2)
        if frame.Post2(i).freq > 1090000
            a2(frame.Post2(i).uT) = frame.Post2(i).uT;
        end
    end
    
    a3 = zeros(1,length(t));
    for i = 1:length(frame.Post3)
        if frame.Post3(i).freq > 1090000
            a3(frame.Post3(i).uT) = frame.Post3(i).uT;
        end
    end
    
    a4 = zeros(1,length(t));
    for i = 1:length(frame.Post4)
        if frame.Post4(i).freq > 1090000
            a4(frame.Post4(i).uT) = frame.Post4(i).uT;
        end
    end
end

