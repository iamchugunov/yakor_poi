function [h] = plot_hyperbole(config,Post1,Post2,rd,plot_fig)

% F1 = [-3745.32043329822;-13395.2106709120];
% F2 = [12738.2072121844;-623.054252067746];
C = [(Post1(1)+Post2(1))/2 (Post1(2)+Post2(2))/2];
a = abs(rd/2);
c = sqrt((Post1(1)-C(1))^2 + (Post1(2)-C(2))^2);
e = c/a;
b = sqrt(a^2*(e^2-1));
t=-5:0.1:5;
% if(rd>0)
    x1 = a*cosh(t);
%     x2 = zeros(1,length(t));
% else
    x2 = -a*cosh(t);
%     x1 = zeros(1,length(t));
% end
y1 = b*sinh(t);
% alpha = rad2deg(atan((F1(2)-F2(2))/(F1(1)-F2(1))));
alpha = rad2deg(atan((Post1(2)-Post2(2))/(Post1(1)-Post2(1))));
%  alpha = rad2deg(atan(b/a));
% alpha =0;
h.x1 = (x1*cosd(alpha) - y1*sind(alpha)) + C(1);
h.y1 = (x1*sind(alpha) + y1*cosd(alpha)) + C(2);
h.x2 = (x2*cosd(alpha) - y1*sind(alpha)) + C(1);
h.y2 = (x2*sind(alpha) + y1*cosd(alpha)) + C(2);
%%
point1 = [h.x1(1);h.y1(1)];
rd1 = norm(point1 - [Post1(1);Post1(2)]) - norm(point1 - [Post2(1);Post2(2)]);
if(sign(rd1)==sign(rd))
    h.x2 = h.x1;
    h.y2 = h.y1;
else
    h.x1 = h.x2;
    h.y1 = h.y2;
end
if(plot_fig)
    figure()
    hold on
%     daspect([1 1 1])
    plot(Post1(1),Post1(2),'b ^')
    plot(Post2(1),Post2(2),'b ^')
    plot(C(1),C(2),'k x')
    plot(h.x1,h.y1,'r')
    plot(h.x2,h.y2,'r')
end
end