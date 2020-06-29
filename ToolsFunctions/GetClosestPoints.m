% This function returns the position and the distance for the three closest points to the point we track 
function [ClosestPointsX, ClosestPointsY, ClosestDistances, EstimateDistances] = GetClosestPoints (EmittedSignal, LossFactor, FixedPointsX, FixedPointsY, TrackPointX, TrackPointY)
    
    syms estimate;

    % Computing Distances between car and rest 
    Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, TrackPointX, TrackPointY);
    Distances(Distances==0) = 1;
        
    % Adding Kind of Error to loss factor, let's say 10%, from -5% to +5% 
    rng(1,'twister');
    RandomGenerator = @(min,max) (max-min)*rand()+min; 
    
    % Computing the loss of siganl from the car to the posts
    LossFactors = zeros(1, length(Distances));
    ReceivedSignals = zeros(1, length(Distances)); 
    for i=1:1:length(Distances)
        Error = RandomGenerator(-0.05,0.05);
        RealLossFactor = LossFactor*(1+Error);
        LossFactors(i) = RealLossFactor;
        ReceivedSignal = EmittedSignal*(Distances(i)^(RealLossFactor));
        ReceivedSignals(i) = ReceivedSignal;
    end 
    SortedSignals = sort(ReceivedSignals, 'descend');
    
    % Getting the indexes of the closest columns 
    Indexes = zeros(1,3);
    for i=1:1:3
        Index = find(ReceivedSignals == SortedSignals(i));
        Indexes(i) = Index;
    end
    
    % Finally, we found what three columns are closer to the car broda
    ClosestPointsX = zeros(1,3);
    ClosestPointsY = zeros(1,3);
    for i=1:1:3
        ClosestPointsX(i) = FixedPointsX(Indexes(i));
        ClosestPointsY(i) = FixedPointsY(Indexes(i));
    end
    
    ClosestDistances = zeros(1,3);
    for i=1:1:3
        ClosestDistances(i) = Distances(Indexes(i));
    end
    
    % This is not used, made just in case we could use this data for something
    FactorsUsedClosestDistances = zeros(1,3);
     for i=1:1:3
        FactorsUsedClosestDistances(i) = LossFactors(Indexes(i));
     end
  
    % Adding The Error To the distances ass well
    EstimateDistances = zeros(1,3);
    for i=1:1:3
        eqn = SortedSignals(i) == EmittedSignal*(estimate)^(LossFactor);
        EstimateDistance = double(solve(eqn, estimate));
        EstimateDistance = EstimateDistance(EstimateDistance >= 0);
        EstimateDistances(i) = EstimateDistance;
    end 
    
    
end