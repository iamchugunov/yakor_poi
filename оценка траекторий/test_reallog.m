k = 0;
cord = [];
for i = 1:length(y)
        nums = find(y(:,i)>0);
            if length(nums) == 4
                k = k + 1;
                cord(:,k) = coord_solver_2D_h(y(nums',i)*config.c*1e9, config.posts(:,nums'), [0;0;0], 0:1000:14000);
            end
end
    
V_true = (cord(1:2,end) - cord(1:2,1))/(max(y(:,end)) - max(y(:,1)));

D2 = [];
D3 = [];
D4 = [];
T = [];
X_2D = [];
X_3D = [];
X_3_D = [];
X_ap = [];
X3f = [];

for i = 1:10

N = (1:100) + (i - 1) * 100;

Y = y(:,N);


T(i) = max(Y(:,1));

[X1, cord_4, hei] = make_first_estimation(Y*1e9, config);

[X2, R2, nev] = max_likelyhood_2dv(Y*1e9, config, [X1(1) X1(2) 0 X1(3) X1(4) 0 hei 0 0]');
X2 = X2([1 2 4 5]);

[X3, R3, nev] = max_likelyhood_3Da(Y*1e9, config, [X1(1) X1(2) 0 X1(3) X1(4) 0 hei 0 0]');
X3 = X3(1:9);


if i == 1
    [X4, R4, nev] = max_likelyhood_3Da(Y*1e9, config, [X1(1) X1(2) 0 X1(3) X1(4) 0 hei 0 0]');
    X4 = X4(1:9);
    X3f(:,i) = X4; 
    D_x = eye(9);
else
    dt = T(i) - T(i-1);
    F1 = [1 dt dt^2; 0 1 dt; 0 0 1];
            F = zeros(9,9);
            F(1:3,1:3) = F1;
            F(4:6,4:6) = F1;
            F(7:9,7:9) = F1;
    X_ext = F * X3f(:,i-1);
    [X4, R4, nev] = max_likelyhood_3Da(Y*1e9, config, X_ext);
    X4 = X4(1:9);
    
    d4 = inv(-R4);
    D4(:,i) = [d4(1,1); d4(2,2); d4(3,3); d4(4,4); d4(5,5); d4(6,6); d4(7,7); d4(8,8); d4(9,9)];
    D_n = diag(D4(:,i));
    D_ksi = diag([0.1 0.1 0.1].^2);
    [X3f(:,i), D_x] = Kalman_step_3D(X4, X3f(:,i-1), D_x, T(i) - T(i-1), D_n, D_ksi);
end

X_ap(:,i) = X1;
X_2D(:,i) = X2;
X_3D(:,i) = X3;
X_3_D(:,i) = X4;

d2 = inv(-R2);
D2(:,i) = [d2(1,1); d2(2,2); d2(3,3); d2(4,4)];
d3 = inv(-R3);
D3(:,i) = [d3(1,1); d3(2,2); d3(3,3); d3(4,4); d3(5,5); d3(6,6); d3(7,7); d3(8,8); d3(9,9)];



t = max(Y(:,end)) - max(Y(:,1));
XX1 = [X1(1) X1(1) + X1(2) * t; X1(3) X1(3) + X1(4) * t];
XX2 = [X2(1) X2(1) + X2(2) * t; X2(3) X2(3) + X2(4) * t];
XX3 = [X3(1) X3(1) + X3(2) * t + X3(3) * t^2/2; X3(4) X3(4) + X3(5) * t + X3(6) * t^2/2];

% plot(config.posts(1,:),config.posts(2,:),'v')
% hold on
% grid on
% plot(cord(1,:),cord(2,:),'.')
% plot(cord_4(1,:),cord_4(2,:),'x')
% plot(XX1(1,:),XX1(2,:),'k')
% plot(XX2(1,:),XX2(2,:),'r')
% plot(XX3(1,:),XX3(2,:),'b')



end


% legend('RS','mnk','mnk0','appr','2D','3D')


