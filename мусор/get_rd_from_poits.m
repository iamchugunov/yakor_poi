function [] = get_rd_from_poits(poits)
    k1 = 0;
    k2 = 0;
    k3 = 0;
    k4 = 0;
    k5 = 0;
    for i = 1:length(poits)
        if poits(i).ToA(2) > 0 && poits(i).ToA(1) > 0
            k1 = k1 + 1;
            t1(k1) = poits(i).Frame;
            rd1(k1) = poits(i).ToA(2) - poits(i).ToA(1);
        end
        if poits(i).ToA(3) > 0 && poits(i).ToA(1) > 0
            k2 = k2 + 1;
            rd2(k2) = poits(i).ToA(3) - poits(i).ToA(1);
            t2(k2) = poits(i).Frame;
        end
        if poits(i).ToA(4) > 0 && poits(i).ToA(1) > 0
            k3 = k3 + 1;
            rd3(k3) = poits(i).ToA(4) - poits(i).ToA(1);
            t3(k3) = poits(i).Frame;
        end
        if poits(i).ToA(3) > 0 && poits(i).ToA(2) > 0
            k4 = k4 + 1;
            rd4(k4) = poits(i).ToA(3) - poits(i).ToA(2);
            t4(k4) = poits(i).Frame;
        end
        if poits(i).ToA(4) > 0 && poits(i).ToA(3) > 0
            k5 = k5 + 1;
            rd5(k5) = poits(i).ToA(4) - poits(i).ToA(3);
            t5(k5) = poits(i).Frame;
        end
    end
    figure
    hold on
    plot(t1,rd1,'.')
    plot(t2,rd2,'.')
    plot(t3,rd3,'.')
    plot(t4,rd4,'.')
    plot(t5,rd5,'.')
    grid on
end

