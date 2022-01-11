traces = [];

for i = 1:length(POITS)
    match_flag = 0;
    
    R_min = 1e20;
    j_min = -1;
    
    for j = 1:length(traces)
        
        if POITS(1,i) - traces(j).Frame < 10
            dt = POITS(2:5,i) - traces(j).poits(2:5,end);
            if std(dt) < 250
                match_flag = 1;
                break
            end
        end
        
        dt = POITS(1,i) - traces(j).Frame;
        if dt > 60
            continue
        end
        R = norm(traces(j).poits(8:10,end) - POITS(8:10,i));
        if R < (sqrt( (300 * dt)^2 + 1000^2))
            if R < R_min
                R_min = R;
                j_min = j;
                match_flag = 1;
            end
        end
        
        
%         if abs(traces(j).freq - POITS(7,i)) < 5
%             match_flag = 1;
%             break
%         end
    end
    
    if j_min > 0
        j = j_min;
    end
    
    if match_flag
        traces(j).count = traces(j).count + 1;
        traces(j).poits(:,traces(j).count) = POITS(:,i);
        traces(j).freq = mean(traces(j).poits(7,:));
        traces(j).Frame = POITS(1,i);
    else
        new_trace = [];
        new_trace.freq = POITS(7,i);
        new_trace.count = 1;
        new_trace.poits(:,new_trace.count) = POITS(:,i);
        new_trace.Frame = POITS(1,i);
        traces = [traces new_trace];
    end
end