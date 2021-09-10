function [out] = read_trace_folder()
    dir1 = uigetdir;
    files = dir(dir1);
    files = files(3:end);
    for i = 1:length(files)
        filename = fullfile(files(i).folder,files(i).name);
        [poits] = read_trace_file(filename);
        out(i).poits = poits;
    end
end



