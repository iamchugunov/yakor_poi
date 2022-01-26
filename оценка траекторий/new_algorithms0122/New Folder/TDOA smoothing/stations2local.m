function l = stations2local(p)
    [xEast, yNorth, zUp] = latlon2local (p.Latitude, p.Longitude, p.Altitude, [p.Latitude(4), p.Longitude(4), p.Altitude(4)] );
    l = [xEast, yNorth, zUp];
end