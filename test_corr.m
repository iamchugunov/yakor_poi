close all
clearvars -except Frames config mod_frames

Time_Ranges = zeros(size(config.posts,2));
for p = 1:size(config.posts,2)
   for q = 1:size(config.posts,2)
       if q > p
           Time_Ranges(p,q) = ceil(sqrt((config.posts(1,p) - config.posts(1,q))^2 + (config.posts(2,p) - config.posts(2,q))^2 + (config.posts(3,p) - config.posts(3,q))^2)/config.c*1e9);
       end
   end
end

[a1, a2, a3, a4] = make_corr_massives(Frames(3488), config);
A = [a1; a2; a3; a4];
[r,lags]= xcorr(A(1,:),A(2,:),Time_Ranges(1,2));

figure
stem(lags,r)

x = A(1,:);
y = A(2,:);

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

lags2 = [1:new_size] - (max(size_x, size_y));

figure
stem(lags2,S)


