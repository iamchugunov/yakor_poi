function [trace] = read_trace_file(filename)

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
    trace(:,k) = [str2num(S{1,1});str2num(S{2,1});str2num(S{3,1});str2num(S{4,1});str2num(S{5,1});str2num(S{6,1});];
    
    
end

end


