function TrackPath(x_min, x_max, y_min, y_max, PositionsX, PositionsY)

       
    if length(PositionsX) == 1
        
        plot(PositionsX,PositionsY)

    elseif length(PositionsX) >= 2
        
         for i=2:1:length(PositionsX)
            plot([PositionsX(i-1) PositionsY(i-1)], [PositionsX(i) PositionsY(i)])
            hold on
         end 
        
    else
        disp('Position could not be tracked')
    end
        
    
end 