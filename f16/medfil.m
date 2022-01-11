function [out] = medfil(in)
    
    out = in;
    
	for i = 2:length(in)-1
	
		first = in(i-1);
		second = in(i);
		third = in(i+1);

		if ((first <= second) && (first <= third))
			if (second <= third) 
                out(i) = second;
            else
                out(i) = third;
            end
        end
                
		

		if ((second <= first) && (second <= third))
		
			if (first <= third) 
                out(i) = first;
            else
                out(i) = third;
            end
        end

		if ((third <= first) && (third <= second))
		
			if (first <= second) 
                out(i) = first;
            else
                out(i) = second;
            end
        end
    end
    
end

