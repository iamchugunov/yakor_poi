function [] = visual_cord(zav, config)
    k3 = 0;
    k4 = 0;
    k = 0;
    for i = 1:zav.count
        if zav.poits(i).count == 3 && zav.poits(i).xy_valid
            k3 = k3 + 1;
            t3(k3) = zav.poits(i).Frame;
            cord3(:,k3) = zav.poits(i).coords;
            k = k + 1;
            cord(:,k) = cord3(1:2,k3);
        elseif zav.poits(i).count == 4 && zav.poits(i).xy_valid
            k4 = k4 + 1;
            t4(k4) = zav.poits(i).Frame;
            cord4(:,k4) = zav.poits(i).coords;
            k = k + 1;
            cord(:,k) = cord4(1:2,k4);
        end
    end
    for i = 2:k
        norma(i) = norm(cord(:,i) - cord(:,i-1))/1000;
    end
    for i = 2:k4
        norma4(i) = norm(cord4(1:2,i) - cord4(1:2,i-1))/1000;
    end
    plot(config.posts(1,:), config.posts(2,:),'v')
    hold on
    grid on
    plot(cord3(1,:),cord3(2,:),'.')
    plot(cord4(1,:),cord4(2,:),'kx')
    
    figure
    subplot(131)
    grid on 
    hold on
    plot(t3,cord3(1,:)/1000,'.-')
    plot(t4,cord4(1,:)/1000,'.-')
    
    subplot(132)
    grid on 
    hold on
    plot(t3,cord3(2,:)/1000,'.-')
    plot(t4,cord4(2,:)/1000,'.-')
    
    subplot(133)
    grid on 
    hold on
    plot(t3,cord3(3,:)/1000,'.-')
    plot(t4,cord4(3,:)/1000,'.-')
    
    figure()
    subplot(121)
    plot(norma)
    hold on
    plot(norma4,'.')
    subplot(122)
    histogram(norma,1000)
    hold on
    histogram(norma4,1000)
    
end

