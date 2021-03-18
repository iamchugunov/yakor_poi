function [track,x1, x2] = solver4_track(database, config)
    for i = 1:size(database.data,2)
       N = length(find(database.data(:,i)));
       if N == 4
            [track(1,i), track(2,i)] = Navigate3or4( config.PostsENU, database.data(:,i)*config.c, 5000, 24000,30000 );
       elseif N == 3
            [x1(:,i), x2(:,i)] = solver3(config.PostsENU(:,find(database.data(:,i))), database.data(find(database.data(:,i)),i)*config.c, 5000)
       end
    end
end

