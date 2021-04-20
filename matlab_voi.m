function [traj, zav] = matlab_voi(poits)

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
    
    K = 5;
    zav = [];
    traj = [];
    
    for i = 1:length(poits)
        match_flag = 0;
        for j = 1:length(traj)
            for k = length(traj(j).poits)-K+1:length(traj(j).poits)
                [dt] = calculate_period1(traj(j).poits(k), poits(i));
                if length(dt) > 1 && std(dt) < 20e-8 % && poits(i).count > 2
                    match_flag = 1;
                else
                    match_flag = 0;
                    break;
                end
            end
            if match_flag == 1
               break; 
            end
        end
        
        if match_flag == 0
            match_flag = 0;
            for j = 1:length(zav)
                for k = 1:length(zav(j).poits)
                    [dt] = calculate_period1(zav(j).poits(k), poits(i));
                    if length(dt) > 1 && std(dt) < 20e-8 && poits(i).count > 2
                        match_flag = 1;
                    else
                        match_flag = 0;
                        break;
                    end
                end
                if match_flag == 1
                   break; 
                end
            end

            if match_flag == 0 
                if poits(i).count > 2
                    zav(length(zav)+1).count = 1;
                    zav(length(zav)).poits(zav(length(zav)).count) = poits(i);
%                     zav(length(zav)).toa(:,zav(length(zav)).count) = poits(i).imps(:,2);
                end
            else
                zav(j).count = zav(j).count + 1;
                zav(j).poits(zav(j).count) = poits(i);
%                 zav(j).toa(:,zav(j).count) = poits(i).imps(:,2);
                if zav(j).count == K
                    traj(end+1).count = zav(j).count;
                    traj(end).poits = zav(j).poits;
                    traj(end).toa = zav(j).toa;
                    zav(j) = [];
                end
            end
        else
            
            traj(j).count = traj(j).count + 1;
            traj(j).poits(traj(j).count) = poits(i);
%             traj(j).toa(:,traj(j).count) = poits(i).imps(:,2);
        end
    end
    
 
    
    
            
        
        
        
            
    
end

function [dt] = calculate_period(poit1, poit2)

    for j = 1:4
        if poit1.imps(j,2) > 0 && poit2.imps(j,2) > 0
            dt(j) = poit2.imps(j,2) - poit1.imps(j,2);
        else
            dt(j) = 0;
        end
    end
    
    nums = find(dt > 0);
    dt = dt(nums);
    
end

function [dt] = calculate_period1(poit1, poit2)

    for j = 1:4
        if poit1.ToA(j) > 0 && poit2.ToA(j) > 0
            dt(j) = poit2.ToA(j) - poit1.ToA(j);
        else
            dt(j) = 0;
        end
    end
    
    nums = find(dt > 0);
    dt = dt(nums);
    
end



