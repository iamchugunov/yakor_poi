function [ config ] = config_build()
    addpath('мусор');
    %Воронеж
%     PostsBLH(:,1) = [51.400773; 39.035690; 172.5];
%     PostsBLH(:,2) = [51.535456; 39.286083; 119.0];
%     PostsBLH(:,3) = [51.552025; 38.989821; 196.4];
%     PostsBLH(:,4) = [51.504039; 39.108616; 124.4];
%     Армения
    PostsBLH(:,1) = [40.106749; 44.325077; 851.2];
    PostsBLH(:,2) = [40.221671; 44.518625; 1250.4];
    PostsBLH(:,3) = [40.376235; 44.255345; 2034.1];
    PostsBLH(:,4) = [40.204856; 44.376949; 1002.0];
    
    BLHref = mean(PostsBLH');
    BLHref(3) = 0;
    for i = 1:size(PostsBLH,2)
        PostsENU(:,i) = BLH2ENU(PostsBLH(:,i),BLHref);
    end
    config.BLHref = BLHref;
    config.PostsBLH = PostsBLH;
    config.PostsENU = PostsENU;
    config.c = 299792458;
    config.hei = 5000;
    config.StartNumber = 15; % число точек для завязки
    config.Vmax = 600;
    config.sigma_t = 100e-9;
    config.sigma_t_m = config.sigma_t*config.c;
    config.sigma_v = 10;
    config.sigma_d = 1e-6;
    config.posts_number = size(config.PostsENU,2);
    
    config.ranges.r21 = norm(PostsENU(:,2) - PostsENU(:,1));
    config.ranges.r31 = norm(PostsENU(:,3) - PostsENU(:,1));
    config.ranges.r41 = norm(PostsENU(:,4) - PostsENU(:,1));
    config.ranges.r32 = norm(PostsENU(:,3) - PostsENU(:,2));
    config.ranges.r42 = norm(PostsENU(:,4) - PostsENU(:,2));
    config.ranges.r43 = norm(PostsENU(:,4) - PostsENU(:,3));
end

