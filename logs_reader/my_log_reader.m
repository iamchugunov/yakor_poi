function [Frames] = my_log_reader()
% считывание лога по кадрам
if nargin == 0
folder = uigetdir(cd,'Выберите папку с логами!');
end
 warning off

files = dir(folder);
files = files(3:end);
N = length(files);
k = 0;
frames = 0;

<<<<<<< Updated upstream
files_range = 1:N;
files_range = 1:50;
=======
files_range = 1:10;
% files_range = 1:5;
>>>>>>> Stashed changes

for i = files_range
    
    filename = [folder '\' files(i).name];
    f = fopen(filename);
    
    j=0;
    while feof(f)==0
        s = fgetl(f);
%         splited_string(j) = split(s,' ');
        j=j+1;
        disp(j);
        if contains(s,'pmask')
            frames = frames + 1;
            hour   = str2double(s(11:13));
            minute = str2double(s(15:16));
            sec    = str2double(s(18:28));
            time  = hour * 3600 + minute * 60 + sec;
            frame_time(frames) = time;
            Frames(frames).time = time;
            Frames(frames).Post1 = [];
            Frames(frames).Post2 = [];
            Frames(frames).Post3 = [];
            Frames(frames).Post4 = [];
        end
        if(contains(s,"post"))
            post_val = split(s,' ');
            count_mass = split(post_val{4},'=');
            count = str2double(count_mass{2});
            if(count~=0)
                switch post_val{2}
                    case '1'
                        for meas_num = 1:count
                            s = fgetl(f);
                            Frames(frames).Post1(meas_num).raw_meas =s;
                            j=j+1;
                        end
                    case '2'
                        for meas_num = 1:count
                            s = fgetl(f);
                            Frames(frames).Post2(meas_num).raw_meas = s;
                            j=j+1;
                        end
                    case '3'
                        for meas_num = 1:count
                            s = fgetl(f);
                            Frames(frames).Post3(meas_num).raw_meas = s;
                            j=j+1;
                        end
                    case '4'
                        for meas_num = 1:count
                            s = fgetl(f);
                            Frames(frames).Post4(meas_num).raw_meas = s;
                            j=j+1;
                        end
                end
            end 
        end
%         if contains(s,'pmask')
%             
%         end
    end
end
    fclose('all');
    [Frames] = my_log_parser(Frames);
end