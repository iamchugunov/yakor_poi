function [Frames] = my_log_parser(Frames)

parfor i=1:length(Frames)
    if(~isempty(Frames(i).Post1))
        for j=1:length(Frames(i).Post1)
            splited_string = split(Frames(i).Post1(j).raw_meas,' ');
            Frames(i).Post1(j).uT = str2double(splited_string{1});
            Frames(i).Post1(j).T =  Frames(i).time + Frames(i).Post1(j).uT/1e9;
            Frames(i).Post1(j).amp = str2double(splited_string{3});
            Frames(i).Post1(j).freq = str2double(splited_string{6});
            Frames(i).Post1(j).dur = str2double(splited_string{10});
            Frames(i).Post1(j).az = str2double(splited_string{20});
            if j > 1
                Frames(i).Post1(j).period = Frames(i).Post1(j).T - Frames(i).Post1(j-1).T;
            else
                Frames(i).Post1(j).period = 0;
            end
            Frames(i).Post1(j).d4c1 = str2double(splited_string{21});
        end
    end
    if(~isempty(Frames(i).Post2))
        for j=1:length(Frames(i).Post2)
            splited_string = split(Frames(i).Post2(j).raw_meas,' ');
            Frames(i).Post2(j).uT = str2double(splited_string{1});
            Frames(i).Post2(j).T =  Frames(i).time + Frames(i).Post2(j).uT/1e9;
            Frames(i).Post2(j).amp = str2double(splited_string{3});
            Frames(i).Post2(j).freq = str2double(splited_string{6});
            Frames(i).Post2(j).dur = str2double(splited_string{10});
            Frames(i).Post2(j).az = str2double(splited_string{20});
            if j > 1
                Frames(i).Post2(j).period = Frames(i).Post2(j).T - Frames(i).Post2(j-1).T;
            else
                Frames(i).Post2(j).period = 0;
            end
            Frames(i).Post2(j).d4c1 = str2double(splited_string{21});
        end
    end
    if(~isempty(Frames(i).Post3))
        for j=1:length(Frames(i).Post3)
            splited_string = split(Frames(i).Post3(j).raw_meas,' ');
            Frames(i).Post3(j).uT = str2double(splited_string{1});
            Frames(i).Post3(j).T =  Frames(i).time + Frames(i).Post3(j).uT/1e9;
            Frames(i).Post3(j).amp = str2double(splited_string{3});
            Frames(i).Post3(j).freq = str2double(splited_string{6});
            Frames(i).Post3(j).dur = str2double(splited_string{10});
            Frames(i).Post3(j).az = str2double(splited_string{20});
            if j > 1
                Frames(i).Post3(j).period = Frames(i).Post3(j).T - Frames(i).Post3(j-1).T;
            else
                Frames(i).Post3(j).period = 0;
            end
            Frames(i).Post3(j).d4c1 = str2double(splited_string{21});
        end
    end
    if(~isempty(Frames(i).Post4))
        for j=1:length(Frames(i).Post4)
            splited_string = split(Frames(i).Post4(j).raw_meas,' ');
            Frames(i).Post4(j).uT = str2double(splited_string{1});
            Frames(i).Post4(j).T =  Frames(i).time + Frames(i).Post4(j).uT/1e9;
            Frames(i).Post4(j).amp = str2double(splited_string{3});
            Frames(i).Post4(j).freq = str2double(splited_string{6});
            Frames(i).Post4(j).dur = str2double(splited_string{10});
            Frames(i).Post4(j).az = str2double(splited_string{20});
            if j > 1
                Frames(i).Post4(j).period = Frames(i).Post4(j).T - Frames(i).Post4(j-1).T;
            else
                Frames(i).Post4(j).period = 0;
            end
            Frames(i).Post4(j).d4c1 = str2double(splited_string{21});
        end
    end
end
% parfor i = 1:length(frames)
%     
% end

end

