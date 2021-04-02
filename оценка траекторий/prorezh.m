function [Y] = prorezh(y)
    Y = y;
    for i = 1:size(y,2)
        A = rand;
        if A < 0.25
            Y(randi([1 4]),i) = 0;
            Y(randi([1 4]),i) = 0;
        elseif A < 0.5
            Y(randi([1 4]),i) = 0;
        else
            
        end
    end
end

