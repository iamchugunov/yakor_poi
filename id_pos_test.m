clearvars -except Frames

addpath('оценка траекторий')
time_log = Frames(500).time-Frames(1).time;
time_frame = Frames(2).time-Frames(1).time;
config  = config_build();

fn = fieldnames(Frames);
fn([1,end],:) = [];
for m = 1 : numel(fn)
    curr_field = getfield(Frames(1),fn{m});
    if ~isempty(curr_field)
       fn_params = fieldnames(curr_field);
    end
end

NoF = 2500;
%X0 = [1e4;1e4;1.726359373727974e+22];
%X0 = [0;0;1.72635942879799e+22];
X0 = [0;0;0];
%h = [0; 5e3; 11e3];
h = [0:1e3:14e3]';
aznv_freq = 1090000;
% X_true = [10700; 16200; 50000*config.c*1e9];
% h_true = 1000;
% for m = 1:4
%    d_true(m,1) = sqrt((X_true(1)-config.posts(1,m))^2 + (X_true(2)-config.posts(2,m))^2 + (h_true-config.posts(3,m))^2);
%    y_meas_true(m,1) = d_true(m,1) + X_true(3);
% end
solv_pos = [];

solved_set = [];
fours_found = 0;
fours_solved = 0;
flag = 0;
freq_set = [];
for k = 1 : length(Frames(1:NoF))
    if ~isempty(Frames(k).Post1) && ~isempty(Frames(k).Post2) && ~isempty(Frames(k).Post3) && ~isempty(Frames(k).Post4)  
        [res] = frame_analysys(Frames(k), config);
        for q = 1:size(res.data,2)                
            y_ind = find(res.data(:,q));
            if length(y_ind) > 3
                fours_found = fours_found + 1;
                y_meas = [];
                posts = [];
                freq_meas = [];
                flag = 0;
               for w = 1:length(y_ind) 
                   y_meas(w,1) = getfield(Frames,{k},fn{y_ind(w)},{res.data(y_ind(w),q)},fn_params{2});
                   posts(:,w) = config.posts(:,y_ind(w));
                   imp_freq = getfield(Frames,{k},fn{y_ind(w)},{res.data(y_ind(w),q)},fn_params{4});
                   freq_meas(w,1) = imp_freq;
                   if imp_freq == aznv_freq
                       flag = 1;
                   end
               end  
               if flag ~= 1
                 [X, flag_sol] = coord_solver_2D_h(y_meas*config.c, posts, X0, h);
                 if flag_sol == 1
                    %X0 = [X(1);X(2);X(4)];
                    solv_pos = [solv_pos [X(1);X(2);X(3)]];
                    freq_set = [freq_set freq_meas];
                    fours_solved = fours_solved + 1;
                    disp('Solution is found!')
                 end
               end               
            end    
        end
    end
    disp(k/NoF*100)
end

for k = 1:size(solv_pos,2)
   norm_set(k) = sqrt(solv_pos(1,k)^2 + solv_pos(2,k)^2);    
end

figure
plot3(config.posts(1,:),config.posts(2,:),config.posts(3,:),'^r')
hold on
plot3(solv_pos(1,:),solv_pos(2,:),solv_pos(3,:),'ob')
grid on

figure
plot(freq_set(1,:),'r')
hold on
plot(freq_set(2,:),'g')
plot(freq_set(3,:),'b')
plot(freq_set(4,:),'k')
grid on

figure
plot(diff(norm_set))
grid on

%cord(:,k) = coord_solver_2D_h(y(nums',i)*config.c*1e9, config.posts(:,nums'), [0;0;0], 0:1000:14000);

% fn = fieldnames(Frames);
% for k=1:numel(fn)
% %     if( isnumeric(mystruct.(fn{k})) )
% %         % do stuff
% %     end
% xyz = getfield(Frames(300),fn{k});
% end

% figure(1)
% hold on
% for i=1:length(Frames(1:100))
% %   stem(Frames(i).time,10e6,'.y')
%     if ~isempty(Frames(i).Post1) && ~isempty(Frames(i).Post2) && ~isempty(Frames(i).Post3) &&  ~isempty(Frames(i).Post4)  
%             %i
%        stem(Frames(i).time,10e6,'.y')
%        stem(Frames(i+1).time,10e6,'.y')
%        stem([Frames(i).Post1.T],[Frames(i).Post1.freq],'.b')
%        stem([Frames(i).Post2.T],[Frames(i).Post2.freq],'.r')
%        stem([Frames(i).Post3.T],[Frames(i).Post3.freq],'.g')
%        stem([Frames(i).Post4.T],[Frames(i).Post4.freq],'.k')
%     end
% end
% grid on