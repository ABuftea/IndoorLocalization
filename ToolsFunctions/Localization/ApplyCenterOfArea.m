function [PositionX, PositionY] = ApplyCenterOfArea (Area)
   
Xcoordinates = Area(1:4);
Ycoordinates = Area (5:8);

PositionX = min(Xcoordinates)+(max(Xcoordinates)-min(Xcoordinates))/2;
PositionY = min(Ycoordinates)+(max(Ycoordinates)-min(Ycoordinates))/2;



end 