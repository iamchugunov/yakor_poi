function [out_rd, matches, time] = make_identity(frame,rd,rd_num)
    
    matches = zeros(4,1);
    
    switch rd_num
        case '21'
            n1 = 1;
            n2 = 2;
            imps1 = frame.Post1;
            imps2 = frame.Post2;
        case '31'
            n1 = 1;
            n2 = 3;
            imps1 = frame.Post1;
            imps2 = frame.Post3;
        case '41'
            n1 = 1;
            n2 = 4;
            imps1 = frame.Post1;
            imps2 = frame.Post4;
        case '32'
            n1 = 2;
            n2 = 3;
            imps1 = frame.Post2;
            imps2 = frame.Post3;
        case '42'
            n1 = 2;
            n2 = 4;
            imps1 = frame.Post2;
            imps2 = frame.Post4;
        case '43'
            n1 = 3;
            n2 = 4;
            imps1 = frame.Post3;
            imps2 = frame.Post4;
    end
    out_rd = [];
    time = [];
    k = 0;
    for i = 1:length(imps1)
        for j = 1:length(imps2)
            if abs(imps1(i).uT + rd/299792458 * 1e9 - imps2(j).uT) < 500
                k = k + 1;
                matches([n1 n2],k) = [i;j];
                out_rd(k) = (imps2(j).T - imps1(i).T) * 299792458;
                time(k) = imps1(i).T;
            end
        end
    end
end

