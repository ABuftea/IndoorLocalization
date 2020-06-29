% This function generates the point whose position shoud be calculated
function [TrackPointsX, TrackPointsY] = GenerateTrackingPoints(x_min, x_max, y_min, y_max, FixedPointsX, FixedPointsY, NumberOfPoints, minAlowableDistance) 
    
    % Defining random generator with seed in order to be able to repeat the experiment
    rng(1,'twister');
    
    % Inline function, generates a random number between [a and b]
    RandomGeneratorX = @(x_min,x_max) (x_max-x_min)*rand()+x_min;
    RandomGeneratorY = @(y_min,y_max) (y_max-y_min)*rand()+y_min;
    
    % Array that have the positions of the tracking points
    TrackPointsX = [];
    TrackPointsY = [];
    
    while length(TrackPointsX) < NumberOfPoints
        % Generating Oone point
        RandomPointX = RandomGeneratorX(x_min,x_max);
        RandomPointY = RandomGeneratorY(y_min,y_max);
       
        % Checking that the car was places in a corect position, not to close from columns
        Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, RandomPointX, RandomPointY);
        % Getting the samllest distance between al of them
        minDistance = min(Distances);
        
        if minDistance >= minAlowableDistance
           TrackPointsX = [TrackPointsX RandomPointX];
           TrackPointsY = [TrackPointsY RandomPointY];
        end
        
    end 
  
    
end