function [fake_frame] = make_fake_frame()
    T = 6.5e-6; %sec
    Tmax = 10e-3; %sec
    tdoa = 18365e-9; % sec
    dur = 100e-9; % sec
    
    %ns
    T1 = randi([0 100000]);
    T = T * 1e9;
    Tmax = Tmax * 1e9;
    tdoa = tdoa * 1e9;
    T2 = T1 + tdoa;
    dur = dur * 1e9;
    
    k1 = 0;
    while T1 < Tmax
        k1 = k1 + 1;
        fake_frame.Post1(k1).uT = T1;
        fake_frame.Post1(k1).T = T1;
        fake_frame.Post1(k1).dur = dur;
        fake_frame.Post1(k1).freq = 1;
        T1 = T1 + T;
    end
    k2 = 0;
    while T2 < Tmax
        k2 = k2 + 1;
        fake_frame.Post2(k2).uT = T2;
        fake_frame.Post2(k2).T = T2;
        fake_frame.Post2(k2).dur = dur;
        fake_frame.Post2(k2).freq = 1;
        T2 = T2 + T;
    end
    
    fake_frame.Post3 = [];
    fake_frame.Post4 = [];
        
end

