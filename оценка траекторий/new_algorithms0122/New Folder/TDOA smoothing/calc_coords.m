function [x, y, z] = calc_coords(l,d)
% Вычислить число решений и топоцентрические координаты по разностям хода
%
%// Известны топоцентрические X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3 и разности хода d1, d2, d3
%// Вычисляем N - число решений (0, 1 или 2) и сами решения записываем в x[2], y[2], z[2]
X1 = l(1,1); Y1 = l(1,2); Z1 = l(1,3);
X2 = l(2,1); Y2 = l(2,2); Z2 = l(2,3);
X3 = l(3,1); Y3 = l(3,2); Z3 = l(3,3);
a1 = X1*X1 + Y1*Y1 + Z1*Z1;
a2 = X2*X2 + Y2*Y2 + Z2*Z2;
a3 = X3*X3 + Y3*Y3 + Z3*Z3;
delta = X1*(Y2*Z3 - Y3*Z2) + Y1*(X3*Z2 - X2*Z3) + Z1*(X2*Y3 - X3*Y2);
d1 = d(:,1); d2 = d(:,2); d3 = d(:,3);

d1 = timetable2table(d1,'ConvertRowTimes',false);
d2 = timetable2table(d2,'ConvertRowTimes',false);
d3 = timetable2table(d3,'ConvertRowTimes',false);
d1 = table2array(d1);
d2 = table2array(d2);
d3 = table2array(d3);

b1 = 0.5 * (a1 - d1 .* d1);
b2 = 0.5 * (a2 - d2 .* d2);
b3 = 0.5 * (a3 - d3 .* d3);

alphaX = ( b1 * (Y2*Z3 - Y3*Z2) - b2 * (Y1*Z3 - Y3*Z1) + b3 * (Y1*Z2 - Y2*Z1) ) / delta;
betaX  = ( d1 * (Y2*Z3 - Y3*Z2) - d2 * (Y1*Z3 - Y3*Z1) + d3 * (Y1*Z2 - Y2*Z1) ) / delta;
alphaY = ( b1 * (X3*Z2 - X2*Z3) - b2 * (X3*Z1 - X1*Z3) + b3 * (X2*Z1 - X1*Z2) ) / delta;
betaY  = ( d1 * (X3*Z2 - X2*Z3) - d2 * (X3*Z1 - X1*Z3) + d3 * (X2*Z1 - X1*Z2) ) / delta;
alphaZ = ( b1 * (X2*Y3 - X3*Y2) - b2 * (X1*Y3 - X3*Y1) + b3 * (X1*Y2 - X2*Y1) ) / delta;
betaZ  = ( d1 * (X2*Y3 - X3*Y2) - d2 * (X1*Y3 - X3*Y1) + d3 * (X1*Y2 - X2*Y1) ) / delta;
a = betaX .* betaX  + betaY .* betaY + betaZ .* betaZ - 1;
b = alphaX .* betaX + alphaY .* betaY + alphaZ .* betaZ;
c = alphaX .* alphaX + alphaY .* alphaY + alphaZ .* alphaZ;
D4 = b .* b - a .* c;
D4 = sqrt(D4); % !!!

b = - b;
r_plus  = (b + D4) ./ a;
r_minus = (b - D4) ./ a;
x(:, 1) = alphaX + betaX.*r_plus;
y(:, 1) = alphaY + betaY.*r_plus;
z(:, 1) = alphaZ + betaZ.*r_plus;
x(:, 2) = alphaX + betaX.*r_minus;
y(:, 2) = alphaY + betaY.*r_minus;
z(:, 2) = alphaZ + betaZ.*r_minus;

x_ind = (imag(x(:,1))~=0); x(x_ind,1) = NaN;
x_ind = (imag(x(:,2))~=0); x(x_ind,2) = NaN;
y_ind = (imag(y(:,1))~=0); y(y_ind,1) = NaN;
y_ind = (imag(y(:,2))~=0); y(y_ind,2) = NaN;
z_ind = (imag(z(:,1))~=0); z(z_ind,1) = NaN;
z_ind = (imag(z(:,2))~=0); z(z_ind,2) = NaN;
x = real(x);
y = real(y);
z = real(z);
end