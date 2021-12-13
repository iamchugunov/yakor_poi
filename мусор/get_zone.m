function [] = get_zone(x, y, h, config, sigma, thres)
    posts = config.posts;
    pos = [x;y;h];
    TOA = [];
    cord = [];
    cord_all  = [];
    for i = 1:4
        TOA(i,1) = norm(pos - posts(:,i)) /config.c * 1e9;
    end
    k = 0;
    for j = 1:10000
        pos1 = [normrnd(pos(1,1),sigma);normrnd(pos(2,1),sigma);normrnd(pos(3,1),0)];
        TOA1 = [];
        for i = 1:4
        TOA1(i,1) = norm(pos1 - posts(:,i)) /config.c * 1e9;
        end
        STD = std(TOA - TOA1);
        if STD < thres
           k = k + 1;
           cord(:,k) = pos1;
        end
        cord_all(:,j) = pos1;
    end
    
    plot(posts(1,:),posts(2,:),'vk')
    hold on
    grid on
    plot(cord_all(1,:),cord_all(2,:),'ob')
    plot(cord(1,:),cord(2,:),'xr')
    daspect([1 1 1])
    plot(posts(1,:),posts(2,:),'vk')
    plot(pos(1,1),pos(2,1),'pentagramk')
end

