function [] = corr_analyze(frame,config)
close all
%clearvars -except Frames frame config

Time_Ranges = zeros(size(config.posts,2));
for p = 1:size(config.posts,2)
   for q = 1:size(config.posts,2)
       if q > p
           Time_Ranges(p,q) = ceil(sqrt((config.posts(1,p) - config.posts(1,q))^2 + (config.posts(2,p) - config.posts(2,q))^2 + (config.posts(3,p) - config.posts(3,q))^2)/config.c*1e9);
       end
   end
end

[a1, a2, a3, a4] = make_corr_massives(frame, config);
A = [a1; a2; a3; a4];

%corr_set = struct([]);
for p = 1:size(config.posts,2)
   for q = 1:size(config.posts,2)
       if q > p
           %corr_set{q,p}
           [r,lags]= xcorr(A(p,:),A(q,:),Time_Ranges(p,q));
           %[r,lags]= xcorr(A(p,:),A(q,:));
           figure
           stem(lags,r)
           grid on           
       end
   end
end


end