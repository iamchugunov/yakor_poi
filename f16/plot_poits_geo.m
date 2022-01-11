function [] = plot_poits_geo(poits, config)
    blh = [];
    k = 0;
    for i = 1:size(poits,2)
        if poits(8,i) ~= 0
            k = k + 1;
            [blh(1,k),blh(2,k),blh(3,k)] = enu2geodetic(poits(8,i),poits(9,i),poits(10,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
        end
    end
    geoplot(blh(1,:),blh(2,:),'.-')
end

