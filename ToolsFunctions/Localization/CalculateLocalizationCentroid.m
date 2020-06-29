function [PositionX, PositionY] = CalculateLocalizationCentroid (Circle1, Circle2, Circle3)
  
    admissibleError = 0.5;
    
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
    
    if (distance1-Circle3(3)) < admissibleError
        PositionX = x1;
        PositionY = y1;
    elseif (distance2-Circle3(3)) < admissibleError
        PositionX = x2;
        PositionY = y2;
    else
        
        if ( (isnan(Xcross12(1)) && isnan(Xcross12(2))) || (isnan(Xcross13(1)) && isnan(Xcross13(2))) || (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
            [Circle1, Circle2, Circle3] = MakeCirclesCross (Circle1, Circle2, Circle3);
        end
        [PositionX, PositionY] = ApplyTriangleMethod(Circle1, Circle2, Circle3);
    end
 
end