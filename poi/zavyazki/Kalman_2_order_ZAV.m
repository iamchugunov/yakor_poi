function [out] = Kalman_2_order_ZAV(RD,rd,time)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%%
T = time - RD.last_time;
y = rd;
%%
sigma_ksi = 25;
sigma_n = 50;
%%
D_ksi = (1*sigma_ksi)^2; % имеет размерность формирующей компоненты вектора состояния
D_n = (1*sigma_n)^2; % имеет размерность равную числу наблюдаемых величин
StateV(:,1) = [RD.rd(end);RD.V_rd(end)];
D_x = [1 0 ; 0 1];
%%
for k=2:2
    F=[1 T;
        0 1];
    G=[0;T];
    H = [1 0];
    [StateV(:,k),D_x] = KalmanFilterStep(StateV(:,k-1),y,F,G,H,D_x,D_ksi,D_n);
end
out = StateV(:,2);
end

