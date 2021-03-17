subplot(241)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(1))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(1)*pi/180),[0:200000]*sin(azs(1)*pi/180))
subplot(242)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(2))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(2)*pi/180),[0:200000]*sin(azs(2)*pi/180))
subplot(243)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(3))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(3)*pi/180),[0:200000]*sin(azs(3)*pi/180))
subplot(244)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(4))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(4)*pi/180),[0:200000]*sin(azs(4)*pi/180))
subplot(245)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(5))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(5)*pi/180),[0:200000]*sin(azs(5)*pi/180))
subplot(246)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(6))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(6)*pi/180),[0:200000]*sin(azs(6)*pi/180))
subplot(247)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(7))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(7)*pi/180),[0:200000]*sin(azs(7)*pi/180))
subplot(248)
plot(config.PostsENU(1,:),config.PostsENU(2,:),'vk','linewidth',2)
grid on
hold on
daspect([1 1 1])
plot_az(res, azs(8))
axis([-200000 200000 -200000 200000])
plot([0:200000]*cos(azs(8)*pi/180),[0:200000]*sin(azs(8)*pi/180))