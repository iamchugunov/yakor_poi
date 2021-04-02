addpath('D:\github\disser\matlab')
clear all
config = Config();
config.PostsENU = config.posts;
config.sigma_ksi = 10;
trace = ExtendedTrace(config, clock, 1);
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

for i = 1:size(y,2)
    X1(:,i) = coord_solver2D(y(:,i)*config.c, config.posts, 0*[SV(1,i);SV(4,i);0], 10000);
end

K = floor(size(y,2)/N);
for i = 1:K
    nums = (1:N) + (i - 1)*N;
    Y = y(:,nums);
    [traj(:,nums), R] = make_esimation(Y, config);
    DD = -inv(R);
    D1(i) = DD(1,1);
    if i > 1
        X0 = traj(1:9,nums(:,1) - 1);
    else
        X0 = traj(1:9,1);
    end
    [traj1(:,nums), XX(:,i), R] = make_esimation_f(Y, config, SV(1:9,nums(1)));
    SV1(:,i) = SV(:,nums(1));
    DD = -inv(R);
    D2(i) = DD(1,1);
end

Y = y(:,K * N + 1:end);
[traj(:,K * N + 1:end)] = make_esimation(Y, config);

