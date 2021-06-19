clear all
close all
clc

%x = randn(1,10);
%y = randn(1,15);
% x = [0 1 1 1 0 0 1 0 1 0 0 1 0 1 1 0 1 1 1 0];
% y = [0 1 0 1 0 1 1 0 1 0 1 1 0 0 1 0 1 0 1 1];
% x = [0 0 0 0 0  1  1   1   1  1  1   1   1   1  1 0 0 0 0 0];
% y = [0 0 0 0 0  0 0.2 0.6 0.8 1 0.8 0.6 0.4 0.2 0 0 0 0 0 0];

% x = [0 0 0 0 0 0 0  1  1   1   1  1  1   1   1   1  1 0 0 0 0 0];
% y = [0 0 0 0 0  0 0.2 0.6 0.8 1 0.8 0.6 0.4 0.2 0 0 0 0 0 0 0];

%y = [0 0 0 0 0  1  1   1   1  1  1   1   1   1  1 0 0 0 0 0];

% x = [0 0 0 0 0  1  1   1   0  0  1   1   1   1  1 0 0 0 0 0];
% y = [0 0 0 0  1  1   1   0  1  0   1   1  1 0 0 0 0 0 0];

% y = [0 0 0 0  1  1   0  0  1  1   1   1  1 0 0 0 1 0 0 1];
% x = [0 0 0 0  0  1   1  0  1  0   1   1  1 0 0 0];

x = randi([0 1], 1, 100);
y = randi([0 1], 1, 100);

maxlag = 10;

x_tr = x;
y_tr = y;
%%%%%%%%%%%%%
% % % % if length(x) ~= length(y)
% % % %     if length(x) > length(y)
% % % %         dif_size = length(x) - length(y);
% % % %         y = [y zeros(1,dif_size)];
% % % %     else
% % % %         dif_size = length(y) - length(x);
% % % %         x = [x zeros(1,dif_size)];
% % % %     end
% % % % end

% size_x = length(x);
% size_y = length(y);
% new_size = size_x + size_y;
% 
% x = [x zeros(1,new_size - size_x)];
% y = [y zeros(1,new_size - size_y)];
% 
% X = fft(x);
% Y = fft(y);
% S = ifft(X.*Y);

%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%

size_x = length(x);
size_y = length(y);
%new_size = size_x + size_y - 1; 
new_size = length(x) + maxlag; 

[c,lags2] = xcorr(x_tr,y_tr,maxlag);

y = y(end:-1:1);
% x = [x zeros(1,new_size - size_x)];
% y = [y zeros(1,new_size - size_y)];
% x = [x(1:maxlag) zeros(1,maxlag)];
% y = [y(1:maxlag) zeros(1,maxlag)];

x = [x zeros(1,maxlag)];
y = [y zeros(1,maxlag)];

% mid_ind = fix(length(x)/2);
% x = [x(mid_ind - maxlag:mid_ind - maxlag) zeros(1,maxlag)];
% y = [y(1:maxlag) zeros(1,maxlag)];

%t = 1 : new_size;

%S = zeros(1,new_size);
S = zeros(1,2*maxlag);

for k = 1 : length(x)
    %for m = max(1,length(x)+1-length(y)):1:min(length(x),length(y))
    for m = 1:length(y)   
        %if k < (m + length(x))
        if k >= m
               % S(k) = S(k) + x(k + 1 - m)*y(m);
               S(k) = S(k) + x(k + 1 - m)*y(m);
        end
    end
end

% for k = 1:new_size
%     %for m = max(1,length(x)+1-length(y)):1:min(length(x),length(y))
%     for m = 1:length(y)   
%         %if k < (m + length(x))
%         if k >= m
%                 S(k) = S(k) + x(m)*y(new_size - k + m);
%         end
%     end
% end

%lags = [1:new_size] - (max(size_x, size_y));

lags = [1:2*maxlag] - maxlag;

% X = fft(x);
% Y = fft(y);
% S_fft = ifft(X.*Y);

%%%%%%%%%%%%%%%%%%%%

figure
plot(x,'r.')
%stem(x)
hold on
plot(y + 2,'b.')
%stem(y)
plot(lags,S)
%plot(lags,S_fft)
grid on

figure
plot(lags,S)
%plot(S)
hold on
plot(lags2,c)
%plot(c)
grid on



