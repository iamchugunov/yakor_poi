function [dop] = dop_R_phi(posts, coords)
    
    h = coords(3,1);
    X(1,1) = norm(coords(1:3,1));
    X(2,1) = atan2(coords(2,1), coords(1,1));
    X(3,1) = coords(4,1);
    
    
    for i = 1:length(posts)
        d = sqrt((X(1,1) * cos(X(2,1)) - posts(1,i))^2 + (X(1,1)*sin(X(2,1)) - posts(2,i))^2 + (h - posts(3,i))^2);
        H(i, 1) = ( (X(1,1) * cos(X(2,1)) - posts(1,i)) * cos(X(2,1)) + (X(1,1) * sin(X(2,1)) - posts(2,i)) * sin(X(2,1)) )/d;
        H(i, 2) = ( -(X(1,1) * cos(X(2,1)) - posts(1,i)) * X(1,1) * sin(X(2,1)) + (X(1,1) * sin(X(2,1)) - posts(2,i)) * X(1,1) * cos(X(2,1)) )/d;
        H(i, 3) = 1;
    end
    
    invHH = inv(H'*H);
    DOPr = sqrt(abs(invHH(1,1)));
    DOPphi = sqrt(abs(invHH(2,2)));
    DOPt = sqrt(abs(invHH(3,3)));
    
    dop = [DOPr, DOPphi, DOPt];

end

