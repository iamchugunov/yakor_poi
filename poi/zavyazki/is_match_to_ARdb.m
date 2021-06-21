function [flag, ARdb] = is_match_to_ARdb(ARdb, rd, time, frame, rd_num)

    thres = 300;

    flag = 0;
    if rd(1) ~= 0
        for i = 1:length(rd)
            for j = 1:length(ARdb)
                [StateV] = Kalman_2_order_ZAV(ARdb(j),rd(i),time);
%                 if abs(ARdb(j).rd(end) - rd(i)) < thres

                if abs(StateV(1) - rd(i)) < thres
                    flag = 1;
                    ARdb(j).count = ARdb(j).count + 1;
                    ARdb(j).rd(ARdb(j).count) = rd(i);
                    ARdb(j).V_rd(ARdb(j).count) = StateV(2);
                    ARdb(j).time(ARdb(j).count) = time;
%                     [out_rd, matches, t] = make_identity(frame,rd(i),rd_num);
%                     ARdb(j).out_rd = [ARdb(j).out_rd out_rd];
%                     ARdb(j).time1 = [ARdb(j).time1 t];
%                     ARdb(j).rd1(ARdb(j).count) = mean(out_rd);
                end
            end
        end
    end
end

