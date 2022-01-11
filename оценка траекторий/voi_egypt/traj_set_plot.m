function [] = traj_set_plot(traj, x, y)
    set(traj.t1,'XData',x,'YData',y)
    set(traj.t2,'Position',[x(end) y(end) 0])
end

