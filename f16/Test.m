addpath('D:\github\yakor_poi\оценка траекторий')
% k = 0;
% poits = [];
% for i = 1:length(out(4).poits)
%     toa = out(4).poits(2:5,i);
%     nums = find(toa);
%     if length(nums) > 2 && out(4).poits(7,i) > 9400
%         k = k + 1;
%         poits(:,k) = out(4).poits(:,i);
%     end
% end

cur_t = 0;
frame = [];
frames_count = 0;
imp_count = [];
POITS = [];
kp = 0;
for i = 1:length(poits)
    i
    if poits(1,i) ~= cur_t
        frames_count = frames_count + 1;
        imp_count(frames_count) = size(frame,2);
        
        % frame analysys
        freqs_in_frame = [];
        for j = 1:size(frame,2)
            toa = frame(2:5,j) * config.c/1e9;
            nums = find(toa > 0);
            if length(nums) == 4
                [xx_d, flag, dop, nev, hei_geo] = coord_solver_2D_h(toa, config.posts, [0;0;0], -15e3:1000:15e3, config);
                        
                if ~flag
                    continue;
                end
            end    
            match_flag = 0;
            for n = 1:length(freqs_in_frame)
                if abs(freqs_in_frame(n).freq - frame(7,j)) < 5
                    match_flag = 1;
                    break;
                end
            end
            if match_flag
                freqs_in_frame(n).count = freqs_in_frame(n).count + 1;
                freqs_in_frame(n).poits(:,freqs_in_frame(n).count) = frame(:,j);
                freqs_in_frame(n).freq = mean(freqs_in_frame(n).poits(7,:));
                
            else
                new_freq.freq = frame(7,j);
                new_freq.poits = frame(:,j);
                new_freq.count = 1;
                freqs_in_frame = [freqs_in_frame new_freq];
            end
        end
        
        for j = 1:length(freqs_in_frame)
            freq_poits = freqs_in_frame(j).poits;
            diff_poits = [];
            
            
            for m = 1:size(freq_poits,2)
                match_flag = 0;
                for n = 1:length(diff_poits)
                                        
                    if ~isempty(diff_poits(n).toa4)
                        new_toa = freq_poits(2:5,m);
                        old_toa = diff_poits(n).toa4;
                        dt1 = [];
                        for n1 = 1:4
                            if new_toa(n1) > 0 && old_toa(n1) > 0
                                dt1 = [dt1; new_toa(n1) - old_toa(n1)];
                            end
                        end
                        
                        if std(dt1) < 50 && length(dt1) > 1
                            match_flag = 1;
                            break;
                        else
                            continue;
                        end  
                    end
                    
                    match_count = 0;
                    
                    
                        
                        new_toa = freq_poits(2:5,m);
                        old_toa = diff_poits(n).toa(:,1);
                        dt = [];
                        for n1 = 1:4
                            if new_toa(n1) > 0 && old_toa(n1) > 0
                                dt = [dt; new_toa(n1) - old_toa(n1)];
                            end
                        end
                        
                        if std(dt) < 50
                            match_count = match_count + 1;
                        else
                            continue;
                        end
                        
                        new_toa = freq_poits(2:5,m);
                        old_toa = diff_poits(n).toa(:,end);
                        dt = [];
                        for n1 = 1:4
                            if new_toa(n1) > 0 && old_toa(n1) > 0
                                dt = [dt; new_toa(n1) - old_toa(n1)];
                            end
                        end
                        
                        if std(dt) < 50
                            match_count = match_count + 1;
                        else
                            continue;
                        end
                    
                    
                    if match_count == 2
                        match_flag = 1;
                        break;
                    end
                              
                end

                if match_flag
                    diff_poits(n).count = diff_poits(n).count + 1;
                    diff_poits(n).toa(:,diff_poits(n).count) = freq_poits(2:5,m);
                    toa = freq_poits(2:5,m);
                    if (length(find(toa > 0)) == 4)
                        new_poit.toa4 = freq_poits(2:5,m);
                    end
                else
                    new_poit.count = 1;
                    new_poit.toa(:,1) = freq_poits(2:5,m);
                    new_poit.toa4 = [];
                    toa = freq_poits(2:5,m);
                    if (length(find(toa > 0)) == 4)
                        new_poit.toa4 = freq_poits(2:5,m);
                    end
                    diff_poits = [diff_poits new_poit];
                end
            end
            freqs_in_frame(j).diff_poits = diff_poits;
        end
        
        if imp_count(frames_count) > 100 && length(freqs_in_frame) > 1
            size(frame,2);
            a = 5;
        end
        
        for j = 1:length(freqs_in_frame)
            for m = 1:length(freqs_in_frame(j).diff_poits)
                k1 = 0;
                x_d = [];
                k4 = 0;
                for n = 1:size(freqs_in_frame(j).diff_poits(m).toa,2)
                    toa = freqs_in_frame(j).diff_poits(m).toa(:,n) * config.c/1e9; 
                    nums = find(toa > 0);
                    if length(nums) == 4
                        [xx_d, flag, dop, nev, hei_geo] = coord_solver_2D_h(toa, config.posts, [0;0;0], -15e3:1000:15e3, config);
                        if flag
                            k1 = k1+1;
                            k4 = k4+1;
                            x_d(:,k1) = [xx_d; hei_geo];
                        end
                    end
                end
                
                if k4 > 0
                    for n = 1:size(freqs_in_frame(j).diff_poits(m).toa,2)
                        toa = freqs_in_frame(j).diff_poits(m).toa(:,n) * config.c/1e9; 
                        nums = find(toa > 0);
                        if length(nums) == 3
                            [xx_d, flag, dop, nev, hei_geo] = coord_solver_2D_h(toa(nums), config.posts(:,nums), [x_d([1 2 4],1)], x_d(3,1), config);
                            if flag
                                k1 = k1+1;
                                x_d(:,k1) = [xx_d; hei_geo];
                            end
                        end
                    end
                    
                end
                
                
                if k4 == 0 && size(freqs_in_frame(j).diff_poits(m).toa,2) > 5
                    for n = 1:size(freqs_in_frame(j).diff_poits(m).toa,2)
%                         [xx_d, flag, dop, nev, hei_geo] = coord_solver_2D_h3(freqs_in_frame(j).diff_poits(m).toa(:,n), config.posts,-15e3:1000:15e3, config);
                        [xx_d, flag, dop, nev, hei_geo] = coord_solver_2D_h3(freqs_in_frame(j).diff_poits(m).toa(:,n), config.posts,5000, config);
                       if flag
                            k1 = k1+1;
                            x_d(:,k1) = [xx_d; hei_geo];
                       end
                    end
%                     if k1 > 0
%                         plot(x_d(1,:),'b')
%                         hold on
%                         plot(x_d(2,:),'r')
%                         [std(x_d(1,:)) std(x_d(2,:))]
%                         hold off
%                     end
                end
                
                if k1 > 0
                    kp = kp + 1;
                    toa = [];
                    cord = [mean(x_d(1,:));mean(x_d(2,:));mean(x_d(3,:));mean(x_d(5,:))];
                    for n1 = 1:4
                        toa(n1,1) = norm(cord(1:3) - config.posts(:,n1))*1e9/config.c;
                    end
                    POITS(:,kp) = [cur_t;toa;-1;freqs_in_frame(j).freq;cord;k1;k4];
                end    
            end
            
            
        end
        

        
        
        frame = poits(:,i);
        cur_t = poits(1,i);        
    else
        frame = [frame poits(:,i)];
    end
end