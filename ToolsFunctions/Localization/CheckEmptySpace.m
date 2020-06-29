function [EmptySpace] = CheckEmptySpace (Circle1, Circle2, Circle3)

[Xcross12,Ycross12] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
[Xcross13,Ycross13] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
[Xcross23,Ycross23] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));

PointA1 = [Xcross12(1),Ycross12(1)];
PointB1 = [Xcross12(2),Ycross12(2)];
PointA2 = [Xcross13(1), Ycross13(1)];
PointB2 = [Xcross13(2), Ycross13(2)];
PointA3 = [Xcross23(1), Ycross23(1)];
PointB3 = [Xcross23(2), Ycross23(2)];

EmptySpace = true;

ArrayX1 = [PointA1(1), PointB1(1)];
ArrayX2 = [PointA2(1), PointB2(1)];
ArrayX3 = [PointA3(1), PointB3(1)];

[~,IndexMinX] = min([ArrayX1(1),ArrayX2(1),ArrayX3(1)]);
[~,IndexMaxX] = max([ArrayX1(2),ArrayX2(2),ArrayX3(2)]);

    if(IndexMinX~=IndexMaxX)
        switch IndexMinX
            case 1
                switch IndexMaxX
                    case 2
                        if( (max(ArrayX1)<min(ArrayX3)) && (max(ArrayX3)<min(ArrayX2)) )
                            EmptySpace = true;
                        end
                    case 3
                        if( (max(ArrayX1)<min(ArrayX2)) && (max(ArrayX2)<min(ArrayX3)) )
                            EmptySpace = true;
                        end
                end 
            case 2
                switch IndexMaxX
                    case 1
                        if( (max(ArrayX2)<min(ArrayX3)) && (max(ArrayX3)<min(ArrayX1)) )
                            EmptySpace = true;
                        end
                    case 3
                        if( (max(ArrayX2)<min(ArrayX1)) && (max(ArrayX1)<min(ArrayX3)) )
                            EmptySpace = true;
                        end
                end 
            case 3
                switch IndexMaxX
                    case 1
                        if( (max(ArrayX3)<min(ArrayX2)) && (max(ArrayX2)<min(ArrayX1)) )
                            EmptySpace = true;
                        end
                    case 2
                        if( (max(ArrayX3)<min(ArrayX1)) && (max(ArrayX1)<min(ArrayX2)) )
                            EmptySpace = true;
                        end
                end        
        end
    end

ArrayY1 = [PointA1(2), PointB1(2)];
ArrayY2 = [PointA2(2), PointB2(2)];
ArrayY3 = [PointA3(2), PointB3(2)];

[~,IndexMinY] = min([ArrayY1(1),ArrayY2(1),ArrayY3(1)]);
[~,IndexMaxY] = max([ArrayY1(2),ArrayY2(2),ArrayY3(2)]);

    if(IndexMinY~=IndexMaxY)
        switch IndexMinY
            case 1
                switch IndexMaxY
                    case 2
                        if( (max(ArrayY1)<min(ArrayY3)) && (max(ArrayY3)<min(ArrayY2)) )
                            EmptySpace = true;
                        end
                    case 3
                        if( (max(ArrayY1)<min(ArrayY2)) && (max(ArrayY2)<min(ArrayY3)) )
                            EmptySpace = true;
                        end
                end 
            case 2
                switch IndexMaxY
                    case 1
                        if( (max(ArrayY2)<min(ArrayY3)) && (max(ArrayY3)<min(ArrayY1)) )
                            EmptySpace = true;
                        end
                    case 3
                        if( (max(ArrayY2)<min(ArrayY1)) && (max(ArrayY1)<min(ArrayY3)) )
                            EmptySpace = true;
                        end
                end 
            case 3
                switch IndexMaxY
                    case 1
                        if( (max(ArrayY3)<min(ArrayY2)) && (max(ArrayY2)<min(ArrayY1)) )
                            EmptySpace = true;
                        end
                    case 2
                        if( (max(ArrayY3)<min(ArrayY1)) && (max(ArrayY1)<min(ArrayY2)) )
                            EmptySpace = true;
                        end
                end        
        end
    end

end