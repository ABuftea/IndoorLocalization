% This function creates the vectors containing the positions of the columns
function[FixedPointsX, FixedPointsY] = GenerateFixedPoints(x_max, x_min, y_max, y_min, NumberOfPoints, minAlowableDistance )
        
    % Defining random generator with seed in order to be able to repeat the experiment
    rng(1,'twister');

    % Inline function, generates a random number between [a and b]
    RandomGeneratorX = @(x_min,x_max) (x_max-x_min)*rand()+x_min;
    RandomGeneratorY = @(y_min,y_max) (y_max-y_min)*rand()+y_min;

    % Array that have the positions of the columns
    FixedPointsX = [];
    FixedPointsY = [];

    % Adding the first element to the columns position 
    RandomNumX = RandomGeneratorX(x_min,x_max);
    FixedPointsX = [FixedPointsX RandomNumX];

    RandomNumY = RandomGeneratorY(y_min,y_max);
    FixedPointsY = [FixedPointsY RandomNumY];

    while length(FixedPointsX) < NumberOfPoints
        % Generating a random number between a and b
        RandomNumX = RandomGeneratorX(x_min,x_max);
        RandomNumY = RandomGeneratorY(y_min,y_max);
        % Verifying how far is that number from the ones generated before 
        Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, RandomNumX, RandomNumY);
        minDistance = min(Distances);

        % If the distance meets the criteria, we can add a collumn there
        if minDistance >= minAlowableDistance
           FixedPointsX = [FixedPointsX RandomNumX];
           FixedPointsY = [FixedPointsY RandomNumY];
        end

    end
    
    
end 