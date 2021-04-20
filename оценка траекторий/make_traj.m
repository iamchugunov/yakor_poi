addpath('D:\github\disser\matlab')
clear all
config = Config();
config1 = config_build;
config.PostsENU = config1.PostsENU;
config.posts = config1.posts;
trace = ExtendedTrace(config, clock, 4);
trace.V = 200;
trace.N_periods = 0;
trace = trace.Initialization();
trace = trace.Go;
N = 10;
y = trace.Measurements*1e9;
SV = trace.StateVector;
SV(10,:) = SV(9,:) * 1e9;
SV(8:9,:) = 0;
config.sigma_n = config.sigma_t;
config.sigma_n = 10;
config.c = config.c/1e9;