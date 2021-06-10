% tic
% [Frames] = my_log_reader();
[ config ] = config_build();
% toc
% tic

% procent = 0.1;
% for i = 3320:length(Frames)
% out1 = struct('time', zeros(length(Frames),1),'RD21', zeros(length(Frames),1),'RD31', zeros(length(Frames),1),'RD41',zeros(length(Frames),1),...
% 'RD32', zeros(length(Frames),1),'RD42', zeros(length(Frames),1),...
% 'RD43', zeros(length(Frames),1),'freq', zeros(length(Frames),1),'frame', zeros(length(Frames),1));

frame_ready = struct('time', 0,'RD21', 0,'RD31', 0,'RD41',0,...
'RD32', 0,'RD42', 0,...
'RD43', 0,'freq', 0,'frame', 0);
out1 = repmat(frame_ready,length(Frames),1);
%%
parfor i = 4400:5400
    disp(i);
    mod_frames = generate_sorted_imp(Frames(i), config);
    for j = 1:length(mod_frames)
        if mod_frames(j).freq ~= 1090000
            out1(i) = process_frame(out1(i),mod_frames(j), config);
            out1(i).frame = i;
        end
    end
end
%%
k = 0;
for i=1:length(out1)
    if out1(i).RD41(1) || out1(i).RD31(1) || out1(i).RD21(1) ||...
            out1(i).RD32(1) || out1(i).RD42(1) || out1(i).RD43(1)
        k = k + 1;
        out(k) = out1(i);
        disp(k)
        
    end
end

% sort out val by freq
[out_sorted_by_freq] = sortbyfreq_new(out);
%% TO DO
% create line of position

