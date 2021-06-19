function [rd] = get_rds(in)
    k = 0;
    for i = 1:length(in)
       if in{i,1}(1) ~= 0
       for j = 1:length(in{i,1})
           k = k + 1;
           rd(:,k) = in{i,1}(j);
       end
       end
    end
end

