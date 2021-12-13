function [out] = read_trace_3stan_folder()
    dir1 = uigetdir;
    files = dir(dir1);
    files = files(3:end);
    for i = 1:length(files)
        filename = fullfile(files(i).folder,files(i).name);
        try
            [traj, id, freq, modes_percent, lifetime, freqs] = read_trace_3stan_file(filename);
        catch
            continue;
        end
        out(i).traj = traj;
        out(i).id = id;
        out(i).freq = freq;
        out(i).freqs = freqs;
        out(i).modes_percent = modes_percent;
        out(i).lifetime = lifetime;
    end
end





