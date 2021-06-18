[Frames] = my_log_reader();
[ config ] = config_build();
% frame_ready = struct('time', 0,'RD21', 0,'RD31', 0,'RD41',0,...
% 'RD32', 0,'RD42', 0,...
% 'RD43', 0,'freq', 0,'frame', 0);
% out1 = repmat(frame_ready,length(Frames),1);
%%
tic
frames_to_analyze = 1:7500;
frame_ready = struct('time', 0,'RD21', 0,'RD31', 0,'RD41',0,...
'RD32', 0,'RD42', 0,...
'RD43', 0,'freq', 0,'frame', 0);
out1 = repmat(frame_ready,7500,1);
parfor i = frames_to_analyze
    mod_frames = generate_sorted_imp(Frames(i), config);
    for j = 1:length(mod_frames)
        if mod_frames(j).freq ~= 1090000
            out1(i) = process_frame(out1(i),mod_frames(j), config);
            out1(i).frame = i;
        end
    end
end
k = 0;
for i=1:length(out1)
    if out1(i).RD41(1) || out1(i).RD31(1) || out1(i).RD21(1) ||...
            out1(i).RD32(1) || out1(i).RD42(1) || out1(i).RD43(1)
        k = k + 1;
        out3_peaks(k) = out1(i);
    end
end
% sort out val by freq
[out_sorted_by_freq] = sortbyfreq_new(out3_peaks);
toc
%% TO DO
% create line of position
create_line_of_position(config,out_sorted_by_freq(2).imps(30));
%%
[h21, h31, h32, h41, h42, h43] = test(config,[10000 ;10000 ;1000]);