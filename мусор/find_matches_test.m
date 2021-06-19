function [k, rd, delta, norm_d] = find_matches_test(one_frame)
    RD21 = one_frame.RD21;
    RD31 = one_frame.RD31;
    RD41 = one_frame.RD41;
    RD32 = one_frame.RD32;
    RD42 = one_frame.RD42;
    RD43 = one_frame.RD43;
    min_nev = 1e10;
    k = 0;
    for i1 = 1:length(RD21)
        for i2 = 1:length(RD31)
            for i3 = 1:length(RD41)
                for i4 = 1:length(RD32)
                    for i5 = 1:length(RD42)
                        for i6 = 1:length(RD43)
                            if check_rd(RD21(i1), RD31(i2), RD32(i4)) * check_rd(RD21(i1), RD41(i3), RD42(i5)) * check_rd(RD31(i2), RD41(i3), RD43(i6)) * check_rd(RD32(i4), RD42(i5), RD43(i6))
                               [flag, d(:,1)] = check_rd(RD21(i1), RD31(i2), RD32(i4));
                               [flag, d(:,2)] = check_rd(RD21(i1), RD41(i3), RD42(i5));
                               [flag, d(:,3)] = check_rd(RD31(i2), RD41(i3), RD43(i6));
                               [flag, d(:,4)] = check_rd(RD32(i4), RD42(i5), RD43(i6));
                               k = k + 1; 
                               rd(:,k) = [RD21(i1);RD31(i2); RD41(i3); RD32(i4); RD42(i5); RD43(i6)];
                               delta(:,k) = d;
                               norm_d(:,k) = norm(d);
                            end
                        end
                    end
                end
            end
        end
    end
end

function [flag, delta] = check_rd(rd1, rd2, rd3)
    delta = abs(rd2 - rd1 - rd3);
    if abs(rd2 - rd1 - rd3) < 1
        flag = 1;
    else
        flag = 0;
    end
end




