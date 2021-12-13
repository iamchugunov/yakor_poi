function [Xi] = make_rd_interp(poits, config)

    [rd] = get_rd_from_poits1(poits);
    
    dn = 100;
    q = 0.1;
    
    [rdf1] = process_rd(rd([1 2],:), dn, q);
    [rdf2] = process_rd(rd([1 3],:), dn, q);
    [rdf3] = process_rd(rd([1 4],:), dn, q);
    [rdf4] = process_rd(rd([1 5],:), dn, q);
    [rdf5] = process_rd(rd([1 6],:), dn, q);
    [rdf6] = process_rd(rd([1 7],:), dn, q);
    
    plot(rdf1(1,:),rdf1(2,:),'.-k')
    plot(rdf2(1,:),rdf2(2,:),'.-k')
    plot(rdf3(1,:),rdf3(2,:),'.-k')
    plot(rdf4(1,:),rdf4(2,:),'.-k')
    plot(rdf5(1,:),rdf5(2,:),'.-k')
    plot(rdf6(1,:),rdf6(2,:),'.-k')
    
    t = unique(rd(1,:));
    
    rdi1 = interp1(rdf1(1,:),rdf1(2,:),t);
    rdi2 = interp1(rdf2(1,:),rdf2(2,:),t);
    rdi3 = interp1(rdf3(1,:),rdf3(2,:),t);
    rdi4 = interp1(rdf4(1,:),rdf4(2,:),t);
    rdi5 = interp1(rdf5(1,:),rdf5(2,:),t);
    rdi6 = interp1(rdf6(1,:),rdf6(2,:),t);
    
    y = [rdi1;rdi2;rdi3;rdi4;rdi5;rdi6] * config.c/1e9;
    
    for i = 1:length(y)
        [Xi(:,i), dop] = NavSolverRDizb(y(1:3,i), config.posts, [0;0], 5000);
    end
end

