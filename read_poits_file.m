function [poits] = read_poits_file(filename)

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
    poit.Frame = str2num(S{1,1});
    poit.ToA = [str2num(S{2,1}); str2num(S{3,1}); str2num(S{4,1}); str2num(S{5,1})];
    poit.coords = zeros(4,1);
    poit.xy_valid = 0;
    poit.valid_to_traj = 0;
    poit.dop = 0;
    n = 0;
    for i = 1:4
       if poit.ToA(i) > 0
           n = n + 1;
       else
           poit.ToA(i) = 0;
       end
    end
    poit.count = n;
    poit.freq = str2num(S{7,1});
    poit.Smode = str2num(S{6,1});
    poits(k) = poit;
end

end

