%% read and process logs
[Frames] = my_log_reader();
[ config ] = config_build();
Frame_3008 = Frame(3008);
[mod_frame_3008] = generate_sorted_imp(Frame_3008, config);
format long g;
%% get 3rd frequency
mod_frame_3008_freq3 = mod_frame_3008(3);
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
uT_Post1 = [mod_frame_3008_freq3.Post1.uT].';
uT_Post2 = [mod_frame_3008_freq3.Post2.uT].';
uT_Post3 = [mod_frame_3008_freq3.Post3.uT].';
uT_Post4 = [mod_frame_3008_freq3.Post4.uT].';
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
[x12,lags12] =xcorr(val_post1,val_post2);
%%
[x34,lags34] =xcorr(val_post3,val_post4);

%% Расчет с учетом длительности импульса
%% Расчет только по временам прихода
dur_Post1 = [mod_frame_3008_freq3.Post1.dur].';
dur_Post2 = [mod_frame_3008_freq3.Post2.dur].';
dur_Post3 = [mod_frame_3008_freq3.Post3.dur].';
dur_Post4 = [mod_frame_3008_freq3.Post4.dur].';
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
[x12_T,lags12_T] = xcorr(val_post_T1,val_post_T2);
%%
[x34_T,lags34_T] = xcorr(val_post_T3,val_post_T4);
 