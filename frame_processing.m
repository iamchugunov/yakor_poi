function [matches,poits] = frame_processing(Frames)
%Обработка frames
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
    max_length_matches = 0;
    for i=1:length(list_frames)
        num = list_frames(i);
        temp_frame = Frames(num);
        length_matches = size(temp_frame.matches,2);
        if length_matches>max_length_matches
            max_length_matches = length_matches;
            max_num = num;
        end
    end

    cur_frame = Frames(list_frames(7));
    
    
    poits = [];
    k = 0;

%   out = frame_analysys(cur_frame, config);
    out.data = cur_frame.matches;
    for j = 1:size(out.data,2)
        k = k + 1;
        poits(k).imps = zeros(4,5);
        poits(k).count = 0;
        poits(k).frame = 1;
        
        if out.data(1,j)
            poits(k).imps(1,1) = cur_frame.Post1(out.data(1,j)).uT;
            poits(k).imps(1,2) = cur_frame.Post1(out.data(1,j)).T;
            poits(k).imps(1,3) = cur_frame.Post1(out.data(1,j)).freq;
            poits(k).imps(1,4) = cur_frame.Post1(out.data(1,j)).dur;
            poits(k).imps(1,5) = cur_frame.Post1(out.data(1,j)).period;
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
        poits(k).PD(1,1)= poits(k).imps(1,2)*config.c;
        poits(k).PD(2,1)= poits(k).imps(2,2)*config.c;
        poits(k).PD(3,1)= poits(k).imps(3,2)*config.c;
        poits(k).PD(4,1)= poits(k).imps(4,2)*config.c;
    end
    
    matches = out;
    
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
            x0= 0;
            y0 = 0;
            [xla(1,zzz),yla(1,zzz),Hla,dT, DOP, NEV, err, flag] = Navigate3or4( XpT, PD(:,zz), h_LA, x0, y0 );
        end
    end
    
    
    
    figure(1)
    plot(xla(1,:),yla(1,:),'r x')
    hold on
    plot(XpT(1,:),XpT(2,:),'b o') 
%     daspect([3 3 3])
    hold off
    grid on
end

