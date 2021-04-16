function [track_base,kosyak] = solver4_track(database, config,time_frame,V_plane)
    kosyak = 0;
    for k = 1:length(database)
        j=0;
        for i = 1:size(database(k).data,2)
           N = length(find(database(k).data(:,i)));
           if N == 4
                j=j+1;
%                 [track_base(k).track(1,j), track_base(k).track(2,j)] =
%                 Navigate3or4( config.PostsENU,
%                 database(k).data(:,i)*config.c, 5000, 24000,30000 ); 
                X = coord_solver2D(database(k).data(:,i)*config.c, config.PostsENU, [0;0;1000;], config.hei);
                track_base(k).track(1,j) = X(1,1);
                track_base(k).track(2,j) = X(2,1);
           elseif N == 3
                j=j+1;
%                 [x1, x2] =
%                 solver3(config.PostsENU(:,find(database(k).data(:,i))), database(k).data(find(database(k).data(:,i)),i)*config.c, 5000)
                [x1,x2] = solver3(config.PostsENU(:,find(database(k).data(:,i))),database(k).data(find(database(k).data(:,i)),i)*config.c,config.hei);
                %исключение второго решения
                %%%%%%%%%%%%%%%%%%%%%%%%%%%
                if norm(x1-x2)<=sqrt(2)
                    track_base(k).track(1,j) = x1(1,1);
                    track_base(k).track(2,j) = x1(2,1);
                elseif norm(x1-x2)>=(10*sqrt(2)*time_frame*V_plane)
                        if (abs(track_base(k).track(1,j-1)-x1(1,1))<=(10*time_frame*V_plane)) || (abs(track_base(k).track(2,j-1)-x1(2,1))<=(10*time_frame*V_plane))
                            track_base(k).track(1,j) = x1(1,1);
                            track_base(k).track(2,j) = x1(2,1);
                        else
                            track_base(k).track(1,j) = x2(1,1);
                            track_base(k).track(2,j) = x2(2,1);
                        end
                else
                    kosyak=kosyak+1;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%
                  
           end
        end
    end
end

