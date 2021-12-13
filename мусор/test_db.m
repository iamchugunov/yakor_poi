function [db] = test_db(poits)
    db(1).poits(:,1) = poits(:,1);
    
    for i = 2:length(poits)
        
%         if i == 11554
%             
%             i
%         end
        match_flag = 0;
        for j = 1:length(db)
%             if j == 101
%                 j
%             end
            match_flag = 1;
            k = size(db(j).poits,2);
            while k > 0
                toa_prev = db(j).poits(:,k);
                toa = poits(:,i);
                dt = [];
                n = 0;
                for m = 2:5
                    if toa_prev(m) && toa(m)
                        n = n + 1;
                        dt(n) = toa(m) - toa_prev(m);
                    end
                end
                if std(dt) > 250
                    match_flag = 0;
                    break
                end
                k = k - 1;
                
                if size(db(j).poits,2) - k > 3
                    break
                end
            end
            
            if match_flag
                db(j).poits = [db(j).poits poits(:,i)];
                break;
                
            end
                
            
        end
        
        if ~match_flag
            db_nev.poits = poits(:,i);
%             if length(db) == 107
%                 a
%             end
            db = [db db_nev];
        end
    end
end

