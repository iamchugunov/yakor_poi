function [rd] = get_rd_from_poits1(poits)

    toa = poits(2:5,:);
    
    nums = find(toa == 0);
    toa(nums) = NaN;

    rd(1,:) = poits(1,:);
    rd(2,:) = toa(4,:) - toa(1,:);
    rd(3,:) = toa(4,:) - toa(2,:);
    rd(4,:) = toa(4,:) - toa(3,:);
    rd(5,:) = toa(3,:) - toa(1,:);
    rd(6,:) = toa(3,:) - toa(2,:);
    rd(7,:) = toa(2,:) - toa(1,:);
    
    plot(rd(1,:)-rd(1,1),rd(2,:),'.')
    hold on
    plot(rd(1,:)-rd(1,1),rd(3,:),'.')
    hold on
    plot(rd(1,:)-rd(1,1),rd(4,:),'.')
    plot(rd(1,:)-rd(1,1),rd(5,:),'.')
    plot(rd(1,:)-rd(1,1),rd(6,:),'.')
    plot(rd(1,:)-rd(1,1),rd(7,:),'.')
end

