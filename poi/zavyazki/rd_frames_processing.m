function [ARdb, ZRdb] = rd_frames_processing(rd_frames, Frames)
    
    % approved rd database
    rd.count = 0;
    rd.rd = [];
    rd.time = 0;
    ARdb = struct('RD21', [], 'RD31', [], 'RD41', [],'RD32', [], 'RD42', [], 'RD43', []);
    
    % zav rd database
    ZRdb = struct('RD21', [], 'RD31', [], 'RD41', [],'RD32', [], 'RD42', [], 'RD43', []);
    
    % 
    timeout = 30;
    
    t0 = rd_frames(1).time;
    
    for i = 1:length(rd_frames)
        current_time = rd_frames(i).time;
%         [flag21, ARdb.RD21] = is_match_to_ARdb(ARdb.RD21, rd_frames(i).RD21, current_time, Frames(rd_frames(i).frame),'21');
%         [flag31, ARdb.RD31] = is_match_to_ARdb(ARdb.RD31, rd_frames(i).RD31, current_time, Frames(rd_frames(i).frame),'31');
        [flag41, ARdb.RD41] = is_match_to_ARdb(ARdb.RD41, rd_frames(i).RD41, current_time, Frames(rd_frames(i).frame),'41');
%         [flag32, ARdb.RD32] = is_match_to_ARdb(ARdb.RD32, rd_frames(i).RD32, current_time, Frames(rd_frames(i).frame),'32');
%         [flag42, ARdb.RD42] = is_match_to_ARdb(ARdb.RD42, rd_frames(i).RD42, current_time, Frames(rd_frames(i).frame),'42');
%         [flag43, ARdb.RD43] = is_match_to_ARdb(ARdb.RD43, rd_frames(i).RD43, current_time, Frames(rd_frames(i).frame),'43');
        
%         if ~flag21
%             [ZRdb.RD21] = add_rd_to_ZRdb(ZRdb.RD21, rd_frames(i).RD21, current_time, Frames(rd_frames(i).frame),'21');
%         end
%         if ~flag31
%             [ZRdb.RD31] = add_rd_to_ZRdb(ZRdb.RD31, rd_frames(i).RD31, current_time, Frames(rd_frames(i).frame),'31');
%         end
        if ~flag41
            [ZRdb.RD41] = add_rd_to_ZRdb(ZRdb.RD41, rd_frames(i).RD41, current_time, Frames(rd_frames(i).frame),'41');
        end
%         if ~flag32
%             [ZRdb.RD32] = add_rd_to_ZRdb(ZRdb.RD32, rd_frames(i).RD32, current_time, Frames(rd_frames(i).frame),'32');
%         end
%         if ~flag42
%             [ZRdb.RD42] = add_rd_to_ZRdb(ZRdb.RD42, rd_frames(i).RD42, current_time, Frames(rd_frames(i).frame),'42');
%         end
%         if ~flag43
%             [ZRdb.RD43] = add_rd_to_ZRdb(ZRdb.RD43, rd_frames(i).RD43, current_time, Frames(rd_frames(i).frame),'43');
%         end
        
        if current_time - t0 > timeout
            t0 = current_time;
%             
%             [ZRdb.RD21] = clear_old_zav(ZRdb.RD21, current_time, timeout);
%             [ZRdb.RD31] = clear_old_zav(ZRdb.RD31, current_time, timeout);
            [ZRdb.RD41] = clear_old_zav(ZRdb.RD41, current_time, timeout);
%             [ZRdb.RD32] = clear_old_zav(ZRdb.RD32, current_time, timeout);
%             [ZRdb.RD42] = clear_old_zav(ZRdb.RD42, current_time, timeout);
%             [ZRdb.RD43] = clear_old_zav(ZRdb.RD43, current_time, timeout);
            
%             [ZRdb.RD21, ARdb.RD21] = ZR_to_AR(ZRdb.RD21, ARdb.RD21, current_time);
%             [ZRdb.RD31, ARdb.RD31] = ZR_to_AR(ZRdb.RD31, ARdb.RD31, current_time);
            [ZRdb.RD41, ARdb.RD41] = ZR_to_AR(ZRdb.RD41, ARdb.RD41, current_time);
%             [ZRdb.RD32, ARdb.RD32] = ZR_to_AR(ZRdb.RD32, ARdb.RD32, current_time);
%             [ZRdb.RD42, ARdb.RD42] = ZR_to_AR(ZRdb.RD42, ARdb.RD42, current_time);
%             [ZRdb.RD43, ARdb.RD43] = ZR_to_AR(ZRdb.RD43, ARdb.RD43, current_time);
        end
    end
    
end

