%% read and process logs
[Frames] = my_log_reader();
Frame3464 = Frames(3464);
%%
[ config ] = config_build();
[mod_frame3464] = generate_sorted_imp(Frame3464, config);
format long g;
%% get 3rd frequency
mod_frame_freq = mod_frame3464(4);
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
uT_Post1 = [mod_frame_freq.Post1.uT].';
uT_Post2 = [mod_frame_freq.Post2.uT].';
uT_Post3 = [mod_frame_freq.Post3.uT].';
uT_Post4 = [mod_frame_freq.Post4.uT].';
%%
val_post1(uT_Post1) = 1;
val_post2(uT_Post2) = 1;
val_post3(uT_Post3) = 1;
val_post4(uT_Post4) = 1;
%%
c12 = conv(val_post1,val_post2,'same');
%%
c34 = conv(val_post3,val_post4,'same');
%%
[x12,lags12] =xcorr(val_post1,val_post2,ceil(config.ranges.r21/config.c*1e9));
%%
[x34,lags34] =xcorr(val_post3,val_post4);

%% Расчет с учетом длительности импульса
%% Расчет только по временам прихода
% dur = 10ns
dur_Post1 = [mod_frame_freq.Post1.dur].'.*10;
dur_Post2 = [mod_frame_freq.Post2.dur].'.*10;
dur_Post3 = [mod_frame_freq.Post3.dur].'.*10;
dur_Post4 = [mod_frame_freq.Post4.dur].'.*10;
%%
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
[x12_T_14,lags12_T_14] = xcorr(val_post_T1,val_post_T2,ceil(config.ranges.r21 / config.c * 1e9));
[x13_T_14,lags13_T_14] = xcorr(val_post_T1,val_post_T3,ceil(config.ranges.r31 / config.c * 1e9));
[x14_T_14,lags14_T_14] = xcorr(val_post_T1,val_post_T4,ceil(config.ranges.r41 / config.c * 1e9));
%%
figure();plot(lags12_T,x12_T);title('Корреляция между постами 1 2')
figure();plot(lags13_T,x13_T);title('Корреляция между постами 1 3')
figure();plot(lags14_T,x14_T);title('Корреляция между постами 1 4')
%%
figure();plot(val_post_T1);hold on;plot(val_post_T2);title('Импульсы на постах 1 2')
figure();plot(val_post_T1);hold on;plot(val_post_T3);title('Импульсы на постах 1 3')
figure();plot(val_post_T1);hold on;plot(val_post_T4);title('Импульсы на постах 1 4')

%%
[x23_T,lags23_T] = xcorr(val_post_T2,val_post_T3,ceil(config.ranges.r32 / config.c * 1e9));
[x24_T,lags24_T] = xcorr(val_post_T2,val_post_T4,ceil(config.ranges.r42 / config.c * 1e9));
%%
figure();plot(lags23_T,x23_T);title('Корреляция между постами 2 3')
figure();plot(lags24_T,x24_T);title('Корреляция между постами 2 4')
%%
figure();plot(val_post_T2);hold on;plot(val_post_T3);title('Импульсы на постах 2 3')
figure();plot(val_post_T2);hold on;plot(val_post_T4);title('Импульсы на постах 2 4')

%%
[x34_T,lags34_T] = xcorr(val_post_T3,val_post_T4,config.ranges.r43 / config.c * 1e9);
%%
[lags_at_max_corr] = sortbylag(x12_T,lags12_T);
[val_post_T2_displace,t_displace] = displace_by_lag(val_post_T2,lags_at_max_corr(end));
[x12_Td,lags12_Td] = xcorr(val_post_T1,val_post_T2_displace,ceil(config.ranges.r21 / config.c * 1e9));
%%
figure()
plot(t_displace,val_post_T2_displace)
hold on
plot(t,val_post_T2)
%%
figure()
plot(lags12_Td,x12_Td)
hold on
plot(lags12_T,x12_T)
%% 12
[x12_T_full,lags12_T_full] = xcorr(val_post_T1,val_post_T2);
% for constrain corr vector by ranges
nums = find(abs(lags12_T_full)<=ceil(config.ranges.r21 / config.c * 1e9));
figure();plot(lags12_T_full(nums),x12_T_full(nums))
%% 13
[x13_T_full,lags13_T_full] = xcorr(val_post_T1,val_post_T3);
nums = find(abs(lags13_T_full)<=ceil(config.ranges.r31 / config.c * 1e9));
figure();plot(lags13_T_full(nums),x13_T_full(nums))
%%
N = 1;
[val_post_T2_displace,t_displace] = displace_by_lag(val_post_T2, lags_at_max_corr(N));
[x23_Td_full,lags23_Td_full] = xcorr(val_post_T2_displace,val_post_T3);
nums23 = find(abs(lags23_Td_full - lags_at_max_corr(N))<=ceil(config.ranges.r32 / config.c * 1e9 ));
nums13 = find(abs(lags13_T_full)<=ceil(config.ranges.r31 / config.c * 1e9));
figure();
plot(lags23_Td_full(nums23),x23_Td_full(nums23))
hold on
plot(lags13_T_full(nums13),x13_T_full(nums13))
