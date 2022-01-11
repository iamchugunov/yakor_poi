function [rd] = get_rd_from_poits2(poits)

    toa = poits(2:5,:);
    
    nums = find(toa == 0);
    toa(nums) = NaN;
    
    nums = find(poits(7,:) == 1090);
    
    toa = toa(:,nums);
    rd = [];
    rd(1,:) = poits(1,nums);
    rd(2,:) = toa(4,:) - toa(1,:);
    rd(3,:) = toa(4,:) - toa(2,:);
    rd(4,:) = toa(4,:) - toa(3,:);
    rd(5,:) = toa(3,:) - toa(1,:);
    rd(6,:) = toa(3,:) - toa(2,:);
    rd(7,:) = toa(2,:) - toa(1,:);
    
    plot(rd(1,:),rd(2,:),'.b')
    hold on
    plot(rd(1,:),rd(3,:),'.b')
    hold on
    plot(rd(1,:),rd(4,:),'.b')
    plot(rd(1,:),rd(5,:),'.b')
    plot(rd(1,:),rd(6,:),'.b')
    plot(rd(1,:),rd(7,:),'.b')
    
    
    toa = poits(2:5,:);
    
    nums = find(toa == 0);
    toa(nums) = NaN;
    
    nums = find(poits(7,:) ~= 1090);
    
    toa = toa(:,nums);
    rd = [];
    rd(1,:) = poits(1,nums);
    rd(2,:) = toa(4,:) - toa(1,:);
    rd(3,:) = toa(4,:) - toa(2,:);
    rd(4,:) = toa(4,:) - toa(3,:);
    rd(5,:) = toa(3,:) - toa(1,:);
    rd(6,:) = toa(3,:) - toa(2,:);
    rd(7,:) = toa(2,:) - toa(1,:);
    
    plot(rd(1,:),rd(2,:),'.r')
    hold on
    plot(rd(1,:),rd(3,:),'.r')
    hold on
    plot(rd(1,:),rd(4,:),'.r')
    plot(rd(1,:),rd(5,:),'.r')
    plot(rd(1,:),rd(6,:),'.r')
    plot(rd(1,:),rd(7,:),'.r')
    
    
end

