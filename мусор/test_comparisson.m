addpath('D:\github\disser\matlab');

clear all
config = Config();
config.sigma_ksi = 1;
config.sigma_t = 10e-9;
trace = ExtendedTrace(config, clock, 1);
trace.V = 1*200;
trace.N_periods = 0;
trace = trace.Initialization();
trace = trace.Go;

sv = trace.StateVector;
y = (trace.Measurements) * config.c;

d = 50;

for i = 1:length(y)
    [ xla,yla,Hla,dT, DOP, NEV, err, flag ] = Navigate3or4( config.posts, y(:,i), config.hei, sv(1,i), sv(4,i) );
    X_mnk(:,i) = [xla; yla; dT/config.c];
    
    if i >= d
        [x] = mnk_2d_v_const(config.posts, y(:,i+1-d:i));
        X_app_1(:,i-d+1) = [x(1);x(3);x(5)/config.c];
        X_app_2(:,i) = [x(1) + x(2) * x(end)/config.c;x(3) + x(4) * x(end)/config.c;(x(5) + x(end))/config.c];
        y_r1 = y(:,i+1-d) - x(5);
        y_r2 = y(:,i) - x(5) - x(end);
        X_app_d1(:,i-d+1) = NavSolver_D(y_r1, config.posts, [0;0], config.hei);
        X_app_d2(:,i) = NavSolver_D(y_r2, config.posts, [0;0], config.hei);
    end
end
X_app_1(:,length(y)-d:length(y)) = X_app_2(:,length(y)-d:length(y));
X_app_2(:,1:d) = X_app_1(:,1:d);

X_app_d1(:,length(y)-d:length(y)) = X_app_d2(:,length(y)-d:length(y));
X_app_d2(:,1:d) = X_app_d1(:,1:d);

figure
plot(sv(1,:),sv(4,:),'.')
hold on
plot(X_mnk(1,:),X_mnk(2,:),'x')
plot(X_app_1(1,:),X_app_1(2,:),'o')
plot(X_app_2(1,:),X_app_2(2,:),'^')
% plot(X_app_d1(1,:),X_app_d1(2,:),'o')
% plot(X_app_d2(1,:),X_app_d2(2,:),'^')
plot(config.posts(1,:),config.posts(2,:),'v')
grid on
daspect([1 1 1])

figure
plot(X_mnk(1,:) - sv(1,:),'k')
hold on
plot(X_mnk(2,:) - sv(4,:),'k')
plot(X_app_1(1,:) - sv(1,:),'b')
plot(X_app_1(2,:) - sv(4,:),'b')
plot(X_app_2(1,:) - sv(1,:),'r')
plot(X_app_2(2,:) - sv(4,:),'r')
% plot(X_app_d1(1,:) - sv(1,:),'g')
% plot(X_app_d1(2,:) - sv(4,:),'g')
% plot(X_app_d2(1,:) - sv(1,:),'y')
% plot(X_app_d2(2,:) - sv(4,:),'y')