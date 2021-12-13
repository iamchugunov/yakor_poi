% nums = find(out2(4).poits(8,:) ~= 0);
% p = out2(4).poits(:,nums);
% 
% X = [];
% p = p(:,n1:n2);
for i = 1:length(p)
    
    toa = p(2:5,i);
    nums = find(toa);
    [X(:,i), dop, nev(i), flag] = coord_solver2D(toa(nums)*config.c_ns, config.posts(:,nums), [p(8,i);p(9,i);0], p(10,i));
    TOA(:,i) = [norm([X(1:2,i); p(10,i)] - config.posts(:,1));
        norm([X(1:2,i); p(10,i)] - config.posts(:,2));
        norm([X(1:2,i); p(10,i)] - config.posts(:,3));
        norm([X(1:2,i); p(10,i)] - config.posts(:,4))] / config.c_ns;
    plot(p(8,i),p(9,i),'gv')
    i
end



% t_start = p(1,1);
% n1 = 1;
% n2 = 1;
% k = 0;
% X=[];
% for i = 1:length(p)
%     if p(1,i) - t_start > 10
%         n2 = i-1;
%         plot(p(8,n1:n2),p(9,n1:n2),'.-')
%         k = k + 1;
%         X(:,k) = [t_start;
%             mean(p(8,n1:n2));
%             mean(p(9,n1:n2))];
%         n1 = i;
%         t_start = p(1,i);
%         
%         
%     end
% end