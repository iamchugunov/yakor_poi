db = [];
poits = out.poits;

plot(config.posts(1,:),config.posts(2,:),'v')
hold on
grid on

for i = 1:length(poits)
    plot(out(1).poits(8,i),out(1).poits(9,i),'x')
    
    cur_toa = out(1).poits(2:5,i);
    cur_c = out(1).poits(8:9,i);
    
    match_flag = 0;
    for j = 1:length(db)
        delta = norm(db(j).poits_c(:,end) - cur_c)
        stdtoa = [];
        k1 = 0;
        for k = 1:4
            if cur_toa(k) > 0 && db(j).toa(k,end) > 0
                stdtoa = [stdtoa cur_toa(k) - db(j).toa(k,end)];
                k1 = k1+1;
            end
            
        end
        
        
        if k1 > 2
            std(stdtoa)
        end
        
        if delta < 300
            match_flag = 1;
            db(j).poits_c(:,end + 1) = cur_c;
            db(j).toa(:,end + 1) = cur_toa;
            break
        end
        
        
    end
    
    if match_flag == 0
            db_new = [];
            db_new.poits_c = cur_c;
            db_new.toa = cur_toa;
            db = [db db_new];
    end
end