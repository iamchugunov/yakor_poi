poits = out.poits;
db = [];

for i = 19000:length(poits)
    
    
    i
    match_flag = 0;
    for j = 1:length(db)
        if calc1(poits(2:5,i), db(j).poits(2:5,end))
            match_flag = 1;
            db(j).poits(:,end + 1) = poits(:,i);
            break;
        end
    end
    
    if match_flag == 0
        db_nev.poits = poits(:,i);
        db = [db db_nev];
    end
end

function out = calc1(p1, plast)
    d = [];
    for i = 1:4
        if p1(i) > 0 && plast(i) > 0
            d = [d p1(i) - plast(i)];
        end
    end
    
    if std(d) < 350
        out = 1;
    else
        out = 0;
    end
    return;
end