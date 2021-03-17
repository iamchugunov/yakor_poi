function [res] = frame_analysys(frame, config)
    k = 0;
    out = [];
    
    imps1 = frame.Post1;
    imps2 = frame.Post2;
    imps3 = frame.Post3;
    imps4 = frame.Post4;
    
    [m1, n1] = noMODES_percent_in_post(imps1);
    [m2, n2] = noMODES_percent_in_post(imps2);
    [m3, n3] = noMODES_percent_in_post(imps3);
    [m4, n4] = noMODES_percent_in_post(imps4);
    
    for i = 1:length(imps1)
        for j = 1:length(imps2)
            b1 = ismatch(imps1(i),imps2(j),config.ranges.r21/config.c);
            if b1
                k = k + 1;
                out(:,k) = [i; j; 0; 0];
            end
        end            
    end
    
    for i = 1:length(imps1)
        for j = 1:length(imps3)
            b1 = ismatch(imps1(i),imps3(j),config.ranges.r31/config.c);
            if b1
                if ~isempty(out)
                    nums = find(out(1,:) == i);
                else
                    nums = []; 
                end
                if ~isempty(nums)
                    for m = 1:length(nums)
                        if out(2,nums(m)) > 0
                            b1 = ismatch(imps2(out(2,nums(m))),imps3(j),config.ranges.r32/config.c);
                        else
                            b1 = 0;
                        end
                        if b1
                            if out(3,nums(m)) == 0
                                out(3,nums(m)) = j;
                            else
                                k = k + 1;
                                out(:,k) = out(:,nums(m));
                                out(3,k) = j;
                            end
                        else
                            k = k + 1;
                            out(:,k) = [i; 0; j; 0];
                        end
                    end
                else
                    k = k + 1;
                    out(:,k) = [i; 0; j; 0];
                end
            end
        end            
    end
    
    for i = 1:length(imps1)
        for j = 1:length(imps4)
            b1 = ismatch(imps1(i),imps4(j),config.ranges.r41/config.c);
            if b1
                if ~isempty(out)
                    nums = find(out(1,:) == i);
                else
                    nums = []; 
                end
                
                if ~isempty(nums)
                    for m = 1:length(nums)
                        if out(2,nums(m)) > 0 && out(3,nums(m)) > 0
                            b11 = ismatch(imps2(out(2,nums(m))),imps4(j),config.ranges.r42/config.c);
                            b22 = ismatch(imps3(out(3,nums(m))),imps4(j),config.ranges.r43/config.c);
                            if b11 && b22
                                if out(4,nums(m)) == 0
                                    out(4,nums(m)) = j;
                                else
                                    k = k + 1;
                                    out(:,k) = out(:,nums(m));
                                    out(4,k) = j;
                                end
                            end
                            
                            if b11 && ~b22
                                k = k + 1;
                                out(:,k) = out(:,nums(m));
                                out(3,k) = 0;
                                out(4,k) = j;
                            end
                            if ~b11 && b22
                                k = k + 1;
                                out(:,k) = out(:,nums(m));
                                out(2,k) = 0;
                                out(4,k) = j;
                            end
                        elseif out(2,nums(m)) > 0
                            b1 = ismatch(imps2(out(2,nums(m))),imps4(j),config.ranges.r42/config.c);
                            if b1
                                if out(4,nums(m)) == 0
                                    out(4,nums(m)) = j;
                                else
                                    k = k + 1;
                                    out(:,k) = out(:,nums(m));
                                    out(4,k) = j;
                                end
                            end
                        elseif out(3,nums(m)) > 0
                            b1 = ismatch(imps3(out(3,nums(m))),imps4(j),config.ranges.r43/config.c);   
                            if b1
                                if out(4,nums(m)) == 0
                                    out(4,nums(m)) = j;
                                else
                                    k = k + 1;
                                    out(:,k) = out(:,nums(m));
                                    out(4,k) = j;
                                end
                            end
                        else
                            b1 = 0;
                        end
                        if b1
                            
                        else
                            k = k + 1;
                            out(:,k) = [i; 0; 0; j];
                        end
                    end
                else
                    k = k + 1;
                    out(:,k) = [i; 0; 0; j];
                end
            end
        end            
    end
    
    for i = 1:length(imps2)
        for j = 1:length(imps3)
            b1 = ismatch(imps2(i),imps3(j),config.ranges.r32/config.c);
            if b1 && ~contains_match(out, [2 3], [i; j])
                k = k + 1;
                out(:,k) = [0; i; j; 0];
            end
        end            
    end
    
    for i = 1:length(imps2)
        for j = 1:length(imps4)
            b1 = ismatch(imps2(i),imps4(j),config.ranges.r42/config.c);
            if b1
                if ~isempty(out)
                    nums = find(out(2,:) == i);
                else
                    nums = []; 
                end
                if ~isempty(nums)
                    for m = 1:length(nums)
                        if out(3,nums(m)) > 0
                            b1 = ismatch(imps3(out(3,nums(m))),imps4(j),config.ranges.r43/config.c);
                        else
                            b1 = 0;
                        end
                        if b1
                            if out(4,nums(m)) == 0
                                out(4,nums(m)) = j;
                            else
                                if ~contains_match(out, [2 3 4], [i; out(3,nums(m)); j])
                                    k = k + 1;
                                    out(:,k) = out(:,nums(m));
                                    out(4,k) = j;
                                end
                            end
                        else
                            if ~contains_match(out, [2 4], [i; j])
                                k = k + 1;
                                out(:,k) = [0; i; 0; j];
                            end
                        end
                    end
                else
                    k = k + 1;
                    out(:,k) = [0; i; 0; j];
                end
            end
        end            
    end
    
    for i = 1:length(imps3)
        for j = 1:length(imps4)
            b1 = ismatch(imps3(i),imps4(j),config.ranges.r43/config.c);
            if b1 && ~contains_match(out, [3 4], [i; j])
                k = k + 1;
                out(:,k) = [0; 0; i; j];
            end
        end            
    end
    
    PD = [];
    for i = 1:size(out,2)
        pd = [0;0;0;0];
        if out(1,i)
            PD(1,i) = imps1(out(1,i)).uT;
        end
        if out(2,i)
            PD(2,i) = imps2(out(2,i)).uT;
        end
        if out(3,i)
            PD(3,i) = imps3(out(3,i)).uT;
        end
        if out(4,i)
            PD(4,i) = imps4(out(4,i)).uT;
        end
    end
    
    
    matches_count = [0 0 0];
    for i = 1:size(out,2)
        N = length(find(out(:,i)));
        switch N
            case 2
                matches_count(1) = matches_count(1) + 1;
            case 3
                matches_count(2) = matches_count(2) + 1;
            case 4
                matches_count(3) = matches_count(3) + 1;
        end
    end
    
    res.data = out;
    res.matches_count2 = matches_count(1);
    res.matches_count3 = matches_count(2);
    res.matches_count4 = matches_count(3);
    res.PD = PD;
    
%     [m5, n5] = noMODES_percent_in_match(out);
    
    res.m1 = m1;
    res.n1 = n1;
    res.m2 = m2;
    res.n2 = n2;
    res.m3 = m3;
    res.n3 = n3;
    res.m4 = m4;
    res.n4 = n4;
    
    if isempty(imps1) && isempty(imps2) && isempty(imps3) && isempty(imps4)
        res.az = 0;
    else
        if ~isempty(imps1)
            res.az = imps1(1).az;
        elseif ~isempty(imps2)
            res.az = imps2(1).az;
        elseif ~isempty(imps3)
            res.az = imps3(1).az;
        elseif ~isempty(imps4)
            res.az = imps4(1).az;
        end
    end
end

function [bool] = ismatch(imp1, imp2, R_sec)
    T1 = imp1.T;
    T2 = imp2.T;
    f1 = imp1.freq;
    f2 = imp2.freq;
    i1 = imp1.d4c1;
    i2 = imp2.d4c1;
    
    if abs(T1 - T2) < R_sec && abs(f1 - f2) < 2e4 && strcmp(i1,i2)
        bool = 1;
    else
        bool = 0;
    end
end


function [bool] = contains_match(out, posts, nums)
    bool = 0;
    for i = 1:size(out,2)
       if norm(out(posts,i) - nums) == 0
           bool = 1;
       end
    end
end

function [m, n] = noMODES_percent_in_post(imps)
    m = 0;
    n = 0;
    for i = 1:length(imps)
        n = n + 1;
        if imps(i).freq ~= 1090000
            m = m + 1;
        end
    end
end

function [m, n] = noMODES_percent_in_match(out, frame)
    m = 0;
    n = 0;
    for i = 1:size(out,2)
        n = n + 1;
        tt = find(out(:,i));
        if frame.freq ~= 1090000
            m = m + 1;
        end
    end
end



