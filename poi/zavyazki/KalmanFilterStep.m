function [StateV,D_x] = KalmanFilterStep(StateV,y,F,G,H,D_x,D_ksi,D_n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    I=diag(ones(size(D_x,1),1));
   %% Этап экстраполяции
   StateV_ext = F*StateV;
   Dx_ext = F*D_x*F' + G*D_ksi*G';
   
   %% Этап коррекции
%    if(~isnan(y(1,1)))
   K = Dx_ext*H'*(H*Dx_ext*H'+D_n)^-1;
   D_x = (I-K*H)*Dx_ext;
   StateV = StateV_ext+K*(y-H*StateV_ext);
%    else
%      StateV = StateV_ext;
%    end
end

