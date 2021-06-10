function [out] = process_frame(frame, config)
    
    out.time = frame.time;
    out.RD21 = 0;
    out.RD31 = 0;
    out.RD41 = 0;
    out.RD32 = 0;
    out.RD42 = 0;
    out.RD43 = 0;

    t = 0:1:12000000;
    val_post1 = zeros(1,length(t));
    val_post2 = zeros(1,length(t));
    val_post3 = zeros(1,length(t));
    val_post4 = zeros(1,length(t));

    val_post_T1 = zeros(1,length(t));
    val_post_T2 = zeros(1,length(t));
    val_post_T3 = zeros(1,length(t));
    val_post_T4 = zeros(1,length(t));
    
    if length(frame.Post1)
        uT_Post1 = [frame.Post1.uT].';
    else
        uT_Post1 = [];
    end
    if length(frame.Post2)
        uT_Post2 = [frame.Post2.uT].';
    else
        uT_Post2 = [];
    end
    if length(frame.Post3)
        uT_Post3 = [frame.Post3.uT].';
    else
        uT_Post3 = [];
    end
    if length(frame.Post4)
        uT_Post4 = [frame.Post4.uT].';
    else
        uT_Post4 = [];
    end
    
    if length(frame.Post1)
        dur_Post1 = [frame.Post1.dur].'.*10;
    else
        dur_Post1 = [];
    end
    if length(frame.Post2)
        dur_Post2 = [frame.Post2.dur].'.*10;
    else
        dur_Post2 = [];
    end
    if length(frame.Post3)
        dur_Post3 = [frame.Post3.dur].'.*10;
    else
        dur_Post3 = [];
    end
    if length(frame.Post4)
        dur_Post4 = [frame.Post4.dur].'.*10;
    else
        dur_Post4 = [];
    end
    
    for i=1:length(uT_Post1)
        val_post_T1(uT_Post1(i):(uT_Post1(i)+dur_Post1(i))) = ones(1,length(dur_Post1(i)));
    end
    for i=1:length(uT_Post2)
        val_post_T2(uT_Post2(i):(uT_Post2(i)+dur_Post2(i))) = ones(1,length(dur_Post2(i)));
    end
    for i=1:length(uT_Post3)
        val_post_T3(uT_Post3(i):(uT_Post3(i)+dur_Post3(i))) = ones(1,length(dur_Post3(i)));
    end
    for i=1:length(uT_Post4)
        val_post_T4(uT_Post4(i):(uT_Post4(i)+dur_Post4(i))) = ones(1,length(dur_Post4(i)));
    end
    
    thres_min = 20;
    if length(frame.Post1) > thres_min
        if length(frame.Post2) > thres_min
            [x12_T,lags12_T] = xcorr(val_post_T1,val_post_T2,ceil(config.ranges.r21 / config.c * 1e9));
%             [m, n] = max(x12_T);
%             out.RD21 = - lags12_T(n) * 1e-9 * config.c;
            [lags12_T, x12_T] = sortbylag(x12_T,lags12_T);
            [m, b] = sort(x12_T);
            k = 0;
            while k < length(b)
                rd = -lags12_T(b(end-k))* 1e-9 * config.c;
                k = k + 1;
                out.RD21(k,:) = rd;
                if k > 2
                    break;
                end
            end
        else
            out.RD21 = 0;
        end
        if length(frame.Post3) > thres_min
            [x13_T,lags13_T] = xcorr(val_post_T1,val_post_T3,ceil(config.ranges.r31 / config.c * 1e9));
%             [m, n] = max(x12_T);
%             out.RD21 = - lags12_T(n) * 1e-9 * config.c;
            [lags13_T, x13_T] = sortbylag(x13_T,lags13_T);
            [m, b] = sort(x13_T);
            k = 0;
            while k < length(b)
                rd = -lags13_T(b(end-k))* 1e-9 * config.c;
                k = k + 1;
                out.RD31(k,:) = rd;
                if k > 2
                    break;
                end
            end
        else
            out.RD31 = 0;
        end
        if length(frame.Post4) > thres_min
            [x14_T,lags14_T] = xcorr(val_post_T1,val_post_T4,ceil(config.ranges.r41 / config.c * 1e9));
%             [m, n] = max(x12_T);
%             out.RD21 = - lags12_T(n) * 1e-9 * config.c;
            [lags14_T, x14_T] = sortbylag(x14_T,lags14_T);
            [m, b] = sort(x14_T);
            k = 0;
            while k < length(b)
                rd = -lags14_T(b(end-k))* 1e-9 * config.c;
                k = k + 1;
                out.RD41(k,:) = rd;
                if k > 2
                    break;
                end
            end
        else
            out.RD41 = 0;
        end

    end

    if length(frame.Post2) > thres_min
        if length(frame.Post3) > thres_min
           [x23_T,lags23_T] = xcorr(val_post_T2,val_post_T3,ceil(config.ranges.r32 / config.c * 1e9));
%             [m, n] = max(x12_T);
%             out.RD21 = - lags12_T(n) * 1e-9 * config.c;
            [lags23_T, x23_T] = sortbylag(x23_T,lags23_T);
            [m, b] = sort(x23_T);
            k = 0;
            while k < length(b)
                rd = -lags23_T(b(end-k))* 1e-9 * config.c;
                k = k + 1;
                out.RD32(k,:) = rd;
                if k > 2
                    break;
                end
            end
        else
            out.RD32 = 0;
        end
        if length(frame.Post4) > thres_min
            [x24_T,lags24_T] = xcorr(val_post_T2,val_post_T4,ceil(config.ranges.r42 / config.c * 1e9));
%             [m, n] = max(x12_T);
%             out.RD21 = - lags12_T(n) * 1e-9 * config.c;
            [lags24_T, x24_T] = sortbylag(x24_T,lags24_T);
            [m, b] = sort(x24_T);
            k = 0;
            while k < length(b)
                rd = -lags24_T(b(end-k))* 1e-9 * config.c;
                k = k + 1;
                out.RD42(k,:) = rd;
                if k > 2
                    break;
                end
            end
        else
            out.RD42 = 0;
        end
    end

    if length(frame.Post3) > thres_min
        if length(frame.Post4) > thres_min
            [x34_T,lags34_T] = xcorr(val_post_T3,val_post_T4,ceil(config.ranges.r43 / config.c * 1e9));
%             [m, n] = max(x12_T);
%             out.RD21 = - lags12_T(n) * 1e-9 * config.c;
            [lags34_T, x34_T] = sortbylag(x34_T,lags34_T);
            [m, b] = sort(x34_T);
            k = 0;
            while k < length(b)
                rd = -lags34_T(b(end-k))* 1e-9 * config.c;
                k = k + 1;
                out.RD43(k,:) = rd;
                if k > 2
                    break;
                end
            end
        else
            out.RD43 = 0;
        end
    end
     
   
%     if out.RD21 && out.RD31 && out.RD41
%         out.RD = [out.RD21; out.RD31; out.RD41];
%         h = 0:100:20000;
%         for i = 1:length(h)
%             [UserPos(:,i), nev(i)] = NavSolver_RD(config.posts, out.RD, [0;0], h(i));
%         end
%         [m, n] = min(nev);
%         out.cord = [UserPos(:,n); h(n)];
%     else
%         out.RD = [];
%         out.cord =[];
%     end
    out.freq = frame.freq;
        
end

