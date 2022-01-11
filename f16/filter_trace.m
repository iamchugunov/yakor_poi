function [x] = filter_trace(trace)
    a = 0.8;
    x(:,1) = trace.poits(8:9,1);
    for i = 2:trace.count
        x(:,i) = trace.poits(8:9,i) * (1 - a) + a * x(:,i-1);
    end

end

