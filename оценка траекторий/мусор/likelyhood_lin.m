function [lnrho] = likelyhood_lin(y, t, sigma, X)
    lnrho = 0;
    for j = 1:length(t)
        lnrho = lnrho + 1/sigma^2 * y(j) * (X(1) + X(2) * t(j)) - 1/2 * 1/sigma^2 * (X(1) + X(2) * t(j))^2;
    end
end

