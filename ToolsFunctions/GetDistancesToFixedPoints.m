% this function calculates the distance between a array of points and a reference point 
function [Distances] = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, PointX, PointY)
        
        Distances = zeros(1, length(FixedPointsX));
        for i=1:1:length(FixedPointsX)
            Distances(i) = sqrt((FixedPointsX(i)-PointX)^2+(FixedPointsY(i)-PointY)^2);
        end

end