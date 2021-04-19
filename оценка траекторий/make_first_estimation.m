function [X, hei, flag] = make_first_estimation(y, config, X0)
    
    if nargin == 2
        X0 = [];
    end
    k = 0;
    for i = 1:length(y)
        nums = find(y(:,i)>0);
        if length(nums) > 2
            if length(nums) == 4
                [cord_1, flag] = coord_solver_2D_h(y(nums',i)*config.c, config.posts(:,nums'), [0;0;0], 0:1000:14000);
                if flag
                    X0 = cord_1;
                end
            elseif length(nums) == 3
                if ~isempty(X0)
                    [cord_2, dop, nev, flag] = coord_solver2D(y(nums',i)*config.c, config.posts(:,nums'), X0([1 2 4]), X0(3));
                    cord_1 = [cord_2(1:2); X0(3); cord_2(3)];
                else
                    flag = 0;
                end
            end
            
            if flag
                k = k + 1;
                cord(:,k) = cord_1;
            end
        end
    end
    
    try
        hei = mean(cord(3,:));
        cord(3,:) = [];
    catch
        X = 0;
        hei = 0;
        flag = 0;
        return
    end
    
    k = 0;
    while 1
        k = k + 1;
        if norm(cord(1:2,k) - X0(1:2)) > 10000
            cord(:,k) = [];
            k = k - 1;
        end
        if k >= size(cord,2)
            break;
        end
    end
    
    N = size(cord, 2);
    T = cord(3,:)/config.c*1e-9;
    T = T - min(T);
    X = cord(1,:);
    Y = cord(2,:);
    
    A(1,1) = N;
    A(1,2) = 0;
    A(2,2) = 0;
    for i = 1:N
    A(1,2) = A(1,2) + T(i);
    A(2,2) = A(2,2) + T(i)^2;
    end
    A(2,1) = A(1,2);
    
    bx = [0;0];
    by = [0;0];
    for i = 1:N
        bx(1) = bx(1) + X(i);
        bx(2) = bx(2) + T(i)*X(i);
        by(1) = by(1) + Y(i);
        by(2) = by(2) + T(i)*Y(i);
    end
    ax = A\bx;
    ay = A\by;
    X = [ax(1);ax(2);ay(1);ay(2)];
    flag = 1;
    
end

