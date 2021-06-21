function [ZRdb] = add_rd_to_ZRdb(ZRdb, rd, time, frame, rd_num)
    % 
    % сколько макслагов добавляется в завязки
    if(length(rd)>5)
        N = 5;
    else
        N = length(rd);
    end
          
    % порог сравнения RD, м
    thres = 400;
    
    flag = 0;
    if rd(1) ~= 0
        for i = 1:N
            for j = 1:length(ZRdb)
                [StateV] = Kalman_2_order_ZAV(ZRdb(j),rd(i),time);
                if abs(StateV(1) - rd(i)) < thres
                    flag = 1;
                    ZRdb(j).count = ZRdb(j).count + 1;
                    ZRdb(j).rd(ZRdb(j).count) = rd(i);
                    ZRdb(j).V_rd(ZRdb(j).count) = StateV(2);
                    ZRdb(j).time(ZRdb(j).count) = time;
                    ZRdb(j).last_time = time;
%                     [out_rd, matches, t] = make_identity(frame,rd(i),rd_num);
%                     ZRdb(j).out_rd = [ZRdb(j).out_rd out_rd];
%                     ZRdb(j).time1 = [ZRdb(j).time1 t];
%                     ZRdb(j).rd1(ZRdb(j).count) = mean(out_rd);
                    break;
                end
            end
            if ~flag
                ZRdb(end+1).count = 1;
                ZRdb(end).rd(ZRdb(end).count) = rd(i);
                ZRdb(end).V_rd(ZRdb(end).count) = 0;
                ZRdb(end).time(ZRdb(end).count) = time;
                ZRdb(end).last_time = time;
                ZRdb(end).out_rd = [];
                ZRdb(end).time1 = [];
%                 [out_rd, matches, t] = make_identity(frame,rd(i),rd_num);
%                 ZRdb(end).out_rd = [ZRdb(end).out_rd out_rd];
%                 ZRdb(end).time1 = [ZRdb(end).time1 t];
%                 ZRdb(end).rd1(ZRdb(end).count) = mean(out_rd);
                flag = 0;
            end
        end
    end
end

