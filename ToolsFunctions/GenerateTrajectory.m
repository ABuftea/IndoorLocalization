function [TrajectoryX, TrajectoryY] = GenerateTrajectory (x_low, x_high, y_low, y_high, FixedPointsX, FixedPointsY, StartPointX, StartPointY, DestinationX, DestinationY)

increment = 1;
minAllowableDistance = 0.5;
AllowableError = 0.3;

TrajectoryX = [];
TrajectoryY = [];

distanceX = StartPointX-DestinationX;
distanceY = StartPointY-DestinationY;
distance = sqrt(distanceX^2+distanceY^2);

    while (distance > (sqrt((AllowableError)^2+(AllowableError)^2)))
    % Move the Y direction
        while (StartPointY > (DestinationY-AllowableError) || StartPointY < (DestinationY-AllowableError) )
            if (StartPointY < DestinationY)
                NextPositionY = StartPointY + increment;
                NextPositionX = StartPointX;
                Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                minDistance = min(Distances);

                    if minDistance < minAllowableDistance

                        NextPositionX = StartPointX+increment;
                        Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                        minDistance = min(Distances);
                            if minDistances < minAllowableDistance
                               NextPositionX = StartPointX-Increment;
                            end 
                     end 

            elseif (StartPointY > DestinationY)
                NextPositionY = StartPointY - increment;
                NextPositionX = StartPointX;
                Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                minDistance = min(Distances);

                    if minDistance < minAllowableDistance

                        NextPositionX = StartPointX+increment;
                        Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                        minDistance = min(Distances);
                            if minDistances < minAllowableDistance
                               NextPositionX = StartPointX-increment;
                            end 
                     end 
            end 
            TrajectoryX = [TrajectoryX NextPositionX];
            TrajectoryY = [TrajectoryY NextPositionY];
            StartPointX = NextPositionX;
            StartPointY = NextPositionY;
        end

    % Move the X direction
        while (StartPointX > (DestinationY-AllowableError) || StartPointX < (DestinationY-AllowableError) )
            if (StartPointX < DestinationX)
                NextPositionX = StartPointX + increment;
                NextPositionY = StartPointY;
                Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                minDistance = min(Distances);

                    if minDistance < minAllowableDistance

                        NextPositionY = StartPointY+increment;
                        Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                        minDistance = min(Distances);
                            if minDistances < minAllowableDistance
                               NextPositionY = StartPointY-increment;
                            end 
                    end 

            elseif (StartPointX > DestinationX)
                NextPositionX = StartPointX - increment;
                NextPositionY = StartPointY;
                Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                minDistance = min(Distances);

                    if minDistance < minAllowableDistance

                        NextPositionY = StartPointY+increment;
                        Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, NextPositionX, NextPositionY);
                        minDistance = min(Distances);
                            if minDistances < minAllowableDistance
                               NextPositionY = StartPointY-increment;
                            end 
                     end 
            end 
            TrajectoryX = [TrajectoryX NextPositionX];
            TrajectoryY = [TrajectoryY NextPositionY];
            StartPointX = NextPositionX;
            StartPointY = NextPositionY;
        end

    end 
end