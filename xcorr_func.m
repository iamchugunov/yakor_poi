function [S,lags] = xcorr_func(x,y)

size_x = length(x);
size_y = length(y);
new_size = size_x + size_y - 1; 

y = y(end:-1:1);
x = [x zeros(1,new_size - size_x)];
y = [y zeros(1,new_size - size_y)];

S = zeros(1,new_size);

for k = 1:new_size
    %for m = max(1,length(x)+1-length(y)):1:min(length(x),length(y))
    for m = 1:length(y)   
        %if k < (m + length(x))
        if k >= m
               % S(k) = S(k) + x(k + 1 - m)*y(m);
               S(k) = S(k) + x(k + 1 - m)*y(m);
        end
    end
end

lags = [1:new_size] - (max(size_x, size_y));

end