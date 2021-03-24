function [list_frames4] = Imp4posts(Frames)
%Определяет список Frames, в которых импульсы пришли на 4 поста, НО НЕ
%отождествились в логе между собой совсем
j=1;
    for i=1:length(Frames)
        if isempty(Frames(i).Post1)~=1 && isempty(Frames(i).Post2)~=1 && isempty(Frames(i).Post3)~=1 && isempty(Frames(i).Post4)~=1           
            if isempty(Frames(i).matches)==1  
                    list_frames4(j,1) = i;
                    j=j+1;
            end
        end
            
   
    end
    
end

