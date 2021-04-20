

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %times
    time_log = Frames(500).time-Frames(1).time;
    time_frame = Frames(2).time-Frames(1).time;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    V_plane = 300; % обычная скорость самолета м/с
    config  = config_build();
    
    
    num_frame = find([Frames.time] == cursor_info.Position(1,1)) %номер кадра
    num_frame = 127;
    num_imp = find([Frames(num_frame).Post4.T] == cursor_info.Position(1,1)) %номер импульса в кадре
    
    res = frame_analysys(Frames(127), config);
    
    
    %вот этот код нужно разобрать
    kkk=0;
    foursome_index_prev = 0;
    foursome_prev = 0;
    kk=1;
    n=1;
    kleimo = 0;
    for i=1:size(res.data,2)
        foursome_index = find(res.data(:,i)~=0);
        foursome = res.data(foursome_index,i);
        if size(foursome_index,1)==size(foursome_index_prev,1)  
            if foursome_index==foursome_index_prev
                for j=1:size(foursome_index,1)
%                     if foursome(j,1) == foursome_prev(j,1)
                    if res.data(foursome_index(j,1),i) == res.data(foursome_index_prev(j,1),i-1)
                        if kkk==0
                            kkk=1;
                            vrem_foursomes(:,kk) = res.data(:,i-1);
                            kk=kk+1;
                            n=n-1;
                            matches(:,n) = 0;
                        end
                        work_field2 = eval(['Frames(127).Post' num2str(j)]);
                        vrem_foursomes(:,kk) = res.data(:,i);
                        kk=kk+1;
                        kleimo = 1;
                        break
                    end
                    
                end
                
                if kkk==0
                    foursome_index_prev = foursome_index;
                    foursome_prev = foursome;
                    matches(:,n) = res.data(:,i);
                    n=n+1;
                
                elseif kkk==1 && kleimo==1
                    foursome_index_prev = foursome_index;
                    foursome_prev = foursome;
                    kleimo = 0;
                else
                    
                    kkk=0;
                    idx = find(foursome_index~=j);
                    work_field1 = eval(['Frames(127).Post' num2str(idx(1,1))]);
                   
                    for zz=1:size(vrem_foursomes,2)
                        for zzz=1:size(vrem_foursomes,2)
                            norm_E3(zz,zzz) = norm_Euc(work_field1(vrem_foursomes(idx(1,1),zzz)),work_field2(vrem_foursomes(j,zzz)),3);
                        end
                    end
                    
                    [M,Ii] = min(norm_E3);                     
                    [M,Ij] = min(M);
                    work_field_best = vrem_foursomes(:,Ij);
                    matches(:,n) = work_field1_best;
                    n=n+1;
                    foursome_index_prev = foursome_index;
                    foursome_prev = foursome;
                    vrem_foursomes = 0;
                    kk=1;
                    
                    
                end
            else
                if kkk==0
                    foursome_index_prev = foursome_index;
                    foursome_prev = foursome;
                    matches(:,n) = res.data(:,i);
                    n=n+1;
                else
                    kkk=0;
                    idx = find(foursome_index~=j);
                    work_field1 = eval(['Frames(127).Post' num2str(idx(1,1))]);
                   
                    for zz=1:size(vrem_foursomes,2)
                        for zzz=1:size(vrem_foursomes,2)
                            norm_E3(zz,zzz) = norm_Euc(work_field1(vrem_foursomes(idx(1,1),zzz)),work_field2(vrem_foursomes(j,zzz)),3);
                        end
                    end
                    
                    [M,Ii] = min(norm_E3);                     
                    [M,Ij] = min(M);
                    work_field_best = vrem_foursomes(:,Ij);
                    matches(:,n) = work_field1_best;
                    n=n+1;
                    foursome_index_prev = foursome_index;
                    foursome_prev = foursome;
                    vrem_foursomes = 0;
                    kk=1;
                end
                    
            end
        else
            if kkk==0
                foursome_index_prev = foursome_index;
                foursome_prev = foursome;
                matches(:,n) = res.data(:,i);
                n=n+1;
            else
                kkk=0;
                idx = find(foursome_index~=j);
                work_field1 = eval(['Frames(127).Post' num2str(idx(1,1))]);
                
                for zz=1:size(vrem_foursomes,2)
                        for zzz=1:size(vrem_foursomes,2)
                            norm_E3(zz,zzz) = norm_Euc(work_field1(vrem_foursomes(idx(1,1),zzz)),work_field2(vrem_foursomes(j,zzz)),3);
                        end
                end
                
                [M,Ii] = min(norm_E3);                     
                [M,Ij] = min(M);

                work_field_best = vrem_foursomes(:,Ij);
                matches(:,n) = work_field1_best;
                n=n+1;
                foursome_index_prev = foursome_index;
                foursome_prev = foursome;
                vrem_foursomes = 0;
                kk=1;
            end
        end
    end