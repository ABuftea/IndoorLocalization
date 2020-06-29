% This functions returns the position of the object, based on distance and closest fixed points

function [PositionX, PositionY] = CalculateLocalizationTheory (ClosestPointsX, ClosestPointsY, ClosestDistances)

Circle1 = [ClosestPointsX(1) ClosestPointsY(1) ClosestDistances(1)];
Circle2 = [ClosestPointsX(2) ClosestPointsY(2) ClosestDistances(2)];   
Circle3 = [ClosestPointsX(3) ClosestPointsY(3) ClosestDistances(3)];

admissibleDeviation = 0.3;

[Xcross12,Ycross12] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
[Xcross13,Ycross13] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
[Xcross23,Ycross23] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));


    if( (isnan(Xcross12(1)) && isnan(Xcross12(2))) || (isnan(Xcross13(1)) && isnan(Xcross13(2))) || (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
    % If this happens, we do the triangularization    
        x1 = Circle1(1);
        y1 = Circle1(2); 
        x2 = Circle2(1);
        y2 = Circle2(2);
        x3 = Circle3(1);
        y3 = Circle3(2);
        Triangle = polyshape([x1 x2 x3],[y1 y2 y3]);
        [PositionX, PositionY] = centroid(Triangle);
    else

        x1 = Xcross12(1); 
        y1 = Ycross12(1);
        x2 = Xcross12(2);
        y2 = Ycross12(2);

        dx1= abs(Circle3(1)-x1);
        dy1 = abs(Circle3(2)-y1);
        distance1 = sqrt((dx1)^2+(dy1)^2);

        dx2= abs(Circle3(1)-x2);
        dy2 = abs(Circle3(2)-y2);
        distance2 = sqrt((dx2)^2+(dy2)^2);


            if (distance1-Circle3(3)) < admissibleDeviation
                PositionX = x1;
                PositionY = y1;
            elseif (distance2-Circle3(3)) < admissibleDeviation
                 PositionX = x2;
                 PositionY = y2;
            else
                % Here we should Apply the max min method
                x1 = Circle1(1);
                y1 = Circle1(2);
                r1 = Circle1(3);
                x2 = Circle2(1);
                y2 = Circle2(2);
                r2 = Circle2(3);
                x3 = Circle3(1);
                y3 = Circle3(2);
                r3 = Circle3(3);
                Xmin = max([x1-r1, x2-r2, x3-r3]);
                Xmax = min([x1+r1, x2+r2, x3+r3]);
                Ymin = max([y1-r1, y2-r2, y3-r3]);
                Ymax = min([y1+r1, y2+r2, y3+r3]);

                PositionX = (Xmin+Xmax)/2;
                PositionY = (Ymin+Ymax)/2;
            end    
    end
    
end 


