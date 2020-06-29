function [PositionX, PositionY] = CalculateLocalization (Circle1, Circle2, Circle3)

    admissibleDeviation = 0.3;
    admissibleIncrement = 0.95;
    
    [Xcross12,Ycross12] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
    [Xcross13,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
    [Xcross23,~] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));
        
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
    
    if abs((distance1-Circle3(3))) < admissibleDeviation
        PositionX = x1;
        PositionY = y1;
    elseif abs((distance2-Circle3(3))) < admissibleDeviation
        PositionX = x2;
        PositionY = y2;
    else
        
        if ( (isnan(Xcross12(1)) && isnan(Xcross12(2))) || (isnan(Xcross13(1)) && isnan(Xcross13(2))) || (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
        [Circle1b, Circle2b, Circle3b] = MakeCirclesCross (Circle1, Circle2, Circle3);
            
            if( ((Circle1b(3)-Circle1(3))>admissibleIncrement) || ((Circle2b(3)-Circle2(3))>admissibleIncrement || ((Circle3b(3)-Circle3(3))>admissibleIncrement)) )
                    [Area] = GetRectanglesArea(Circle1b, Circle2b, Circle3b);
                    if( isempty(Area) )
                        [PositionX, PositionY] = ApplyTriangleMethod(Circle1b, Circle2b, Circle3b);
                    else
                        [PositionX, PositionY] = ApplyCenterOfArea(Area);
                    end
            else 
                [PositionX, PositionY] = ApplyTriangleMethod(Circle1b, Circle2b, Circle3b);
            end
        else
        [PositionX, PositionY] = ApplyTriangleMethod(Circle1, Circle2, Circle3);
        end
    end
end 