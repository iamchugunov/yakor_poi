function [val_post_T1,val_post_T2,val_post_T3,val_post_T4] = fill_time_period(frame)

    t = 0:1:12000000;
    val_post_T1 = zeros(1,length(t));
    val_post_T2 = zeros(1,length(t));
    val_post_T3 = zeros(1,length(t));
    val_post_T4 = zeros(1,length(t));
    
    if length(frame.Post1)
          [uT_Post1,dur_Post1] = get_uT_and_dur(frame.Post1);
    else
        uT_Post1 = [];
        dur_Post1 = [];
    end
    if length(frame.Post2)
        [uT_Post2,dur_Post2] = get_uT_and_dur(frame.Post2);
    else
        uT_Post2 = [];
        dur_Post2 = [];
    end
    if length(frame.Post3)
        [uT_Post3,dur_Post3] = get_uT_and_dur(frame.Post3);
    else
        uT_Post3 = [];
        dur_Post3 = [];
    end
    if length(frame.Post4)
       [uT_Post4,dur_Post4] = get_uT_and_dur(frame.Post4);
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

