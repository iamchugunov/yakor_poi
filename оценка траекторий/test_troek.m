poits = out1(4).poits;
k = 0;
for i = 1:length(poits)
    i
    toa = poits(2:5,i);
    nums = find(toa > 0);
    if length(nums) == 3
        k = k + 1;
        [X0] = X_function2D_v0(toa(nums)*config.c/1e9,config.posts(:,nums),3);
        [X1, flag1, dop, nev1] = coord_solver_2D_h_triple(toa(nums)*config.c/1e9, config.posts(:,nums), [X0(2:3,1);toa(nums(1))*config.c/1e9], -15e3:1000:15e3, config);
        [X2, flag2, dop, nev2] = coord_solver_2D_h_triple(toa(nums)*config.c/1e9, config.posts(:,nums), [X0(2:3,2);toa(nums(1))*config.c/1e9], -15e3:1000:15e3, config);
        
        if flag1 && flag2
            if nev1 < nev2
                X3 = X1(1:3);
            elseif nev2 < nev1
                X3 = X2(1:3);
            else
               if norm(X1(1:2)) < norm(X2(1:2))
                   X3 = X1(1:3);
               else
                    X3 = X2(1:3);
               end
            end
        elseif flag1
            X3 = X1(1:3);
        elseif flag2
            X3 = X2(1:3);
        else
            X3 = [0;0;0];
        end
        XX1(:,k) = [poits(1,i);X3];    
    end
end