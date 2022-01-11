function [poits] = readpoitsfileegypt(filename)

if nargin == 0
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
end

f = fopen(filename);
warning off
  k = 0;
while feof(f)==0 
    s = fgetl(f);
    S = split(s);
    poit.Frame = str2num(S{6,1});
    poit.type = str2num(S{7,1});
    poit.kursk_trnum = str2num(S{8,1});
    poit.Smode = str2num(S{9,1});
    poit.x_m = str2num(S{10,1});
    poit.y_m = str2num(S{11,1});
    poit.h_m = str2num(S{12,1});
    poit.velo = str2num(S{13,1});
    poit.freq = str2num(S{14,1});
    poit.squawk = str2num(S{15,1});
    poit.toa = [str2num(S{16,1}); str2num(S{17,1}); str2num(S{18,1}); str2num(S{19,1});];
    poit.call = (S{20,1});
    k = k + 1;
    poits(k) = poit;
end

fclose(f);

end






