function [X1,X2,dop1,dop2] = solver3(XpT, PD, h_LA)
    addpath("оценка траекторий")
    [X0] = X_function2D_v0(PD,XpT,3);
%     [ x1(1),x1(2)] = Navigate3or4( XpT, PD, h_LA, X0(2,1),X0(3,1) );
%     [ x2(1),x2(2)] = Navigate3or4( XpT, PD, h_LA, X0(2,2),X0(3,2) );

      [X1, dop1] = coord_solver2D(PD, XpT, [X0(2:3,1)' PD(1,1)]', h_LA);
      [X2, dop2] = coord_solver2D(PD, XpT, [X0(2:3,2)' PD(1,1)]', h_LA);
      
end

