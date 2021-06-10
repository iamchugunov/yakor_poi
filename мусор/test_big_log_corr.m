% tic
% [Frames] = my_log_reader();
[ config ] = config_build()
% toc
% tic
k = 0;
% procent = 0.1;
% for i = 3320:length(Frames)
% out1 = struct('time', zeros(length(Frames),1),'RD21', zeros(length(Frames),1),'RD31', zeros(length(Frames),1),'RD41',zeros(length(Frames),1),...
% 'RD32', zeros(length(Frames),1),'RD42', zeros(length(Frames),1),...
% 'RD43', zeros(length(Frames),1),'freq', zeros(length(Frames),1),'frame', zeros(length(Frames),1));

frame_ready = struct('time', 1,'RD21', 1,'RD31', 1,'RD41',1,...
'RD32', 1,'RD42', 1,...
'RD43', 1,'freq', 1,'frame', 1);
out1 = repmat(frame_ready,length(Frames),1);
%%
for i = 4400:5400
    mod_frames = generate_sorted_imp(Frames(i), config);
    for j = 1:length(mod_frames)
        if mod_frames(j).freq ~= 1090000
            out1(i) = process_frame(out1(i),mod_frames(j), config);
            out1(i).frame = i;
%             if out1(i).RD41(1) || out1(i).RD31(1) || out1(i).RD21(1) ||...
%                     out1(i).RD32(1) || out1(i).RD42(1) || out1(i).RD43(1)
%                 k = k + 1;
%                 out(k) = out1;
%             end
        end
    end
%     if i/length(Frames) >= procent
%     fprintf("Выполнено %d процентов\n",procent * 100)
%     procent = procent + 0.1;
%     end
end
% toc