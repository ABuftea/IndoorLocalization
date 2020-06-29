% This funtion plot all the columns points and the trackingpoint
function PlotSpace(x_min, x_max, y_min, y_max, FixedPointsX, FixedPointsY, TrackPointX , TrackPointY)

VectorX = [FixedPointsX TrackPointX];  
VectorY = [FixedPointsY TrackPointY];

lastElement = length(VectorX);

plot(VectorX, VectorY, 'b*')
xlim([x_min x_max])
ylim([y_min y_max])
grid on;
hold on;
scatter(VectorX(lastElement),VectorY(lastElement), 'r')
hold off;


end