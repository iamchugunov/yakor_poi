function [traj] = traj_add_poit(traj, poit)
    traj.all_poits_count = traj.all_poits_count + 1;
    traj.current_points_count = traj.current_points_count + 1;
    
    traj.t_last_poit = poit.Frame;
    if isempty(traj.ToA)
        traj.current_t0 = poit.Frame;
    end
    ToA = zeros(4,1);
    nums = find(poit.ToA > 0);
    ToA(nums) = poit.ToA(nums) + (traj.t_last_poit - traj.current_t0)*1e9;
    traj.all_poits(traj.all_poits_count) = poit;
    if traj.current_points_count == 1
        traj.current_poits = poit;
    else
        traj.current_poits(traj.current_points_count) = poit;
    end
    
    traj.ToA(:,traj.current_points_count) = ToA;
    traj.freq(:,traj.all_poits_count) = poit.freq;
    if (traj.ID == -1) && (poit.Smode ~= -1)
        traj.ID = poit.Smode;
%         set(traj.t2,'String',num2str(traj.ID))
    end
    if poit.count == 4
        traj.last_4 = poit;
        traj.last_4_flag = 1;
    end
    traj.lifetime = traj.t_last_poit - traj.t0;
    if poit.xy_valid
        traj.last_4_cord = poit.coords;
        traj.xy_valid = 1;
%         set(traj.t1,'XData',traj.last_4_cord(1),'YData',traj.last_4_cord(2))
%         set(traj.t2,'Position',[traj.last_4_cord(1) traj.last_4_cord(2) 0])
    end
    
    
%     pause(0.001)
end

