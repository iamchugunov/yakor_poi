function [list_frames3] = Imp3posts(Frames)
%Определяет список Frames, в которых импульсы пришли на 3 поста, НО НЕ
%отождествились в логе между собой совсем

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
            
           if isempty(Frames(i).matches)==1 
                
                    list_frames3(j,1) = i;
                    j=j+1;
           end
           
        end

    end
end

