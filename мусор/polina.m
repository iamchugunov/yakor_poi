t = -pi:0.01:pi;
Fzox = ((1 + sin(2*abs(t)))/2) * cos(0);
Fzoy = ((1 + sin(2*abs(t)))/2) * cos(pi/2);
phi = 0:0.001:2*pi;
Fyox = ((1 + sin(2*abs(pi/2)))/2) * cos(phi);

figure(1)
polarplot(t,Fzox)
title("ZOX")
rlim([0 1])

figure(2)
polarplot(t,Fzoy)
title("ZOY")
rlim([0 1])

figure(3)
polarplot(phi,Fyox)
title("YOX")
rlim([0 1])
