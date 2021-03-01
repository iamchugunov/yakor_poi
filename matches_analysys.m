function [azs, azs_count, res, azs_count_coords] = matches_analysys(matches, config)

azs = [337.500000000000;292.500000000000;247.500000000000;202.500000000000;157.500000000000;112.500000000000;67.5000000000000;22.5000000000000];
azs_count = [0 0 0 0 0 0 0 0];

for i = 1:length(matches)
    if matches(i).az
        N = find(azs == matches(i).az);
        azs_count(N) = azs_count(N) + matches(i).matches_count2 + matches(i).matches_count3 + matches(i).matches_count4;
    end
end

for i = 1:length(matches)
    k = 0;
    if matches(i).matches_count4
        for j = 1:size(matches(i).data,2)
            if length(find(matches(i).data(:,j)))==4
                PD = matches(i).PD(:,j) * config.c/1e9;
                k = k + 1;
                [ xla,yla,Hla,dT, DOP, NEV, err, flag ] = Navigate3or4( config.PostsENU, PD, 5000, 0, 0 );
                res(i).pos(:,k) = [xla; yla];
            end
        end
    end
    res(i).count = k;
    res(i).az = matches(i).az;
end

azs_count_coords = [0 0 0 0 0 0 0 0];
for i = 1:length(res)
    if res(i).az
        N = find(azs == res(i).az);
        azs_count_coords(N) = azs_count_coords(N) + res(i).count;
    end
end

end
