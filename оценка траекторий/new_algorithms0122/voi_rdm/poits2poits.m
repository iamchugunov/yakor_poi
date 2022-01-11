function [poits] = poits2poits(Poits, config)
    poits = struct('Frame',[],'Smode',[],'freq',[],'coords',[],'dop',[],'count',[],'ToA',[],'rd',[]);
    for i = 1:length(Poits)
         poit = [];
         poit.Frame = Poits(1,i);
         poit.Smode = Poits(6,i);
         poit.freq = Poits(7,i);
         poit.coords = [0;0;0];
         poit.dop = 0;
         toa = Poits(2:5,i);
         poit.count = length(find(toa > 0));
         poit.ToA = Poits(2:5,i);
         poit.rd = [0;0;0;0;0;0];
         
         if (toa(4) > 0 && toa(1) > 0)
             poit.rd(1) = (toa(4) - toa(1))*config.c_ns;
         end
         if (toa(4) > 0 && toa(2) > 0)
             poit.rd(2) = (toa(4) - toa(2))*config.c_ns;
         end
         if (toa(4) > 0 && toa(3) > 0)
             poit.rd(3) = (toa(4) - toa(3))*config.c_ns;
         end
         if (toa(3) > 0 && toa(1) > 0)
             poit.rd(4) = (toa(3) - toa(1))*config.c_ns;
         end
         if (toa(3) > 0 && toa(2) > 0)
             poit.rd(5) = (toa(3) - toa(2))*config.c_ns;
         end
         if (toa(2) > 0 && toa(1) > 0)
             poit.rd(6) = (toa(2) - toa(1))*config.c_ns;
         end
         poits(i) = poit;
    end
end

