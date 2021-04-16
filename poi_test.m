function [database] = poi_test(poits)
    database = [];
    for i = 1:length(poits)
        if poits(i).freq == 1090000 && poits(i).count > 2 %обязательно больше двух отождествлений на постах
            ID = poits(i).d4c1;
            if isempty(database)
                database(1).ID = ID;
                database(1).k = 1; %число отметок в завязке
                database(1).data(:,database(1).k) = poits(i).imps(:,2);
            else
                match_flag = 0;
                for j = 1:length(database)
                    if strcmp(ID, database(j).ID)
                        match_flag = 1;
                        break;
                    end
                end
                
                if match_flag
                    database(j).k = database(j).k + 1; %число отметок в завязке
                    database(j).data(:,database(j).k) = poits(i).imps(:,2);
                else
                    database(j + 1).ID = ID;
                    database(j + 1).k = 1; %число отметок в завязке
                    database(j + 1).data(:,database(j+1).k) = poits(i).imps(:,2);
                end
            end
        end
    end
end

