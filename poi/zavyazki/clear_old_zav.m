function [ZRdb] = clear_old_zav(ZRdb, time, timeout)
    if ~isempty(ZRdb)
        nums = find([ZRdb.count] < 5);
        ZRdb(nums) = [];
        nums = find([ZRdb.last_time] - time > timeout);
        ZRdb(nums) = [];
    end
end

