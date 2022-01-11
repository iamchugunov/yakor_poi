function [X, flag, dop, nev, hei_geo] = coord_solver_2D_h3(y, posts,h, config)   
    
    nums = find(y > 0);
    y = y(nums);
    posts = posts(:,nums);
        [X0] = X_function2D_v0(y*config.c/1e9,posts,3);
        if (imag(X0(1,1)) ~= 0)
            X = 0;
            flag = 0;
            dop = 0;
            nev = 0;
            hei_geo = 0;
            return;
        end
%         [X1, flag1, dop1, nev1, hei_geo1] = coord_solver_2D_h(y*config.c/1e9, posts, [X0(2:3,1);y(1)*config.c/1e9], h, config);
%         [X2, flag2, dop2, nev2, hei_geo2] = coord_solver_2D_h(y*config.c/1e9, posts, [X0(2:3,2);y(1)*config.c/1e9], h, config);
%         
        [X1, flag1, dop1, nev1, hei_geo1] = coord_solver_2D_h(y*config.c/1e9, posts, [X0(2:3,1);-X0(1,1)], h, config);
        [X2, flag2, dop2, nev2, hei_geo2] = coord_solver_2D_h(y*config.c/1e9, posts, [X0(2:3,2);-X0(1,2)], h, config);
        
        if flag1 && flag2
            nev1 = nev2;
            if nev1 < nev2
                X = X1;
                flag = flag1;
                dop = dop1;
                nev = nev1;
                hei_geo = hei_geo1;
            elseif nev2 < nev1
                X = X2;
                flag = flag2;
                dop = dop2;
                nev = nev2;
                hei_geo = hei_geo2;
            else
               if norm(X1(1:2)) > norm(X2(1:2))
                   X = X1;
                   flag = flag1;
                   dop = dop1;
                   nev = nev1;
                   hei_geo = hei_geo1;
               else
                   X = X2;
                   flag = flag2;
                   dop = dop2;
                   nev = nev2;
                   hei_geo = hei_geo2;
               end
            end
        elseif flag1
            X = X1;
            flag = flag1;
            dop = dop1;
            nev = nev1;
            hei_geo = hei_geo1;
        elseif flag2
            X = X2;
            flag = flag2;
            dop = dop2;
            nev = nev2;
            hei_geo = hei_geo2;
        else
            X = 0;
            flag = 0;
            dop = 0;
            nev = 0;
            hei_geo = 0;
        end
end
  
