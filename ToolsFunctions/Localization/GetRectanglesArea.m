function [Area] = GetRectanglesArea (Circle1, Circle2, Circle3)

% First square
x1_1= Circle1(1)-Circle1(3);
x2_1= Circle1(1)+Circle1(3);
y1_1= Circle1(2)+Circle1(3);
y2_1= Circle1(2)-Circle1(3);
Xcoordinates1 = [x1_1, x1_1, x2_1, x2_1];
Ycoordinates1 = [y1_1, y2_1, y2_1, y1_1];
Rectangle1 = polyshape(Xcoordinates1,Ycoordinates1);

%Second Square
x1_2= Circle2(1)-Circle2(3);
x2_2= Circle2(1)+Circle2(3);
y1_2= Circle2(2)+Circle2(3);
y2_2= Circle2(2)-Circle2(3);
Xcoordinates2 = [x1_2, x1_2, x2_2, x2_2];
Ycoordinates2 = [y1_2, y2_2, y2_2, y1_2];
Rectangle2 = polyshape(Xcoordinates2,Ycoordinates2);

%Third Square
x1_3= Circle3(1)-Circle3(3);
x2_3= Circle3(1)+Circle3(3);
y1_3= Circle3(2)+Circle3(3);
y2_3= Circle3(2)-Circle3(3);
Xcoordinates3 = [x1_3, x1_3, x2_3, x2_3];
Ycoordinates3 = [y1_3, y2_3, y2_3, y1_3];
Rectangle3 = polyshape(Xcoordinates3,Ycoordinates3);

Rectangles = [Rectangle1, Rectangle2, Rectangle3];
Area = intersect(Rectangles);
Area = Area.Vertices;

end



