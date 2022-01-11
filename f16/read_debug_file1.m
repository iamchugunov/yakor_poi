function [poits] = read_debug_file1(filename)

if nargin == 0
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
end

f = fopen(filename);
warning off
    k = 0;
%     
    fgetl(f);
%     
while feof(f)==0 
    s = fgetl(f);
    S = split(s);
    k = k + 1;
    poits(:,k) = [
        str2num(S{2,1});
        str2num(S{5,1});
        str2num(S{6,1})];
    
    
end

fclose(f);


% db = [];
% for i = 1:length(poits)
%     match_flag = 0;
%     for j = 1:length(db)
%         if poits(2,i) == db(j).trnum
%            db(j).k = db(j).k + 1;
%            db(j).poits(:,db(j).k) = poits([1 3 4 5 6 7],i);
%            match_flag = 1; 
%            break;
%         end
%     end
%     
%     if match_flag == 0
%         new_traj = [];
%         new_traj.trnum = poits(2,i);
%         new_traj.k = 1;
%         new_traj.poits(:,1) = poits([1 3 4 5 6 7],i);
%         N = length(db);
%         if N == 0
%             db = new_traj;
%         else
%             db(N+1) = new_traj;
%         end
%     end
% end

end


