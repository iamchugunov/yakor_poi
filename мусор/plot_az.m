function [] = plot_az(res, az)
    cords = [];
    for i = 1:length(res)
        if az == res(i).az
            cords = [cords res(i).pos];
        end
    end
    plot(cords(1,:),cords(2,:),'x')
end

