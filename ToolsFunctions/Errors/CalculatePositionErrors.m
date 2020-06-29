function [PositionErrors] = CalculatePositionErrors (PositionsX, PositionsY, EstimatePositionsX, EstimatePositionsY)
    
    PositionErrors = zeros(1,length(PositionsX));

    for i=1:1:length(PositionsX)
        PositionError = sqrt((EstimatePositionsX(i)-PositionsX(i))^2+(EstimatePositionsY(i)-PositionsY(i))^2);
        PositionErrors(i) = PositionError;
    end 
    
   
end 