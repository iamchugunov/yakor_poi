function [] = lineyka(para, config)
    switch para
        case '21'
            T = config.ranges.r21;
        case '31'
            T = config.ranges.r31;
        case '41'
            T = config.ranges.r41;
        case '32'
            T = config.ranges.r32;
        case '42'
            T = config.ranges.r42;
        case '43'
            T = config.ranges.r43;
    end
    T = T / 3e8;
    x = ginput(1);
    hold on
    plot([x(1) x(1) + T],[x(2) x(2)],'.-')
end

