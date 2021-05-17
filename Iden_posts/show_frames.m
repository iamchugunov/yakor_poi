function [] = show_frames(Frames)
%просмотр frames на предмет межпостового отождествления
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %times
    time_log = Frames(500).time-Frames(1).time;
    time_frame = Frames(2).time-Frames(1).time;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    V_plane = 300; % обычная скорость самолета м/с
    config  = config_build();
    
    
%     %построить все импульсы
%     figure(1)
%     grid on
%     hold on
%     ylim([9e6 10e6])
%     for i=1:length(Frames(1:500))
%         if ~isempty(Frames(i).Post1)    
%             stem([Frames(i).Post1.T],[Frames(i).Post1.freq],'.b')
%         end
%         if ~isempty(Frames(i).Post2) 
%             stem([Frames(i).Post2.T],[Frames(i).Post2.freq],'.r')
%         end
%         if ~isempty(Frames(i).Post3) 
%             stem([Frames(i).Post3.T],[Frames(i).Post3.freq],'.g')
%         end
%         if ~isempty(Frames(i).Post4) 
%             stem([Frames(i).Post4.T],[Frames(i).Post4.freq],'.k')
%         end
%     end

    %построить когда пришли на все 4 поста (частота)
    figure(1)
    grid on
    hold on
%     ylim([9e6 10e6])
    for i=1:length(Frames(1:200))
%         stem(Frames(i).time,10e6,'.y')
        if ~isempty(Frames(i).Post1) && ~isempty(Frames(i).Post2) && ~isempty(Frames(i).Post3) &&  ~isempty(Frames(i).Post4)  
            i
            stem(Frames(i).time,10e6,'.y')
            stem(Frames(i+1).time,10e6,'.y')
            stem([Frames(i).Post1.T],[Frames(i).Post1.freq],'.b')
            stem([Frames(i).Post2.T],[Frames(i).Post2.freq],'.r')
            stem([Frames(i).Post3.T],[Frames(i).Post3.freq],'.g')
            stem([Frames(i).Post4.T],[Frames(i).Post4.freq],'.k')
        end
    end
    
    num_frame = find([Frames.time] == cursor_info.Position(1,1)) %номер кадра
    num_frame = 127;
    num_imp = find([Frames(num_frame).Post4.T] == cursor_info.Position(1,1)) %номер импульса в кадре
    
%     for i=1:4
%         per(i) = Frames(127).Post4(84+i).T -  Frames(127).Post2(12+i).T;
%     end
%     figure()
%     stem(per)
%     
%     for i=1:4
%         per(i) = Frames(127).Post4(69+i).freq -  Frames(127).Post2(0+i).freq;
%     end
%     figure()
%     stem(per)
    
    res = frame_analysys(Frames(127), config);
    
%     for i=1:4
%         for j=1:4
%             norm_E3(i,j) = norm_Euc(Frames(127).Post4(69+i),Frames(127).Post2(0+j),3)
%         end
%     end
    
% % % % %     kkk=0;
% % % % %     foursome_index_prev = 0;
% % % % %     foursome_prev = 0;
% % % % %     for i=1:size(res.data,2)
% % % % %         foursome_index = find(res.data(:,i)~=0);
% % % % %         foursome = res.data(foursome_index,i);
% % % % %         if size(foursome_index,1)==size(foursome_index_prev,1)  
% % % % %             if foursome_index==foursome_index_prev
% % % % %                 for j=1:size(foursome_index,1)
% % % % %                     if foursome(j,1) == foursome_prev(j,1)
% % % % %                         kkk=1;
% % % % %                         work_field2 = eval(['Frames(127).Post' num2str(j)]);
% % % % %                         vrem_foursomes(:,i) = res.data(:,i);
% % % % %                         
% % % % %                         break
% % % % %                     end
% % % % %                     
% % % % %                 end
% % % % %                 foursome_index_prev = foursome_index;
% % % % %                 foursome_prev = foursome;
% % % % %                 matches(:,i) = res.data(:,i);
% % % % %             else
% % % % %                 if kkk==0
% % % % %                     foursome_index_prev = foursome_index;
% % % % %                     foursome_prev = foursome;
% % % % %                     matches(:,i) = res.data(:,i);
% % % % %                 else
% % % % %                     kkk=0;
% % % % %                     idx = find(foursome_index~=j);
% % % % %                     work_field1 = eval(['Frames(127).Post' num2str(idx(1,1))]);
% % % % %                    
% % % % %                     for zz=1:size(vrem_foursomes,2)
% % % % %                         for zzz=1:size(vrem_foursomes,2)
% % % % %                             norm_E3(zz,zzz) = norm_Euc(work_field1(vrem_foursomes(idx(1,1),zzz)),work_field2(vrem_foursomes(j,zzz)),3);
% % % % %                         end
% % % % %                     end
% % % % %                     
% % % % %                     [M,Ii] = min(norm_E3);                     
% % % % %                     [M,Ij] = min(M);
% % % % %                     work_field_best = vrem_foursomes(:,Ij);
% % % % %                     matches(:,i) = work_field1_best;
% % % % %                     foursome_index_prev = foursome_index;
% % % % %                     foursome_prev = foursome;
% % % % %                     vrem_foursomes = 0;
% % % % %                 end
% % % % %                     
% % % % %             end
% % % % %         else
% % % % %             if kkk==0
% % % % %                 foursome_index_prev = foursome_index;
% % % % %                 foursome_prev = foursome;
% % % % %                 matches(:,i) = res.data(:,i);
% % % % %             else
% % % % %                 kkk=0;
% % % % %                 idx = find(foursome_index~=j);
% % % % %                 work_field1 = eval(['Frames(127).Post' num2str(idx(1,1))]);
% % % % %                 
% % % % %                 for zz=1:size(vrem_foursomes,2)
% % % % %                         for zzz=1:size(vrem_foursomes,2)
% % % % %                             norm_E3(zz,zzz) = norm_Euc(work_field1(vrem_foursomes(idx(1,1),zzz)),work_field2(vrem_foursomes(j,zzz)),3);
% % % % %                         end
% % % % %                 end
% % % % %                 
% % % % %                 [M,Ii] = min(norm_E3);                     
% % % % %                 [M,Ij] = min(M);
% % % % % 
% % % % %                 work_field_best = vrem_foursomes(:,Ij);
% % % % %                 matches(:,i) = work_field1_best;
% % % % %                 foursome_index_prev = foursome_index;
% % % % %                 foursome_prev = foursome;
% % % % %                 vrem_foursomes = 0;
% % % % %                 
% % % % %             end
% % % % %         end
% % % % %     end
            
                
                        
                       
                     
                    
                   
    
    
%     %построить когда пришли на все 4 поста (длительность)
%     figure(2)
%     grid on
%     hold on
% %     ylim([9e6 10e6])
%     for i=1:length(Frames(1:200))
% %         stem(Frames(i).time,10e6,'.y')
%         if ~isempty(Frames(i).Post1) && ~isempty(Frames(i).Post2) && ~isempty(Frames(i).Post3) &&  ~isempty(Frames(i).Post4)  
%             i
%             stem(Frames(i).time,1e5,'.y')
%             stem(Frames(i+1).time,1e5,'.y')
%             stem([Frames(i).Post1.T],[Frames(i).Post1.dur],'.b')
%             stem([Frames(i).Post2.T],[Frames(i).Post2.dur],'.r')
%             stem([Frames(i).Post3.T],[Frames(i).Post3.dur],'.g')
%             stem([Frames(i).Post4.T],[Frames(i).Post4.dur],'.k')
%         end
%     end
%     
%     %построить когда пришли на все 4 поста (период)
%     figure(3)
%     grid on
%     hold on
% %     ylim([9e6 10e6])
%     for i=1:length(Frames(1:200))
% %         stem(Frames(i).time,10e6,'.y')
%         if ~isempty(Frames(i).Post1) && ~isempty(Frames(i).Post2) && ~isempty(Frames(i).Post3) &&  ~isempty(Frames(i).Post4)  
%             i
%             stem(Frames(i).time,1e-2,'.y')
%             stem(Frames(i+1).time,1e-2,'.y')
%             stem([Frames(i).Post1.T],[Frames(i).Post1.period],'.b')
%             stem([Frames(i).Post2.T],[Frames(i).Post2.period],'.r')
%             stem([Frames(i).Post3.T],[Frames(i).Post3.period],'.g')
%             stem([Frames(i).Post4.T],[Frames(i).Post4.period],'.k')
%         end
%     end
    
    
    
%     figure(1)
%     stem(Frames(3).Post3.T,Frames(3).Post3.freq,'.g')
%     grid on
%     hold on
%     stem(Frames(3).Post4.T,Frames(3).Post4.freq,'.k')
%     stem(Frames(3).time,2e6,'.y')
%     stem(Frames(4).time,2e6,'.y')
%     r43 = config.ranges.r43/config.c;
%     plot([Frames(3).Post3.T Frames(3).Post3.T+r43], [1.5e6 1.5e6],'m')
    

    

end

