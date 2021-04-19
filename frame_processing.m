function [matches,poits,database,track_base,config] = frame_processing(Frames)
%Обработка frames
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %times
    time_log = Frames(500).time-Frames(1).time;
    time_frame = Frames(2).time-Frames(1).time;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    V_plane = 300; % обычная скорость самолета м/с
    config  = config_build();
    list_frames = Iden4posts(Frames);
    
%%%========================================================================    
%%%Когда Саня доделает frame_analysys()
%     cur_frame = Frames(list_frames(1));
%     res = frame_analysys(cur_frame, config);
%     
%     analys.data  = res.data ;
%     analys.matches_count2  = res.matches_count2 ;
%     analys.matches_count3  = res.matches_count3 ;
%     analys.matches_count4  = res.matches_count4 ;
%     analys.PD  = res.PD ;
%%%    
%%%========================================================================
    % поиск фрейма с максимальнымм число отождествлений
    max_length_matches = 0;
    for i=1:length(list_frames)
        num = list_frames(i);
        temp_frame = Frames(num);
        length_matches = size(temp_frame.matches,2);
        if length_matches>max_length_matches
            max_length_matches = length_matches;
            max_num = num; % номер фрейма с максимальным число отождествлений
        end
    end

    cur_frame = Frames(list_frames(5));
   
%%%========================================================================    
%%%здесь по сути функция build_matches() реализуется, но для одного кадра
    
    poits = [];
    k = 0; % номер отметки в структруре poits

%   out = frame_analysys(cur_frame, config);
    out.data = cur_frame.matches;
    for j = 1:size(out.data,2)
        k = k + 1;
        poits(k).imps = zeros(4,5); % размерность соответсвует 4 импульсам на посты с 5 параметрами
        poits(k).count = 0; % число отождествлений в одной отметке
        poits(k).frame = 1; % номер фрейма
        
        if out.data(1,j) %если есть такое отождествление
            poits(k).imps(1,1) = cur_frame.Post1(out.data(1,j)).uT; %относительное время прихода 
            poits(k).imps(1,2) = cur_frame.Post1(out.data(1,j)).T; %абсолютное время прихода
            poits(k).imps(1,3) = cur_frame.Post1(out.data(1,j)).freq; %несущая частота
            poits(k).imps(1,4) = cur_frame.Post1(out.data(1,j)).dur; %длительность импульса
            poits(k).imps(1,5) = cur_frame.Post1(out.data(1,j)).period; %период
            poits(k).freq = cur_frame.Post1(out.data(1,j)).freq;
            poits(k).count = poits(k).count + 1;
            poits(k).d4c1 = cur_frame.Post1(out.data(1,j)).d4c1;
        end
        if out.data(2,j)
            poits(k).imps(2,1) = cur_frame.Post2(out.data(2,j)).uT;
            poits(k).imps(2,2) = cur_frame.Post2(out.data(2,j)).T;
            poits(k).imps(2,3) = cur_frame.Post2(out.data(2,j)).freq;
            poits(k).imps(2,4) = cur_frame.Post2(out.data(2,j)).dur;
            poits(k).imps(2,5) = cur_frame.Post2(out.data(2,j)).period;
            poits(k).freq = cur_frame.Post2(out.data(2,j)).freq;
            poits(k).count = poits(k).count + 1;
            poits(k).d4c1 = cur_frame.Post2(out.data(2,j)).d4c1;
        end
        if out.data(3,j)
            poits(k).imps(3,1) = cur_frame.Post3(out.data(3,j)).uT;
            poits(k).imps(3,2) = cur_frame.Post3(out.data(3,j)).T;
            poits(k).imps(3,3) = cur_frame.Post3(out.data(3,j)).freq;
            poits(k).imps(3,4) = cur_frame.Post3(out.data(3,j)).dur;
            poits(k).imps(3,5) = cur_frame.Post3(out.data(3,j)).period;
            poits(k).freq = cur_frame.Post3(out.data(3,j)).freq;
            poits(k).count = poits(k).count + 1;
            poits(k).d4c1 = cur_frame.Post3(out.data(3,j)).d4c1;
        end
        if out.data(4,j)
            poits(k).imps(4,1) = cur_frame.Post4(out.data(4,j)).uT;
            poits(k).imps(4,2) = cur_frame.Post4(out.data(4,j)).T;
            poits(k).imps(4,3) = cur_frame.Post4(out.data(4,j)).freq;
            poits(k).imps(4,4) = cur_frame.Post4(out.data(4,j)).dur;
            poits(k).imps(4,5) = cur_frame.Post4(out.data(4,j)).period;
            poits(k).freq = cur_frame.Post4(out.data(4,j)).freq;
            poits(k).count = poits(k).count + 1;
            poits(k).d4c1 = cur_frame.Post4(out.data(4,j)).d4c1;
        end
        poits(k).PD(1,1)= poits(k).imps(1,2)*config.c; %времена приходов абсолютные в м
        poits(k).PD(2,1)= poits(k).imps(2,2)*config.c;
        poits(k).PD(3,1)= poits(k).imps(3,2)*config.c;
        poits(k).PD(4,1)= poits(k).imps(4,2)*config.c;
    end
    
    matches = out;
%%%========================================================================       
    


%%%========================================================================
%%%Блок расчета координат по всем подряд отметкам (для 4х и 3х постов) и
%%%визуализация
    h_LA = config.hei;
    XpT = config.PostsENU;
    zzz=0;
    for zz=1:length(poits)
        PD(:,zz) = poits(zz).PD;
        
        l=0;
        for z=1:4
            if matches.data(z,zz)==0
                l=l+1;
            end
        end
        if l==0
            zzz = zzz+1;
            X0= [0;
                0;
                1000;]; %время излучения 
            X(:,zzz) = coord_solver2D(PD(:,zz), XpT, X0, h_LA); 
        elseif l==1
            zzz = zzz+1;
            [X1,X2] = solver3(XpT(:,find(PD(:,zz))), PD(find(PD(:,zz)),zz), h_LA);
            %исключение второго решения
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
            if norm(X1-X2)<=sqrt(2)
                X(:,zzz) = X1;
            elseif norm(X1-X2)>=(10*sqrt(2)*time_frame*V_plane)
                if norm(X1)>norm(X2)
                    X(:,zzz) = X1;
                else
                    X(:,zzz) = X2;
                end
            else
                kosyak=kosyak+1;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        
    end
    

    
    figure(1)
    plot(X(1,:),X(2,:),'r x')
    hold on
    plot(XpT(1,:),XpT(2,:),'b o')    
%     daspect([3 3 3])
    hold off
    grid on
%%%========================================================================    

    %Следующие функции работают пока только c Modes
    [database] = poi_test(poits); %database времен прихода для формирования траекторий (времена приходов в (c) выстроены в последовательности для выделенных целей)
    
    [track_base,kosyak] = solver4_track(database, config,time_frame,V_plane); %создание track_base (траектории целей в координатах) (учитываются точки с двумя решениями)
    
        
    figure(2)
    plot(track_base(1).track(1,:),track_base(1).track(2,:),'r x')
    hold on
    plot(track_base(2).track(1,:),track_base(2).track(2,:),'k x')
    hold on
    plot(config.PostsENU(1,:),config.PostsENU(2,:),'b o') 
    hold off
    grid on



end

