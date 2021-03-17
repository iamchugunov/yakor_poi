function [data] = make_hist(Frame,para, config)
    switch para
        case '21'
            T = config.ranges.r21;
            post1 = Frame.Post2;
            post2 = Frame.Post1;
        case '31'
            T = config.ranges.r31;
            post1 = Frame.Post3;
            post2 = Frame.Post1;
        case '41'
            T = config.ranges.r41;
            post1 = Frame.Post4;
            post2 = Frame.Post1;
        case '32'
            T = config.ranges.r32;
            post1 = Frame.Post3;
            post2 = Frame.Post2;
        case '42'
            T = config.ranges.r42;
            post1 = Frame.Post4;
            post2 = Frame.Post2;
        case '43'
            T = config.ranges.r43;
            post1 = Frame.Post4;
            post2 = Frame.Post3;
    end
    T = T / 3e8;
    k = 0;
    for i = 1:length(post1)
        for j = 1:length(post2)
            if abs(post1(i).T - post2(j).T) < T
                k = k + 1;
                data(k) = post1(i).T - post2(j).T;
            end
        end
    end
end

