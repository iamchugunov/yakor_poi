function [trace] = readtracefile(filename)

if nargin == 0
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
end

f = fopen(filename);
warning off
    k_poits = 0;
    k_traj = 0;
    k_stat = 0;
    k_modes = 0;
    k_trajm = 0;
%     
    fgetl(f);
%     
trace.poits = [];
trace.traj = [];
trace.stat = [];
trace.modes = [];
trace.trajm = [];
while feof(f)==0 
    s = fgetl(f);
    S = split(s);
    try
    switch S{2,1}
        case 'POIT'
            poit = [str2num(S{1,1}); 
                str2num(S{3,1});
                str2num(S{4,1});
                str2num(S{5,1});
                str2num(S{6,1}); 
                str2num(S{7,1});
                str2num(S{8,1});
                str2num(S{9,1});
                str2num(S{10,1});
                str2num(S{11,1});
                str2num(S{12,1});];
            k_poits = k_poits + 1;
            
            trace.poits(:,k_poits) = poit;
            
        case 'TRAJ'
            traj = [str2num(S{1,1}); 
                str2num(S{3,1});
                str2num(S{4,1});
                str2num(S{5,1});
                str2num(S{6,1}); 
                str2num(S{7,1});
                str2num(S{8,1});
                str2num(S{9,1});
                str2num(S{10,1});
                str2num(S{11,1});
                str2num(S{12,1})];
            k_traj = k_traj + 1;
            trace.traj(:,k_traj) = traj;
        case 'STAT'
            stat = [str2num(S{1,1}); 
                str2num(S{3,1});
                str2num(S{4,1})];
            k_stat = k_stat + 1;
            trace.stat(:,k_stat) = stat;
        case 'MODS'
            poit = [str2num(S{1,1}); 
                str2num(S{3,1});
                str2num(S{4,1});
                str2num(S{5,1});
                str2num(S{6,1}); 
                str2num(S{7,1});
                str2num(S{8,1});
                str2num(S{9,1});
                str2num(S{10,1});
                str2num(S{11,1});
                str2num(S{12,1});
                str2num(S{13,1})];
            k_modes = k_modes + 1;
            trace.modes(:,k_modes) = poit;
        case 'TORM'
            traj = [str2num(S{1,1});
                str2num(S{3,1});
                str2num(S{4,1});
                str2num(S{5,1});
                str2num(S{6,1});
                str2num(S{7,1});
                str2num(S{8,1});
                str2num(S{9,1});
                str2num(S{10,1});
                str2num(S{11,1});
                str2num(S{12,1})];
            k_trajm = k_trajm + 1;
            trace.trajm(:,k_trajm) = traj;
    end
    end
    
    
end

% if ~isempty(trace.traj)
%     trace.last_hei = trace.traj(6,end);
% else
%     trace.last_hei = [];
% end

if ~isempty(trace.poits)
    freqs = trace.poits(7,:);
    if std(freqs) == 0
        trace.freq = mean(freqs);
        trace.modes_percent = 100;
    else
        nums = find(freqs ~= 1090);
        trace.freq = mean(freqs(nums));
        trace.modes_percent = 100 - length(nums)/length(freqs) * 100;
    end    
else
    trace.freq = [];
    trace.modes_percent = [];
end

if ~isempty(trace.stat)
    trace.lifetime = trace.stat(2,end);
else
    trace.lifetime = 0;
end

if ~isempty(trace.poits)
    nums = find(trace.poits(6,:) > 0);
    if ~isempty(nums)
        trace.id = dec2hex(trace.poits(6,nums(1)));
    else
        trace.id = 0;
    end
else
    trace.id = 0;
end

if ~isempty(trace.modes)
    nums = find(trace.modes(6,:) > 0);
    if ~isempty(nums)
        IDS = unique(trace.modes(6,nums));
        trace.idm = dec2hex(IDS,6);
    else
        trace.idm = 0;
    end
else
    trace.idm = 0;
end

if ~isempty(trace.modes)
    nums = find(trace.modes(11,:) > 0);
    if ~isempty(nums)
        IDS = unique(trace.modes(11,nums));
        trace.squawk = dec2hex(IDS,4);
    else
        trace.squawk = 0;
    end
else
    trace.squawk = 0;
end


fclose(f);

end




