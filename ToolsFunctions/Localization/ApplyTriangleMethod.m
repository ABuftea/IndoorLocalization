function [PositionX, PositionY] = ApplyTriangleMethod (Circle1, Circle2, Circle3)

[Xcross12,Ycross12] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
[Xcross13,Ycross13] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
[Xcross23,Ycross23] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));

PointA1 = [Xcross12(1),Ycross12(1)];
PointB1 = [Xcross12(2),Ycross12(2)];
PointA2 = [Xcross13(1), Ycross13(1)];
PointB2 = [Xcross13(2), Ycross13(2)];
PointA3 = [Xcross23(1), Ycross23(1)];
PointB3 = [Xcross23(2), Ycross23(2)];

Triangle1 = polyshape([PointA1(1) PointA2(1) PointA3(1)],[PointA1(2) PointA2(2) PointA3(2)]);
Triangle2 = polyshape([PointA1(1) PointA2(1) PointB3(1)],[PointA1(2) PointA2(2) PointB3(2)]);
Triangle3 = polyshape([PointA1(1) PointB2(1) PointA3(1)],[PointA1(2) PointB2(2) PointA3(2)]);
Triangle4 = polyshape([PointA1(1) PointB2(1) PointB3(1)],[PointA1(2) PointB2(2) PointB3(2)]);
Triangle5 = polyshape([PointB1(1) PointA2(1) PointA3(1)],[PointB1(2) PointA2(2) PointA3(2)]);
Triangle6 = polyshape([PointB1(1) PointA2(1) PointB3(1)],[PointB1(2) PointA2(2) PointB3(2)]);
Triangle7 = polyshape([PointB1(1) PointB2(1) PointA3(1)],[PointB1(2) PointB2(2) PointA3(2)]);
Triangle8 = polyshape([PointB1(1) PointB2(1) PointB3(1)],[PointB1(2) PointB2(2) PointB3(2)]);

Areas= [area(Triangle1), area(Triangle2), area(Triangle3), area(Triangle4), area(Triangle5), area(Triangle6), area(Triangle7), area(Triangle8)];
[~,index] = min(Areas);

    switch (index)
        case 1
            [PositionX, PositionY] = centroid(Triangle1); 
        case 2
            [PositionX, PositionY] = centroid(Triangle2);      
        case 3
            [PositionX, PositionY] = centroid(Triangle3);       
        case 4
            [PositionX, PositionY] = centroid(Triangle4);         
        case 5
            [PositionX, PositionY] = centroid(Triangle5);       
        case 6
            [PositionX, PositionY] = centroid(Triangle6);         
        case 7
            [PositionX, PositionY] = centroid(Triangle7);         
        case 8
            [PositionX, PositionY] = centroid(Triangle8);
    end
    
end