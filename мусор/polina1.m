K = 2*pi*380e6 * 2.5/3e8 % k0h1
h = 2.5;
lambda = 3e8/380e6

lambda = h/3;

theta = 0:0.01:90;

DN1 = 2 * abs(sin(K * cos(theta*pi/180)));

figure
plot(theta,DN1)
title("Задача 1")
xlabel('θ, град')
ylabel('F(θ)')
grid on
hold on

figure
polar(theta*pi/180,DN1)
title("Задача 1")


DN2 = 2 *sin(theta*pi/180) .* abs(cos(K * cos(theta*pi/180)));

figure
plot(theta,DN2)
title("Задача 2")
xlabel('θ, град')
ylabel('F(θ)')
grid on
hold on

figure
polar(theta*pi/180,DN2)
title("Задача 2")

e = 3;
Rg = (cosd(theta) - sqrt(e - sind(theta).^2))./(cosd(theta) + sqrt(e - sind(theta).^2));
DN3 = sqrt(1 + Rg.^2 - 2 * abs(Rg).*cos(2 * K * cosd(theta)));

figure
plot(theta,DN3)
title("Задача 3")
xlabel('θ, град')
ylabel('F(θ)')
grid on
hold on

figure
polar(theta*pi/180,DN3)
title("Задача 3")

e = 5;
% K = 6*pi
Rp = (e*cosd(theta) - sqrt(e - sind(theta).^2))./(e*cosd(theta) + sqrt(e - sind(theta).^2));
DN4 = sind(theta) .* sqrt(1 + Rp.^2 + 2 * abs(Rp).*cos(2 * K * cosd(theta)))

DN4_ = sind(theta) .* sqrt(1 + Rp.^2 + 2 * abs(Rp).*cos(2 * K * cosd(theta) - pi))

thetab = atan(sqrt(e))*180/pi

N = find(theta > thetab);

DN4(N(1):end) = DN4_(N(1):end);

figure
plot(theta,DN4)
title("Задача 4")
xlabel('θ, град')
ylabel('F(θ)')
grid on
hold on

figure
polar(theta*pi/180,DN4)
title("Задача 4")

