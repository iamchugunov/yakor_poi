function [h21, h31, h32, h41, h42, h43] = test(config,user)
 rd21 = norm(user - config.posts(:,2)) - norm(user - config.posts(:,1));
 rd31 = norm(user - config.posts(:,3)) - norm(user - config.posts(:,1));
 rd41 = norm(user - config.posts(:,4)) - norm(user - config.posts(:,1));
 rd32 = norm(user - config.posts(:,3)) - norm(user - config.posts(:,2));
 rd42 = norm(user - config.posts(:,4)) - norm(user - config.posts(:,2));
 rd43 = norm(user - config.posts(:,4)) - norm(user - config.posts(:,3));
 h21 = plot_hyperbole(config,config.PostsENU(1:2,2),config.PostsENU(1:2,1),rd21,0);
 h31 = plot_hyperbole(config,config.PostsENU(1:2,3),config.PostsENU(1:2,1),rd31,0);
 h41 = plot_hyperbole(config,config.PostsENU(1:2,4),config.PostsENU(1:2,1),rd41,0);
 h32 = plot_hyperbole(config,config.PostsENU(1:2,3),config.PostsENU(1:2,2),rd32,0);
 h42 = plot_hyperbole(config,config.PostsENU(1:2,4),config.PostsENU(1:2,2),rd42,0);
 h43 = plot_hyperbole(config,config.PostsENU(1:2,4),config.PostsENU(1:2,3),rd43,0);

 %%
 
 %%
 figure()
plot(config.posts(1,:),config.posts(2,:),'b ^')
hold on
axis([-2e4 2e4 -2e4 2e4])
 for i=1:length(h21)
%     if(rd21>0)
        plot(h21(i).x1,h21(i).y1,'r')
%     else
        plot(h21(i).x2,h21(i).y2,'r')
%     end
end
for i=1:length(h31)
%     if(rd31>0)
        plot(h31(i).x1,h31(i).y1,'k')
%     else
        plot(h31(i).x2,h31(i).y2,'k')
%     end
end
for i=1:length(h41)
%     if(rd41>0)
        plot(h41(i).x1,h41(i).y1,'g')
%     else
        plot(h41(i).x2,h41(i).y2,'g')
%     end
end
for i=1:length(h32)
%     if(rd32>0)
        plot(h32(i).x1,h32(i).y1,'b')
%     else
        plot(h32(i).x2,h32(i).y2,'b')
%     end
end
for i=1:length(h42)
%     if(rd42>0)
        plot(h42(i).x1,h42(i).y1,'c')
%     else
        plot(h42(i).x2,h42(i).y2,'c')
%     end
end
for i=1:length(h43)
%     if(rd43>0)
        plot(h43(i).x1,h43(i).y1,'m')
%     else
        plot(h43(i).x2,h43(i).y2,'m')
%     end
end
end

