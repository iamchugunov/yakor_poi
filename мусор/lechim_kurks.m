modes = out(2).modes;
k = 0;
trajm1 = [];
trajm1(:,1) = modes(:,1);
k = 1;
for i = 2:length(modes)
    matchflag = 0;
    for j = k:-1:1
        norma = norm(trajm1(8:9,j) - modes(8:9,i));
        if norma < 50
            matchflag = 1;
            break
        end
    end
    if ~matchflag
        k = k + 1;
        trajm1(:,k) = modes(:,i);
    end
end
V = [];
for i = 2:size(trajm1,2)
V(i) = norm(trajm1(10,i) - trajm1(10,i-1))/(trajm1(1,i) - trajm1(1,i-1));
end

% figure
% plot(modes(1,:),modes(8,:),'.-')
% hold on
% plot(trajm1(1,:),trajm1(8,:),'.-')
% 
% figure
% plot(trajm1(1,:) - trajm1(1,1),trajm1(7,:)-V)
% 
% figure
% plot(trajm1(8,:),trajm1(9,:),'.-')
% 
% figure
% plot(diff(trajm1(1,:)))