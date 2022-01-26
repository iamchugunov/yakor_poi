function show_stations(p)
    figure
    geoscatter (p.Latitude, p.Longitude, '^', 'filled', 'red');
    geobasemap streets;
end