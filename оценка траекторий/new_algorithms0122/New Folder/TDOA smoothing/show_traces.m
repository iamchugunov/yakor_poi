function show_traces(p)
    figure
    geoplot (p.Latitude, p.Longitude, '--or');
    geobasemap streets;
end