function [] = create_line_of_position(config,imps)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(imps.RD21)
h21(i) = plot_hyperbole(config,config.PostsENU(1:2,2),config.PostsENU(1:2,1),imps.RD21(i),0);
% as211(i) = plot_asymptote(config,config.PostsENU(1:2,2),config.PostsENU(1:2,1),imps.RD21(i));
end
for i=1:length(imps.RD31)
h31(i) = plot_hyperbole(config,config.PostsENU(1:2,3),config.PostsENU(1:2,1),imps.RD31(i),0);
% as31(i) = plot_asymptote(config,config.PostsENU(1:2,3),config.PostsENU(1:2,1),imps.RD31(i));
end
for i=1:length(imps.RD32)
h32(i) = plot_hyperbole(config,config.PostsENU(1:2,3),config.PostsENU(1:2,2),imps.RD32(i),0);
% as31(i) = plot_asymptote(config,config.PostsENU(1:2,3),config.PostsENU(1:2,1),imps.RD31(i));
end
for i=1:length(imps.RD41)
h41(i) = plot_hyperbole(config,config.PostsENU(1:2,4),config.PostsENU(1:2,1),imps.RD41(i),0);
% as31(i) = plot_asymptote(config,config.PostsENU(1:2,3),config.PostsENU(1:2,1),imps.RD31(i));
end
for i=1:length(imps.RD42)
h42(i) = plot_hyperbole(config,config.PostsENU(1:2,4),config.PostsENU(1:2,2),imps.RD42(i),0);
% as31(i) = plot_asymptote(config,config.PostsENU(1:2,3),config.PostsENU(1:2,1),imps.RD31(i));
end
for i=1:length(imps.RD43)
h43(i) = plot_hyperbole(config,config.PostsENU(1:2,4),config.PostsENU(1:2,3),imps.RD43(i),0);
% as31(i) = plot_asymptote(config,config.PostsENU(1:2,3),config.PostsENU(1:2,1),imps.RD31(i));
end
%%
figure()
plot(config.posts(1,:),config.posts(2,:),'b ^')
hold on
axis([-2e4 2e4 -2e4 2e4])
for i=1:length(h21)
    if(imps.RD21(i)>0)
        plot(h21(i).x1,h21(i).y1,'r','LineWidth',2)
    else
        plot(h21(i).x2,h21(i).y2,'r','LineWidth',2)
    end
end
for i=1:length(h31)
    if(imps.RD31(i)>0)
        plot(h31(i).x1,h31(i).y1,'k','LineWidth',2)
    else
        plot(h31(i).x2,h31(i).y2,'k','LineWidth',2)
    end
end
for i=1:length(h41)
    if(imps.RD41(i)>0)
        plot(h41(i).x1,h41(i).y1,'g','LineWidth',2)
    else
        plot(h41(i).x2,h41(i).y2,'g','LineWidth',2)
    end
end
for i=1:length(h32)
    if(imps.RD32(i)>0)
        plot(h32(i).x1,h32(i).y1,'b','LineWidth',2)
    else
        plot(h32(i).x2,h32(i).y2,'b','LineWidth',2)
    end
end
for i=1:length(h42)
    if(imps.RD42(i)>0)
        plot(h42(i).x1,h42(i).y1,'c','LineWidth',2)
    else
        plot(h42(i).x2,h42(i).y2,'c','LineWidth',2)
    end
end
for i=1:length(h43)
    if(imps.RD43(i)>0)
        plot(h43(i).x1,h43(i).y1,'m','LineWidth',2)
    else
        plot(h43(i).x2,h43(i).y2,'m','LineWidth',2)
    end
end
end

