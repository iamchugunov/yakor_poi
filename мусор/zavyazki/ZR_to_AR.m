function [ZRdb, ARdb] = ZR_to_AR(ZRdb, ARdb, time)
    if ~isempty(ZRdb)
        nums = find([ZRdb.count] > 10);
        for i = 1:length(nums)
            if isempty(ARdb)
                ARdb = ZRdb(nums(i));
            else
                ARdb(end+1) = ZRdb(nums(i));
            end            
        end
        ZRdb(nums) = [];
    end
end

