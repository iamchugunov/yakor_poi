function [list_frames3] = Iden3posts(Frames)
%Определяет список Frames, где отождествились импульсы с 3-х постов в логе
j=1;
    for i=1:length(Frames)
        ll=0;
        if isempty(Frames(i).Post1)~=1
            ll=ll+1;
        end
        if isempty(Frames(i).Post2)~=1
            ll=ll+1;
        end
        if isempty(Frames(i).Post3)~=1
            ll=ll+1;
        end
        if isempty(Frames(i).Post4)~=1
            ll=ll+1;
        end
        
        
        if ll==3 %именно 3
            
           if isempty(Frames(i).matches)~=1 
                l=0;
                for z=1:4
                    if (Frames(i).matches(z,1))==0
                        l=l+1;
                    end
                end
                if l==1    
                    list_frames3(j,1) = i;
                    j=j+1;
                end
           end
        end
    
            
   
          
        
    end
end

