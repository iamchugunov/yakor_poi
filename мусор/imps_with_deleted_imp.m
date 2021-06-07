indexes_del = [1:3,8:14];
indexes = 1:14;

%%
uT_Post1(indexes_del) = [];
uT_Post2(indexes_del) = [];
uT_Post3(indexes_del) = [];
uT_Post4(indexes_del) = [];

dur_Post1(indexes_del) = [];
dur_Post2(indexes_del) = [];
dur_Post3(indexes_del) = [];
dur_Post4(indexes_del) = [];
%%
t = 0:1:12000000;
val_post_T1_10 = zeros(1,length(t));
val_post_T2_10 = zeros(1,length(t));
val_post_T3_10 = zeros(1,length(t));
val_post_T4_10 = zeros(1,length(t));

val_post_T1_14 = zeros(1,length(t));
val_post_T2_14 = zeros(1,length(t));
val_post_T3_14 = zeros(1,length(t));
val_post_T4_14 = zeros(1,length(t));
%%
for i=indexes_del
val_post_T1_10(uT_Post1(i):(uT_Post1(i)+dur_Post1(i))) = ones(1,length(dur_Post1(i)));
end
for i=indexes_del
val_post_T2_10(uT_Post2(i):(uT_Post2(i)+dur_Post2(i))) = ones(1,length(dur_Post2(i)));
end
for i=indexes_del
val_post_T3_10(uT_Post3(i):(uT_Post3(i)+dur_Post3(i))) = ones(1,length(dur_Post3(i)));
end
for i=indexes_del
val_post_T4_10(uT_Post4(i):(uT_Post4(i)+dur_Post4(i))) = ones(1,length(dur_Post4(i)));
end
%%
for i=indexes
val_post_T1_14(uT_Post1(i):(uT_Post1(i)+dur_Post1(i))) = ones(1,length(dur_Post1(i)));
end
for i=indexes
val_post_T2_14(uT_Post2(i):(uT_Post2(i)+dur_Post2(i))) = ones(1,length(dur_Post2(i)));
end
for i=indexes
val_post_T3_14(uT_Post3(i):(uT_Post3(i)+dur_Post3(i))) = ones(1,length(dur_Post3(i)));
end
for i=indexes
val_post_T4_14(uT_Post4(i):(uT_Post4(i)+dur_Post4(i))) = ones(1,length(dur_Post4(i)));
end
%%
[x12_T_10,lags12_T_10] = xcorr(val_post_T1_10,val_post_T2_10,ceil(config.ranges.r21 / config.c * 1e9));
[x13_T_10,lags13_T_10] = xcorr(val_post_T1_10,val_post_T3_10,ceil(config.ranges.r31 / config.c * 1e9));
[x14_T_10,lags14_T_10] = xcorr(val_post_T1_10,val_post_T4_10,ceil(config.ranges.r41 / config.c * 1e9));
%%
[x12_T_14,lags12_T_14] = xcorr(val_post_T1_14,val_post_T2_14,ceil(config.ranges.r21 / config.c * 1e9));
[x13_T_14,lags13_T_14] = xcorr(val_post_T1_14,val_post_T3_14,ceil(config.ranges.r31 / config.c * 1e9));
[x14_T_14,lags14_T_14] = xcorr(val_post_T1_14,val_post_T4_14,ceil(config.ranges.r41 / config.c * 1e9));
%%
figure();plot(lags12_T_10,x12_T_10);title('Корреляция между постами 1 2')
figure();plot(lags13_T_10,x13_T_10);title('Корреляция между постами 1 3')
figure();plot(lags14_T_10,x14_T_10);title('Корреляция между постами 1 4')
%%
figure();plot(lags12_T_14,x12_T_14);title('Корреляция между постами 1 2')
figure();plot(lags13_T_14,x13_T_14);title('Корреляция между постами 1 3')
figure();plot(lags14_T_14,x14_T_14);title('Корреляция между постами 1 4')