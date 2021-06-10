tic
% [Frames] = my_log_reader();
toc
tic
k = 0;
procent = 0.1;
% for i = 3320:length(Frames)
for i = 4400:5400
    mod_frames = generate_sorted_imp(Frames(i), config);
    for j = 1:length(mod_frames)
        if mod_frames(j).freq ~= 1090000
            out1 = process_frame(mod_frames(j), config);
            out1.frame = i;
            if out1.RD41(1) || out1.RD31(1) || out1.RD21(1) || out1.RD32(1) || out1.RD42(1) || out1.RD43(1)
                k = k + 1;
                out(k) = out1;
            end
        end
    end
    if i/length(Frames) >= procent
    fprintf("Выполнено %d процентов\n",procent * 100)
    procent = procent + 0.1;
    end
end
toc