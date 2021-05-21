function [traj, zav, trash_traj, trash_zav] = main_voi(poits, config)
    figure(1)
    plot(config.posts(1,:),config.posts(2,:),'kv')
    grid on
    hold on
    axis([-1e5 1e5 -1e5 1e5])
%     N = 10;
%     k = 0;
%     for i = 1:length(poits)-N
%         for n = i+1:i+N
%             [dt] = calculate_period1(poits(i), poits(n));
%             if length(dt) > 3
%                 k = k + 1;
%                 minmaxdt(k) = max(dt) - min(dt);
%                 stddt(k) = std(dt);
%                 t(k) = mean(dt);
%             end
%         end
%     end
%     minmaxdt = minmaxdt(find(minmaxdt) > 0);
%     stddt = stddt(find(stddt) > 0);
    
    zav_T_kill = config.zav_T_kill;
    traj_T_start = config.traj_T_start;
    traj_T_kill = config.traj_T_kill;
    traj_T_nak = config.traj_T_nak;
    
    zav = struct([]);
    trash_zav = struct([]);
    
    traj = struct([]);
    trash_traj = struct([]);
    
    for i = 1:length(poits)
        i
        
        if poits(i).freq > 9000
            continue
        end
        
        if poits(i).count == 4
            X0 = zeros(4,1);
            X0(3) = max(poits(i).ToA) * config.c;
            poits(i) = poit_calc(poits(i), X0, config);
        end
        
        match_flag_traj = 0;
        for j = 1:length(traj)
            match_flag_traj = traj_isMatch(traj(j), poits(i));
                if match_flag_traj == 1
                   break; 
                end
        end
        
        if match_flag_traj == 0
            match_flag_zav = 0;
            for j = 1:length(zav)
                match_flag_zav = zav_isMatch(zav(j), poits(i));
                if match_flag_zav == 1
                   break; 
                end
            end

            if match_flag_zav == 0 
                if poits(i).count > 2
                    j = length(zav) + 1;
                    if j == 1
                        zav = zav_new(poits(i), config);
                    else
                        zav(j) = zav_new(poits(i), config);
                    end
                else
                    continue;
                end
            end
            
            if j
                if zav(j).xy_valid && poits(i).count == 3
                    X0 = zav(j).last_4_cord;
                    X0(4) = max(poits(i).ToA) * config.c;
                    poits(i) = poit_calc(poits(i), X0, config);
                end
                zav(j) = zav_add_poit(zav(j), poits(i));
            end
            
        else
            
            if traj(j).xy_valid && poits(i).count == 3
                X0 = traj(j).last_4_cord;
                X0(4) = max(poits(i).ToA) * config.c;
                poits(i) = poit_calc(poits(i), X0, config);
            end
            traj(j) = traj_add_poit(traj(j), poits(i));
        end
        
        nums = find(poits(i).Frame - [zav.t_last] > zav_T_kill);
        if nums
            nums
            if isempty(trash_zav)
                trash_zav = zav(nums);
            else
                trash_zav(end+1:end+length(nums)) = zav(nums);
            end
            zav(nums) = [];
        end
        
        if length(traj) > 0
            nums = find(poits(i).Frame - [traj.t_last_poit] > traj_T_kill);
            if nums
                nums
                disp("ТРАЕКТОРИЯ УМЕРЛА ПО ТАЙМАУТУ")
                if isempty(trash_traj)
                    trash_traj = traj(nums);
                else
                    trash_traj(end+1:end+length(nums)) = traj(nums);
                end
                traj(nums) = [];
            end
        end
        
        j = 1;
        while j <= length(zav)
            if zav_isready(zav(j))
                [flag, zav(j)] = zav_make_first_estimation(zav(j), config);
                if flag
                    n = length(traj) + 1;
                    if n == 1
                        traj = traj_new(zav(j), config);
                    else
                        traj(n) = traj_new(zav(j), config);
                    end
                    zav(j) = [];
                    j = j - 1;
                else
                    if zav(j).hard_start_flag > 1
                        if length(trash_zav) == 0
                            trash_zav = zav(j);
                        else
                            trash_zav(end+1) = zav(j);
                        end
                        zav(j) = [];
                        j = j - 1;
                    end
                end
                
            end
            j = j + 1;
        end

        j = 1;
        while j <= length(traj)
            if traj_isready(traj(j))
                [flag, traj(j)] = traj_make_estimation(traj(j), config);
            end
            j = j + 1;
        end

    end
    
    nums = find( [zav.t_last] - [zav.t0] < zav_T_kill);
    if nums
            nums
            if isempty(trash_zav)
                trash_zav = zav(nums);
            else
                trash_zav(end+1:end+length(nums)) = zav(nums);
            end
            zav(nums) = [];
    end

end


