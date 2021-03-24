function [list_frames43] = Iden43posts(Frames)
%Определяет список Frames, импульсы пришли на 4 поста, а отождествилось
%только с 3-х или 2-х постов
j=1;
    for i=1:length(Frames)
        if isempty(Frames(i).Post1)~=1 && isempty(Frames(i).Post2)~=1 && isempty(Frames(i).Post3)~=1 && isempty(Frames(i).Post4)~=1           
            if isempty(Frames(i).matches)~=1
                l=0;
                for z=1:4
                    if (Frames(i).matches(z,1))==0
                        l=l+1;
                    end
                end
                if l>=1    
                    list_frames43(j,1) = i;
                    j=j+1;
                end
            end
            
   
          
        end
    end
end

