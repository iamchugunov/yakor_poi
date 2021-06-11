function [as] = plot_asymptote(config,Post1,Post2,rd)


C = [(Post1(1)+Post2(1))/2 (Post1(2)+Post2(2))/2];
a = abs(rd/2);
c = sqrt( (Post1(1)-C(1))^2 + (Post1(2)-C(2))^2);
e = c/a;
b = sqrt(a^2*(e^2-1));
x = -1e5:100:1e5;
y1 = b/a .* x;
y2 = -b/a .* x;
alpha = rad2deg(atan((Post1(2)-Post2(2))/(Post1(1)-Post2(1))));
as.x1 = (x*cosd(alpha) - y1*sind(alpha)) + C(1);
as.y1 = (x*sind(alpha) + y1*cosd(alpha)) + C(2);
as.x2 = (x*cosd(alpha) - y2*sind(alpha)) + C(1);
as.y2 = (x*sind(alpha) + y2*cosd(alpha)) + C(2);
end