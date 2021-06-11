function [] = plot_freq_T(Frames, range1)
figure()
hold on
    for i = 1:length(range1)
        N = range1(i);
        
       if ~isempty(Frames(N).Post1)
           stem([Frames(N).Post1.T],[Frames(N).Post1.freq],'.r')
       end
       if ~isempty(Frames(N).Post2)
           stem([Frames(N).Post2.T],[Frames(N).Post2.freq],'.g')
       end
       if ~isempty(Frames(N).Post3)
           stem([Frames(N).Post3.T],[Frames(N).Post3.freq],'.b')
       end
       if ~isempty(Frames(N).Post4)
           stem([Frames(N).Post4.T],[Frames(N).Post4.freq],'.k')
       end
    end
end

