traces = [];

for i = 1:length(POITS)
    match_flag = 0;
    for j = 1:length(traces)
        if abs(traces(j).freq - POITS(7,i)) < 2
            match_flag = 1;
            break
        end
    end
    
    if match_flag
        traces(j).count = traces(j).count + 1;
        traces(j).poits(:,traces(j).count) = POITS(:,i);
        traces(j).freq = mean(traces(j).poits(7,:));
    else
        new_trace = [];
        new_trace.freq = POITS(7,i);
        new_trace.count = 1;
        new_trace.poits(:,new_trace.count) = POITS(:,i);
        traces = [traces new_trace];
    end
end