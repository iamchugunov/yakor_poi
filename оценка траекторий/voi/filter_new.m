function [fil] = filter_new(X, t0)
    fil.count = 1;
    fil.cur_SV = X;
    fil.t_last = t0;
    fil.Dx = [248943.396224333,8819.71440656607,189.900517108744,-345389.033649808,-12379.5754414779,-287.599071567403,193919.872639461,6742.86077788855,149.717341542425;8819.71440656561,588.698483658648,19.8640857890225,-12235.3609573422,-814.939472703589,-29.1799876093174,6725.60676352589,339.620928475034,9.63140190112756;189.900517108739,19.8640857890222,1.90410677113728,-274.552255505134,-28.3537297898972,-1.64169684258742,144.401576594705,9.43699096251196,0.336226588150061;-345389.033649803,-12235.3609573426,-274.552255505133,480188.747996357,17235.0596913143,393.014480316056,-270207.564990773,-9403.19996867193,-208.999781167614;-12379.5754414771,-814.939472703591,-28.3537297898977,17235.0596913136,1139.99948526761,39.9753209337169,-9493.64150783668,-479.512897072500,-13.6387516428201;-287.599071567374,-29.1799876093173,-1.64169684258746,393.014480316024,39.9753209337163,3.05648987224109,-215.370310033556,-13.6877473390135,-0.484089590598585;193919.872639409,6725.60676352457,144.401576594662,-270207.564990704,-9493.64150783529,-215.370310033566,331248.948083306,11979.1229437314,274.715785847962;6742.86077788730,339.620928474964,9.43699096250903,-9403.19996867040,-479.512897072417,-13.6877473390126,11979.1229437316,1021.82901022848,40.5802036933827;149.717341542413,9.63140190112604,0.336226588149966,-208.999781167605,-13.6387516428184,-0.484089590598558,274.715785847975,40.5802036933831,3.50153509400056];
    fil.SV(:,1) = X;
    fil.timestamps(1) = t0;
    fil.skipped = 0;
    fil.Dksi = diag([0.1 0.1 0.001].^2);
    fil.nev = [];
    fil.nev_all = [];
    fil.nev_coords = [];
end

