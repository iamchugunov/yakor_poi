function [traj, id, freq, modes_percent, lifetime, freqs] = read_trace_3stan_file(filename)

if nargin == 0
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
end

    PostsBLH(:,1) = [51.400773; 39.035690; 172.5];
    PostsBLH(:,2) = [51.535456; 39.286083; 119.0];
    PostsBLH(:,3) = [51.552025; 38.989821; 196.4];
    PostsBLH(:,4) = [51.504039; 39.108616; 124.4];
% %     пїЅпїЅпїЅпїЅпїЅпїЅпїЅ
%     PostsBLH(:,1) = [40.106749; 44.325077; 851.2];
%     PostsBLH(:,2) = [40.221671; 44.518625; 1250.4];
%     PostsBLH(:,3) = [40.376235; 44.255345; 2034.1];
%     PostsBLH(:,4) = [40.204856; 44.376949; 1002.0];

    PostsBLH(:,1) = [30.125993; 30.953083; 175.0];
    PostsBLH(:,2) = [30.037910; 30.925568; 164.2];
    PostsBLH(:,3) = [30.191987; 30.857940; 105.3];
    PostsBLH(:,4) = [30.095281; 30.888021; 181.4];

    BLHref = PostsBLH(:,4);
    BLHref(3) = 0;

f = fopen(filename);
warning off
    k = 0;
%     
    fgetl(f);
    fgetl(f);
    fgetl(f);
    
    id = '-1';
    freqs = [];
    
%     
while feof(f)==0 
    s = fgetl(f);
    S = split(s);
    k = k + 1;
    time = S{1,1};
    time = str2num(time(1:2)) * 3600 + str2num(time(4:5)) * 60 + str2num(time(7:12));
    b = str2num(S{11,1});
    l = str2num(S{12,1});
    h = 10000;
    ve = str2num(S{13,1});
    vn = str2num(S{14,1});
    
    freq = str2num(S{9,1});
    freqs(k) = freq;
    
    ID = (S{2,1});
    
    if ID ~= "FFFFFF"
        id = ID;
    end
    
    X = BLH2ENU([b; l; h],BLHref);
    traj(:,k) = [time; X(1); ve; X(2); vn; X(3); norm([ve vn])];
            
end

    nums = find(freqs ~= 1090);
    if isempty(nums)
        modes_percent = 100;
        freq = 1090;
    else
        modes_percent = 100 * (1 - length(nums)/length(freqs));
        freq = mean(freqs(nums));
    end
    
    lifetime = traj(1,end) - traj(1,1);

fclose(f);

end



