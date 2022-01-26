function [poits] = readvertfile(filename)

if nargin == 0
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
end

poits = struct('Frame',[],'coords',[],'ToA',[]);
f = fopen(filename);
warning off
k = 0;

while feof(f)==0 
    s = fgetl(f);
    S = split(s);
    
    poit.Frame = str2num(S{5,1});
    poit.coords = [str2num(S{6,1});str2num(S{7,1});str2num(S{8,1});];
    poit.ToA = [str2num(S{9,1});str2num(S{10,1});str2num(S{11,1});str2num(S{12,1});];
    k = k+1;
    poits(k) = poit;
    
    
    
    
    
end

fclose(f);

end






