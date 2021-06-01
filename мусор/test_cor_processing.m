%% read and process logs
[Frames] = my_log_reader();
[ config ] = config_build();
Frame_3008 = Frame(3008);
%%
[mod_frame] = generate_sorted_imp(Frame3464, config);
format long g;
%% get 3rd frequency
mod_frame_freq = mod_frame(2);
[uT_Post1,uT_Post2,uT_Post3,uT_Post4,dur_Post1,dur_Post2,dur_Post3,dur_Post4] = get_uT_and_dur(mod_frame_freq);
%% create time massive with 10ns resolution   
t = 0:1:12000000;
val_post1 = zeros(1,length(t));
val_post2 = zeros(1,length(t));
val_post3 = zeros(1,length(t));
val_post4 = zeros(1,length(t));
val_post_T1 = zeros(1,length(t));
val_post_T2 = zeros(1,length(t));
val_post_T3 = zeros(1,length(t));
val_post_T4 = zeros(1,length(t));
%% Расчет только по временам прихода
val_post1(uT_Post1) = 1;
val_post2(uT_Post2) = 1;
val_post3(uT_Post3) = 1;
val_post4(uT_Post4) = 1;
%%
c12 = conv(val_post1,val_post2,'same');
%%
c34 = conv(val_post3,val_post4,'same');
%%
[x12,lags12] =xcorr(val_post1,val_post2);
%%
[x34,lags34] =xcorr(val_post3,val_post4);

%% Расчет с учетом длительности импульса
for i=1:length(uT_Post1)
val_post_T1(uT_Post1(i):(uT_Post1(i)+dur_Post1(i))) = ones(1,length(dur_Post1(i)));
end
for i=1:length(uT_Post2)
val_post_T2(uT_Post2(i):(uT_Post2(i)+dur_Post2(i))) = ones(1,length(dur_Post2(i)));
end
for i=1:length(uT_Post3)
val_post_T3(uT_Post3(i):(uT_Post3(i)+dur_Post3(i))) = ones(1,length(dur_Post3(i)));
end
for i=1:length(uT_Post4)
val_post_T4(uT_Post4(i):(uT_Post4(i)+dur_Post4(i))) = ones(1,length(dur_Post4(i)));
end
%%
c12_T = conv(val_post_T1,val_post_T2,'same');
%%
c34_T = conv(val_post_T3,val_post_T4,'same');
%%
[x12_T,lags12_T] = xcorr(val_post_T1,val_post_T2);
[x13_T,lags13_T] = xcorr(val_post_T1,val_post_T3);
[x14_T,lags14_T] = xcorr(val_post_T1,val_post_T4);
%%
figure()
plot(lags12_T,x12_T)
title('корреляция между 12')
figure()
plot(lags13_T,x13_T)
title('корреляция между 13')
figure()
plot(lags14_T,x14_T)
title('корреляция между 14')
%%
figure()
plot(val_post_T1)
hold on
plot(val_post_T2)
title('импульсы на первом и втором посте')

figure()
plot(val_post_T1)
hold on
plot(val_post_T3)
title('импульсы на первом и третьем посте')

figure()
plot(val_post_T1)
hold on
plot(val_post_T4)
title('импульсы на первом и четвертом посте')