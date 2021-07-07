function [] = process_frame_graph(frame, config)
    
    
    [val_post_T1,val_post_T2,val_post_T3,val_post_T4] = fill_time_period1(frame);
    peaks_count = 30;
    thres_min = 20;
    if length(frame.Post1) > thres_min
        if length(frame.Post2) > thres_min
            [x12_T,lags12_T] = xcorr(val_post_T1,val_post_T2,ceil(config.ranges.r21 / config.c * 1e8));
            rd12 = -lags12_T *1e-8 * config.c;
            figure
            plot(rd12/1000,x12_T/max(x12_T))
            xlabel('km')
            grid on
            axis([-30 30 0 1.2])
            title('12')
        end
        if length(frame.Post3) > thres_min
            [x13_T,lags13_T] = xcorr(val_post_T1,val_post_T3,ceil(config.ranges.r31 / config.c * 1e8));
            rd13 = -lags13_T *1e-8 * config.c;
            figure
            hold on
            plot(rd13/1000,x13_T/max(x13_T))
            xlabel('km')
            grid on
            axis([-30 30 0 1.2])
            title('13')
        end
        if length(frame.Post4) > thres_min
            [x14_T,lags14_T] = xcorr(val_post_T1,val_post_T4,ceil(config.ranges.r41 / config.c * 1e8));
            rd14 = -lags14_T *1e-8 * config.c;
            figure
            hold on
            plot(rd14/1000,x14_T/max(x14_T))
            xlabel('km')
            grid on
            axis([-30 30 0 1.2])
            title('14')
        end
    end

    if length(frame.Post2) > thres_min
        if length(frame.Post3) > thres_min
           [x23_T,lags23_T] = xcorr(val_post_T2,val_post_T3,ceil(config.ranges.r32 / config.c * 1e8));
            rd23 = -lags23_T *1e-8 * config.c;
            figure
            hold on
            plot(rd23/1000,x23_T/max(x23_T))
            xlabel('km')
            grid on
            axis([-30 30 0 1.2])
            title('23')
        end
        if length(frame.Post4) > thres_min
            [x24_T,lags24_T] = xcorr(val_post_T2,val_post_T4,ceil(config.ranges.r42 / config.c * 1e8));
            rd24 = -lags24_T *1e-8 * config.c;
            figure
            hold on
            plot(rd24/1000,x24_T/max(x24_T))
            xlabel('km')
            grid on
            axis([-30 30 0 1.2])
            title('24')
        end
    end

    if length(frame.Post3) > thres_min
        if length(frame.Post4) > thres_min
            [x34_T,lags34_T] = xcorr(val_post_T3,val_post_T4,ceil(config.ranges.r43 / config.c * 1e8));
            rd34 = -lags34_T *1e-8 * config.c;
            figure
            hold on
            plot(rd34/1000,x34_T/max(x34_T))
            xlabel('km')
            grid on
            axis([-30 30 0 1.2])
            title('34')
        end
    end
     
   
        
end

function [uT_Post,dur_Post] = get_uT_and_dur1(Post)
uT_Post = [Post.uT].'/10;
dur_Post = [Post.dur].'.*1;
end



function [val_post_T1,val_post_T2,val_post_T3,val_post_T4] = fill_time_period1(frame)

%     t = 0:1:12000000;
    t = 0:10:12000000;
    val_post_T1 = zeros(1,length(t));
    val_post_T2 = zeros(1,length(t));
    val_post_T3 = zeros(1,length(t));
    val_post_T4 = zeros(1,length(t));
    
    if length(frame.Post1)
          [uT_Post1,dur_Post1] = get_uT_and_dur1(frame.Post1);
    else
        uT_Post1 = [];
        dur_Post1 = [];
    end
    if length(frame.Post2)
        [uT_Post2,dur_Post2] = get_uT_and_dur1(frame.Post2);
    else
        uT_Post2 = [];
        dur_Post2 = [];
    end
    if length(frame.Post3)
        [uT_Post3,dur_Post3] = get_uT_and_dur1(frame.Post3);
    else
        uT_Post3 = [];
        dur_Post3 = [];
    end
    if length(frame.Post4)
       [uT_Post4,dur_Post4] = get_uT_and_dur1(frame.Post4);
    else
        uT_Post4 = [];
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
    
end





