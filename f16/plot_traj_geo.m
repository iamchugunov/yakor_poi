function [] = plot_traj_geo(traj, config)
    blh = [];
    k = 0;
    for i = 1:size(traj,2)
        if traj(2,i) ~= 0
            k = k + 1;
            [blh(1,k),blh(2,k),blh(3,k)] = enu2geodetic(traj(2,i),traj(4,i),traj(6,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
        end
    end
    geoplot(blh(1,:),blh(2,:),'.-')
end



