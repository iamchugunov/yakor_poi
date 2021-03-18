function [x1, x2] = solver3(XpT, PD, h_LA)

    [X] = X_function2D_v0(PD,XpT,3);
    [ x1(1),x1(2)] = Navigate3or4( XpT, PD, h_LA, X(2,1),X(3,1) );
    [ x2(1),x2(2)] = Navigate3or4( XpT, PD, h_LA, X(2,2),X(3,2) );
end

