function [PositionX, PositionY] = ApplyCentroidMethod (Circle1, Circle2, Circle3)

[Xcross12,Ycross12] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
[Xcross13,Ycross13] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
[Xcross23,Ycross23] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));

PointA1 = [Xcross12(1),Ycross12(1)];
PointB1 = [Xcross12(2),Ycross12(2)];
PointA2 = [Xcross13(1), Ycross13(1)];
PointB2 = [Xcross13(2), Ycross13(2)];
PointA3 = [Xcross23(1), Ycross23(1)];
PointB3 = [Xcross23(2), Ycross23(2)];

% Seleccion del primer punto

% Seleccion del sgundo punto

% Seleccion del tercer punto

end