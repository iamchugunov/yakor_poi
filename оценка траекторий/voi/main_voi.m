function [trash, zav] = main_voi(poits, config)

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
    
    T_kill_zav = config.T_kill_zav;
    T_start_traj = config.T_start_traj;
    T_kill_traj = config.T_kill_traj;
    T_nak_traj = config.T_nak_traj;
    
    zav = struct([]);
    trash = struct([]);
    
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
        
        if match_flag_traj == 0
            match_flag_zav = 0;
            for j = 1:length(zav)
                match_flag_zav = isMatch_to_zav(zav(j), poits(i));
                if match_flag_zav == 1
                   break; 
                end
            end

            if match_flag_zav == 0 
                if poits(i).count > 2
                    j = length(zav) + 1;
                    if j == 1
                        zav = new_zav(poits(i), config);
                    else
                        zav(j) = new_zav(poits(i), config);
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
                zav(j) = add_poit_to_zav(zav(j), poits(i));
            end
            
        else
            
            traj(j).count = traj(j).count + 1;
            traj(j).poits(traj(j).count) = poits(i);
%             traj(j).toa(:,traj(j).count) = poits(i).imps(:,2);
        end
        
        nums = find(poits(i).Frame - [zav.t_last] > T_kill_zav);
        if nums
            nums
            if isempty(trash)
                trash = zav(nums);
            else
                trash(end+1:end+length(nums)) = zav(nums);
            end
            zav(nums) = [];
        end
        
        j = 1;
        while j <= length(zav)
            if isready_zav(zav(j))
                [flag, zav(j)] = make_first_estimation_zav(zav(j), config);
                zav(j) = [];
                j = j - 1;
            end
            j = j + 1;
        end
    end
    
    nums = find( [zav.t_last] - [zav.t0] < T_kill_zav);
    if nums
            nums
            if isempty(trash)
                trash = zav(nums);
            else
                trash(end+1:end+length(nums)) = zav(nums);
            end
            zav(nums) = [];
    end

end











