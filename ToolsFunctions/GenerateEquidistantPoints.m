function [FixedPointsX, FixedPointsY] = GenerateEquidistantPoints (x_min, x_max, y_min, y_max, NumberOfPoints)

NumDivisors = divisors(NumberOfPoints);
DivisorSelected = round((length(NumDivisors)/2));
Ydivisor = NumDivisors(DivisorSelected);
Xdivisor = NumberOfPoints/Ydivisor;

SeparationPointsX = linspace(x_min, x_max, Xdivisor+1);
SeparationPointsY = linspace(y_min, y_max, Ydivisor+1);
    
    FixedPointsY = zeros(1,length(SeparationPointsY)*length(SeparationPointsY));
    sumTermY=0;
    for i=2:1:length(SeparationPointsY)
        FixedPointsY(i-1) = (((SeparationPointsY(i)-SeparationPointsY(i-1))/2)+sumTermY);
        sumTermY = sumTermY + (SeparationPointsY(i)-SeparationPointsY(i-1));
    end 
    FixedPointsY = FixedPointsY(FixedPointsY~=0);
    FixedPointsY = repmat(FixedPointsY, Xdivisor+2);
    FixedPointsY = FixedPointsY(1:1,:);
    
    disalignment = 0.001;
    for i=1:1:length(FixedPointsY)
    disalignment = disalignment*(-1);
    FixedPointsY(i) = FixedPointsY(i)+disalignment;
    end 
    
    FixedPointsX = zeros(1,length(SeparationPointsX)*length(SeparationPointsX));
    sumTermX=0;
    for i=2:1:length(SeparationPointsX)
    FixedPointsX(i-1) = (((SeparationPointsX(i)-SeparationPointsX(i-1))/2)+sumTermX);
    sumTermX = sumTermX+(SeparationPointsX(i)-SeparationPointsX(i-1));
    end
    FixedPointsX = FixedPointsX(FixedPointsX~=0);
    FixedPointsX = [x_min FixedPointsX x_max];
    FixedPointsX = repelem(FixedPointsX, Ydivisor);
    
    disalignment = 0.001;
    for i=1:1:length(FixedPointsX)
    disalignment = disalignment*(-1);
    FixedPointsX(i) = FixedPointsX(i)+disalignment;
    end 
    
    
end