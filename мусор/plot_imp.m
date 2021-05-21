function [] = plot_imp(imp, col)
    rectangle('Position',[imp.T 0 imp.dur/1e8 imp.freq],'EdgeColor',col)
end

