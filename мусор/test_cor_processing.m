%% read and process logs
[Frames] = my_log_reader();
<<<<<<< HEAD
Frame3464 = Frames(3464);
%%
[ config ] = config_build();
[mod_frame3464] = generate_sorted_imp(Frame3464, config);
format long g;
%% get 3rd frequency
mod_frame_freq = mod_frame3464(4);
=======

>>>>>>> main
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
