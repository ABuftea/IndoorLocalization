function [MaxPositionError, MeanPositionError, MinPositionError] = CalculateErrorsPerDensity (TrackPointsX, TrackPointsY, EstimateTrackPointsX, EstimateTrackPointsY)

PositionErrors = CalculatePositionErrors(TrackPointsX, TrackPointsY, EstimateTrackPointsX, EstimateTrackPointsY);

MaxPositionError = max(PositionErrors);
MeanPositionError = mean(PositionErrors);
MinPositionError = min(PositionErrors);

end 